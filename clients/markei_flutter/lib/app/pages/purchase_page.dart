import '../../l10n/marc_localizations.dart';
import 'package:flutter/material.dart';

import '../../application/app_failure.dart';
import '../../application/catalogue_queries.dart';
import '../../application/purchase_pricing.dart';
import '../../application/local_references.dart';
import '../../application/purchase_occurrence.dart';
import '../../application/register_purchase.dart';
import '../../domain/catalogue/product.dart';
import '../../domain/catalogue/product_code.dart';
import '../../domain/purchase/purchase.dart';
import '../../domain/references/local_reference.dart';
import '../../domain/shared/ids.dart';
import '../../domain/shared/money.dart';
import '../../domain/shared/quantity.dart';
import '../../domain/store/store.dart';
import '../design/markei_theme.dart';
import '../widgets/markei_components.dart';
import '../widgets/purchase_input_formatters.dart';
import '../widgets/quantity_unit_picker.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({
    required this.accountId,
    required this.deviceId,
    required this.registration,
    required this.catalogueQueries,
    required this.references,
    required this.refreshSignal,
    required this.onRegistered,
    super.key,
  });

  final AccountId accountId;
  final DeviceId deviceId;
  final PurchaseRegistrationRepository registration;
  final CatalogueQueryRepository catalogueQueries;
  final LocalReferenceRepository references;
  final int refreshSignal;
  final VoidCallback onRegistered;

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final _purchaseDateController = TextEditingController();
  final _purchaseTimeController = TextEditingController();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _packageAmountController = TextEditingController(text: '1');
  final _packageUnitController = TextEditingController(text: 'kg');
  final _purchasedAmountController = TextEditingController(text: '1');
  final _purchasedUnitController = TextEditingController(text: 'kg');
  final _packageCountController = TextEditingController(text: '1');
  final _pricePerUnitController = TextEditingController();
  final _lineTotalController = TextEditingController();
  final _comparablePriceController = TextEditingController();
  PurchasePriceSource? _priceSource;
  String? _pricingError;
  final List<_DraftLine> _lines = [];
  List<Product> _products = const [];
  List<Store> _stores = const [];
  List<LocalReference> _people = const [];
  List<LocalReference> _paymentMethods = const [];
  List<ProductSimilarityWarning> _warnings = const [];
  String? _selectedProductId;
  String? _selectedStoreId;
  LocalReference? _selectedPerson;
  LocalReference? _selectedPaymentMethod;
  bool _loading = true;
  bool _reviewing = false;
  bool _submitting = false;
  bool _bulk = false;
  int? _editingKey;
  ProductReference? _editingReference;
  String? _editingProductLabel;
  ProductMode? _editingProductMode;
  MeasurementKind? _editingMeasurementKind;
  int _nextKey = 1;
  _PurchaseFeedback? _feedback;

  int get _stagedTotalMinorUnits {
    return _lines.fold<int>(
      0,
      (total, line) => total + line.item.lineTotal.minorUnits,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCatalogue();
  }

  @override
  void didUpdateWidget(covariant PurchasePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshSignal != widget.refreshSignal) {
      _loadCatalogue(clearFeedback: false);
    }
  }

  @override
  void dispose() {
    _purchaseDateController.dispose();
    _purchaseTimeController.dispose();
    _codeController.dispose();
    _nameController.dispose();
    _brandController.dispose();
    _packageAmountController.dispose();
    _packageUnitController.dispose();
    _purchasedAmountController.dispose();
    _purchasedUnitController.dispose();
    _packageCountController.dispose();
    _pricePerUnitController.dispose();
    _lineTotalController.dispose();
    _comparablePriceController.dispose();
    super.dispose();
  }

  Future<void> _loadCatalogue({bool clearFeedback = true}) async {
    setState(() => _loading = true);
    try {
      final products = await widget.catalogueQueries.listProducts(
        widget.accountId,
      );
      final stores = await widget.catalogueQueries.listStores(widget.accountId);
      final people = await widget.references.listReferences(
        widget.accountId,
        LocalReferenceKind.person,
      );
      final paymentMethods = await widget.references.listReferences(
        widget.accountId,
        LocalReferenceKind.paymentMethod,
      );
      if (!mounted) {
        return;
      }
      final projection = _normalizedProductProjection(products);
      final selectedProductState = _selectionState(
        projection.products,
        _selectedProductId,
      );
      final selectedProductInvalidated =
          _selectedProductId != null && selectedProductState.product == null;
      final previousStoreId = _selectedStoreId;
      final selectedStoreStillAvailable =
          previousStoreId != null &&
          stores.any((store) => store.id.value == previousStoreId);
      final selectedStoreInvalidated =
          previousStoreId != null && !selectedStoreStillAvailable;
      setState(() {
        _products = projection.products;
        _stores = stores;
        _people = people;
        _paymentMethods = paymentMethods;
        if (selectedProductInvalidated) {
          _clearSelectedProduct();
        }
        if (selectedStoreInvalidated) {
          _selectedStoreId = null;
        }
        _loading = false;
        if (projection.conflictedProductId != null) {
          _feedback = _PurchaseFeedback.error(
            'product-selection-conflict: Product projection contains conflicting repeated IDs. Refresh Catalogue before choosing that Product.',
          );
        } else if (selectedProductState.multiple) {
          _clearSelectedProduct();
          _feedback = _PurchaseFeedback.error(
            'product-selection-invalidated: Selected Product is ambiguous in the current projection. Choose a Product again.',
          );
        } else if (selectedProductInvalidated) {
          _feedback = _PurchaseFeedback.error(
            'product-selection-invalidated: Selected Product is no longer available for this account. Choose a Product again.',
          );
        } else if (selectedStoreInvalidated) {
          _feedback = _PurchaseFeedback.error(
            'store-selection-invalidated: Selected Store is no longer available for this account. Choose a Store again.',
          );
        } else if (clearFeedback) {
          _feedback = null;
        }
      });
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _feedback = _PurchaseFeedback.error(
          'Products and Stores could not be loaded. Try again.',
        );
      });
    }
  }

  Future<bool> _checkSimilarProducts() async {
    try {
      final warnings = await widget.catalogueQueries.similarityWarnings(
        widget.accountId,
        _productDraft(),
      );
      if (!mounted) return false;
      setState(() {
        _warnings = warnings;
        _feedback = warnings.isEmpty
            ? _PurchaseFeedback.success('No similar Product found.')
            : _PurchaseFeedback.success(
                'Similar Product found. Choose a Product or create anyway.',
              );
      });
      return true;
    } on Object {
      if (!mounted) return false;
      setState(
        () => _feedback = _PurchaseFeedback.error(
          'Check the Product details and try again.',
        ),
      );
      return false;
    }
  }

  Future<void> _stageNewProduct({required bool createAnyway}) async {
    try {
      normalizeProductCode(_codeController.text);
      normalizeProductFacts(_productDraft());
      _inputQuantity();
      if (_comparablePriceController.text.isEmpty) {
        throw FormatException(
          _pricingError ??
              'Enter either a unit price or a total price. Marc calculates the other.',
        );
      }
    } on Object catch (error) {
      setState(
        () => _feedback = _PurchaseFeedback.error(_purchaseInputError(error)),
      );
      return;
    }
    if (!createAnyway) {
      final checked = await _checkSimilarProducts();
      if (!checked || _warnings.isNotEmpty) return;
    }
    _stageItem(
      NewProductReference(_productDraft()),
      _newProductLabel(),
      _bulk ? ProductMode.bulk : ProductMode.packaged,
      _selectedMeasurementKind(),
    );
  }

  void _stageExistingProduct(Product product) {
    if (_selectedProductId != product.id.value) {
      _applyProductFacts(product);
    }
    _stageItem(
      ExistingProductReference(product.id),
      product.displayName,
      product.mode,
      product.measurementKind,
    );
  }

  Future<void> _findProductByCode() async {
    try {
      final product = await widget.catalogueQueries.productByCode(
        widget.accountId,
        _codeController.text,
      );
      if (!mounted) {
        return;
      }
      if (product == null) {
        setState(() {
          _clearSelectedProduct();
          _feedback = _PurchaseFeedback.error(
            'No Product matches this exact code. Check details or create a new Product.',
          );
        });
        return;
      }
      setState(() {
        final selected = _selectProductId(product.id.value);
        _feedback = selected == null
            ? _PurchaseFeedback.error(
                'product-selection-invalidated: Found Product is not available in the current Purchase projection. Refresh Catalogue and try again.',
              )
            : _PurchaseFeedback.success(
                'Product facts filled. Add staged Item when ready.',
              );
      });
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _feedback = _PurchaseFeedback.error(
          'Product code lookup failed. Check the code and try again.',
        );
      });
    }
  }

  void _applyProductFacts(Product product) {
    _selectedProductId = product.id.value;
    _bulk = product.mode == ProductMode.bulk;
    _codeController.text = product.userProductCode.displayValue;
    _nameController.text = product.displayName;
    _brandController.text = product.displayBrand;
    final package = product.packageQuantity;
    if (package != null) {
      _packageAmountController.text = package.decimalText;
      _packageUnitController.text = package.unit.name;
      _purchasedUnitController.text = package.unit.name;
    } else {
      // Keep a compatible display unit and amount together (e.g. 2500 g).
      if (measurementKindForDisplayUnit(_purchasedUnitController.text) !=
          product.measurementKind) {
        _purchasedUnitController.text = switch (product.measurementKind) {
          MeasurementKind.mass => 'kg',
          MeasurementKind.volume => 'L',
          MeasurementKind.count => 'un',
        };
        _purchasedAmountController.text = '1';
      }
    }
    _recalculatePrices();
  }

  Product? _selectProductId(String productId) {
    final state = _selectionState(_products, productId);
    final product = state.product;
    if (product == null) {
      _clearSelectedProduct();
      return null;
    }
    _applyProductFacts(product);
    return product;
  }

  void _clearSelectedProduct() {
    _selectedProductId = null;
  }

  void _saveEditedLine() {
    final reference = _editingReference;
    final productLabel = _editingProductLabel;
    final mode = _editingProductMode;
    final kind = _editingMeasurementKind;
    if (_editingKey == null ||
        reference == null ||
        productLabel == null ||
        mode == null ||
        kind == null) {
      setState(() {
        _feedback = _PurchaseFeedback.error(
          'Choose a staged Item to edit before saving.',
        );
      });
      return;
    }
    _stageItem(reference, productLabel, mode, kind);
  }

  void _stageItem(
    ProductReference reference,
    String productLabel,
    ProductMode mode,
    MeasurementKind kind,
  ) {
    try {
      final packageCount = mode == ProductMode.bulk ? null : _packageCount();
      final quantity = _inputQuantity(kind: kind);
      final basis = mode == ProductMode.bulk
          ? _purchasedAmountController.text
          : packageCount.toString();
      if (_priceSource == null) {
        throw const FormatException('Enter a unit price or a total price.');
      }
      final lineTotalMinorUnits = _priceSource == PurchasePriceSource.unitPrice
          ? purchaseLineTotalMinorUnits(
              amount: basis,
              unitPrice: _pricePerUnitController.text,
            )
          : parsePurchaseTotalMinorUnits(_lineTotalController.text);
      final item = PurchaseItemDraft(
        productReference: reference,
        packageCount: packageCount,
        purchasedQuantity: quantity,
        lineTotal: Money(currencyCode: 'BRL', minorUnits: lineTotalMinorUnits),
      );
      setState(() {
        final line = _DraftLine(
          keyValue: _editingKey ?? _nextKey++,
          productLabel: productLabel,
          productMode: mode,
          measurementKind: kind,
          packageQuantity: mode == ProductMode.bulk
              ? null
              : normalizeDisplayQuantity(
                  kind: kind,
                  amount: _packageAmountController.text,
                  unit: _packageUnitController.text,
                ),
          item: item,
        );
        final index = _lines.indexWhere((line) => line.keyValue == _editingKey);
        if (index == -1) {
          _lines.add(line);
        } else {
          _lines[index] = line;
        }
        _clearEditState();
        _warnings = const [];
        _feedback = _PurchaseFeedback.success('Staged Item saved.');
        _clearItemInputs();
      });
    } on Object catch (error) {
      setState(() {
        _feedback = _PurchaseFeedback.error(_purchaseInputError(error));
      });
    }
  }

  void _editLine(_DraftLine line) {
    setState(() {
      _editingKey = line.keyValue;
      _editingReference = line.item.productReference;
      _editingProductLabel = line.productLabel;
      _editingProductMode = line.productMode;
      _editingMeasurementKind = line.measurementKind;
      _bulk = line.productMode == ProductMode.bulk;
      _reviewing = false;
      _lineTotalController.text = _formatMinorUnits(line.item.lineTotal);
      _priceSource = PurchasePriceSource.totalPrice;
      _pricePerUnitController.clear();
      _packageCountController.text = (line.item.packageCount ?? 1).toString();
      _purchasedAmountController.text = line.item.purchasedQuantity.decimalText;
      _purchasedUnitController.text = line.item.purchasedQuantity.unit.name;
      final package = line.packageQuantity;
      if (package != null) {
        _packageAmountController.text = package.decimalText;
        _packageUnitController.text = package.unit.name;
      }
      final reference = line.item.productReference;
      if (reference is NewProductReference) {
        _clearSelectedProduct();
        _codeController.text = reference.productDraft.userCode;
        _nameController.text = reference.productDraft.name;
        _brandController.text = reference.productDraft.brand;
      } else if (reference is ExistingProductReference) {
        _selectProductId(reference.productId.value);
      }
      _recalculatePrices();
      _feedback = _PurchaseFeedback.success('Editing staged Item.');
    });
  }

  void _removeLine(_DraftLine line) {
    setState(() {
      _lines.removeWhere((candidate) => candidate.keyValue == line.keyValue);
      if (_editingKey == line.keyValue) {
        _clearEditState();
      }
      _reviewing = false;
      _feedback = _PurchaseFeedback.success('Staged Item removed.');
    });
  }

  int _packageCount() {
    final raw = _packageCountController.text.trim();
    if (!RegExp(r'^\d+$').hasMatch(raw)) {
      throw const FormatException('Units bought must be a whole number.');
    }
    final count = int.parse(raw);
    if (count <= 0) {
      throw const FormatException('Units bought must be greater than zero.');
    }
    return count;
  }

  NormalizedQuantity _inputQuantity({MeasurementKind? kind}) {
    final measurement = kind ?? _selectedMeasurementKind();
    final quantity = normalizeDisplayQuantity(
      kind: measurement,
      amount: _bulk
          ? _purchasedAmountController.text
          : _packageAmountController.text,
      unit: _bulk ? _purchasedUnitController.text : _packageUnitController.text,
    );
    if (quantity.microunits <= 0) {
      throw const FormatException(
        'Quantity and unit size must be greater than zero.',
      );
    }
    if (_bulk) return quantity;
    final total =
        BigInt.from(quantity.microunits) * BigInt.from(_packageCount());
    if (total > BigInt.from(0x7fffffffffffffff)) {
      throw const FormatException('Quantity is outside the supported range.');
    }
    return NormalizedQuantity(
      kind: quantity.kind,
      unit: quantity.unit,
      microunits: total.toInt(),
    );
  }

  void _previewPrices([PurchasePriceSource? source]) {
    setState(() {
      if (source != null) _priceSource = source;
      _recalculatePrices();
    });
  }

  void _recalculatePrices() {
    _pricingError = null;
    _comparablePriceController.clear();
    if (!_bulk) _purchasedAmountController.clear();
    try {
      final quantity = _inputQuantity();
      if (!_bulk) _purchasedAmountController.text = quantity.decimalText;
      final source = _priceSource;
      if (source == null) return;
      final value = source == PurchasePriceSource.unitPrice
          ? _pricePerUnitController.text
          : _lineTotalController.text;
      if (value.trim().isEmpty) {
        if (source == PurchasePriceSource.unitPrice) {
          _lineTotalController.clear();
        } else {
          _pricePerUnitController.clear();
        }
        return;
      }
      final basis = _bulk
          ? _purchasedAmountController.text
          : _packageCountController.text;
      final total = source == PurchasePriceSource.unitPrice
          ? purchaseLineTotalMinorUnits(amount: basis, unitPrice: value)
          : parsePurchaseTotalMinorUnits(value);
      if (source == PurchasePriceSource.unitPrice) {
        _lineTotalController.text = formatPurchaseTotal(total);
      } else {
        _pricePerUnitController.text = purchaseUnitPriceText(
          amount: basis,
          totalMinorUnits: total,
        );
      }
      _comparablePriceController.text = purchaseUnitPriceText(
        amount: quantity.decimalText,
        totalMinorUnits: total,
      );
    } on Object catch (error) {
      _pricingError = _purchaseInputError(error);
      if (_priceSource == PurchasePriceSource.unitPrice) {
        _lineTotalController.clear();
      } else if (_priceSource == PurchasePriceSource.totalPrice) {
        _pricePerUnitController.clear();
      }
    }
  }

  Future<void> _registerPurchase() async {
    if (_submitting) {
      return;
    }
    final storeValidation = _validateStoreSelection();
    if (storeValidation != null) {
      setState(() => _feedback = _PurchaseFeedback.error(storeValidation));
      return;
    }
    if (_lines.isEmpty) {
      setState(() {
        _feedback = _PurchaseFeedback.error(
          'item-required: Stage at least one Item.',
        );
      });
      return;
    }
    final storeReference = _storeReference();
    DateTime occurrenceTime;
    try {
      occurrenceTime = parsePurchaseOccurrenceUtc(
        PurchaseOccurrenceInput(
          dateText: _purchaseDateController.text,
          timeText: _purchaseTimeController.text,
        ),
      );
    } on FormatException catch (error) {
      setState(() {
        _feedback = _PurchaseFeedback.error(error.message);
      });
      return;
    }
    setState(() {
      _submitting = true;
      _feedback = _PurchaseFeedback.success('Registering purchase locally...');
    });
    try {
      await widget.registration.registerPurchase(
        RegisterPurchaseCommand(
          accountId: widget.accountId,
          deviceId: widget.deviceId,
          storeReference: storeReference,
          occurrenceTime: occurrenceTime,
          currencyCode: 'BRL',
          personId: _selectedPerson?.id,
          paymentMethodId: _selectedPaymentMethod?.id,
          items: List.unmodifiable(_lines.map((line) => line.item)),
        ),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _lines.clear();
        _clearEditState();
        _warnings = const [];
        _reviewing = false;
        _submitting = false;
        _feedback = _PurchaseFeedback.success(
          'Purchase saved on this device. Sync it to share it with your other devices.',
        );
      });
      await _loadCatalogue(clearFeedback: false);
      widget.onRegistered();
    } on AppFailure catch (failure) {
      if (!mounted) {
        return;
      }
      setState(() {
        _submitting = false;
        _feedback = _PurchaseFeedback.error(
          '${failure.code}: ${failure.userMessage} The draft is still available.',
        );
      });
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _submitting = false;
        _feedback = _PurchaseFeedback.error(
          'purchase-registration-unknown: Purchase registration failed. The result is unknown; keep the draft and check History before retrying. The draft is still available.',
        );
      });
    }
  }

  StoreReference? _storeReference() {
    final selected = _selectedStore();
    if (selected != null) {
      return ExistingStoreReference(selected.id);
    }
    return null;
  }

  Product? _selectedProduct() {
    final selectedId = _selectedProductId;
    if (selectedId == null) {
      return null;
    }
    return _selectionState(_products, selectedId).product;
  }

  Store? _selectedStore() {
    final selectedId = _selectedStoreId;
    if (selectedId == null) {
      return null;
    }
    for (final store in _stores) {
      if (store.id.value == selectedId) {
        return store;
      }
    }
    return null;
  }

  String? _validateStoreSelection() {
    final selectedId = _selectedStoreId;
    if (selectedId == null) {
      return 'store-selection-required: Select a Store for this purchase.';
    }
    if (_selectedStore() == null) {
      _selectedStoreId = null;
      return 'store-selection-invalidated: Selected Store is no longer available for this account. Choose a Store again.';
    }
    return null;
  }

  void _reviewPurchase() {
    final storeValidation = _validateStoreSelection();
    if (storeValidation != null) {
      setState(() => _feedback = _PurchaseFeedback.error(storeValidation));
      return;
    }
    if (_lines.isEmpty) {
      setState(() {
        _feedback = _PurchaseFeedback.error(
          'item-required: Stage at least one Item.',
        );
      });
      return;
    }
    try {
      parsePurchaseOccurrenceUtc(
        PurchaseOccurrenceInput(
          dateText: _purchaseDateController.text,
          timeText: _purchaseTimeController.text,
        ),
      );
    } on FormatException catch (error) {
      setState(() => _feedback = _PurchaseFeedback.error(error.message));
      return;
    }
    setState(() => _reviewing = true);
  }

  ProductDraft _productDraft() {
    return ProductDraft(
      userCode: _codeController.text,
      name: _nameController.text,
      brand: _brandController.text,
      mode: _bulk ? ProductMode.bulk : ProductMode.packaged,
      measurementKind: _selectedMeasurementKind(),
      packageAmount: _bulk ? null : _packageAmountController.text,
      packageUnit: _bulk ? null : _packageUnitController.text,
    );
  }

  MeasurementKind _selectedMeasurementKind() {
    final fixedKind =
        _editingMeasurementKind ?? _selectedProduct()?.measurementKind;
    return fixedKind ??
        measurementKindForDisplayUnit(
          _bulk ? _purchasedUnitController.text : _packageUnitController.text,
        );
  }

  String _newProductLabel() {
    final name = _nameController.text.trim();
    return name.isEmpty ? 'New Product' : name;
  }

  void _clearItemInputs() {
    _codeController.clear();
    _nameController.clear();
    _brandController.clear();
    _pricePerUnitController.clear();
    _lineTotalController.clear();
    _comparablePriceController.clear();
    _priceSource = null;
    _pricingError = null;
    _clearSelectedProduct();
  }

  void _clearEditState() {
    _editingKey = null;
    _editingReference = null;
    _editingProductLabel = null;
    _editingProductMode = null;
    _editingMeasurementKind = null;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const MarkeiStatePanel(
        key: Key('purchase.loading'),
        title: 'Loading purchase setup',
        message: 'Loading Products, Stores and optional local labels.',
        icon: Icons.hourglass_empty,
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutClass = MarkeiLayoutClass.fromWidth(constraints.maxWidth);
        final wide = layoutClass == MarkeiLayoutClass.wide;
        return ListView(
          key: const Key('purchase.page'),
          children: [
            const MarkeiPageHeader(
              title: 'New purchase',
              purpose:
                  'Stage local Purchase Items, review the draft and register once.',
              icon: Icons.add_shopping_cart_outlined,
            ),
            const SizedBox(height: MarkeiSpacing.sm),
            const MarcText(
              'Purchases are registered locally first on this device. After an unknown result, check History before retrying.',
              key: Key('purchase.localNotice'),
              style: MarkeiText.metadata,
            ),
            const SizedBox(height: MarkeiSpacing.md),
            _purchaseHeader(),
            const SizedBox(height: MarkeiSpacing.md),
            if (!_reviewing)
              if (wide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _productSection()),
                    const SizedBox(width: MarkeiSpacing.md),
                    Expanded(flex: 2, child: _quantitySection()),
                  ],
                )
              else ...[
                _productSection(),
                const SizedBox(height: MarkeiSpacing.md),
                _quantitySection(),
              ]
            else
              _reviewSection(),
            const SizedBox(height: MarkeiSpacing.md),
            if (!_reviewing) _editActionBand(),
            if (_feedback != null) ...[
              const SizedBox(height: MarkeiSpacing.sm),
              _feedbackPanel(),
            ],
            if (_warnings.isNotEmpty) ...[
              const SizedBox(height: MarkeiSpacing.sm),
              _similarityWarningSection(),
            ],
            const SizedBox(height: MarkeiSpacing.md),
            _stagedLinesSection(layoutClass),
            const SizedBox(height: MarkeiSpacing.md),
            _totalActionBand(),
          ],
        );
      },
    );
  }

  TextStyle _contextStyle({bool optional = false}) => MarkeiText.body.copyWith(
    color: optional ? MarkeiColors.information : MarkeiColors.green,
    fontWeight: optional ? FontWeight.w400 : FontWeight.w600,
  );

  InputDecoration _contextDecoration(
    String label, {
    bool optional = false,
    bool calculated = false,
    String? helper,
    String? error,
  }) {
    final blue = optional || calculated;
    final color = blue ? MarkeiColors.information : MarkeiColors.green;
    final role = optional
        ? 'Optional'
        : calculated
        ? 'Linked'
        : 'Required';
    return InputDecoration(
      labelText: '${context.tr(label)} · ${context.tr(role)}',
      labelStyle: _contextStyle(optional: blue),
      floatingLabelStyle: _contextStyle(optional: blue),
      helperText: helper,
      errorText: error,
      helperMaxLines: 2,
      errorMaxLines: 2,
      filled: true,
      fillColor: color.withValues(alpha: 0.035),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color.withValues(alpha: 0.18)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color.withValues(alpha: 0.65)),
      ),
    ).localized(context);
  }

  String? _occurrenceFieldError({required bool date}) {
    final value = date
        ? _purchaseDateController.text
        : _purchaseTimeController.text;
    if (value.length < (date ? 10 : 5)) return null;
    try {
      parsePurchaseOccurrenceUtc(
        PurchaseOccurrenceInput(
          dateText: date ? value : '01/01/2000',
          timeText: date ? '00:00' : value,
        ),
      );
      return null;
    } on FormatException {
      return date
          ? 'Enter a valid calendar date.'
          : 'Use a time from 00:00 to 23:59.';
    }
  }

  Widget _purchaseHeader() {
    final selectedStore = _selectedStore();
    return _PurchaseSection(
      title: 'Purchase details',
      subtitle:
          'Choose a store and purchase time. Person and payment method are optional.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_stores.isEmpty)
            const MarcText(
              'No Stores yet. Create one in Catalogue before registering a purchase.',
              key: Key('purchase.store.required'),
            ),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 760
                  ? 3
                  : constraints.maxWidth >= 500
                  ? 2
                  : 1;
              final width =
                  (constraints.maxWidth - MarkeiSpacing.md * (columns - 1)) /
                  columns;
              return Wrap(
                spacing: MarkeiSpacing.md,
                runSpacing: MarkeiSpacing.md,
                children: [
                  SizedBox(
                    width: width,
                    child: InputDecorator(
                      decoration: _contextDecoration('Store'),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          key: const Key('purchase.store.select'),
                          value: selectedStore?.id.value,
                          hint: MarcText(
                            'Select Store',
                            style: _contextStyle(),
                          ),
                          isExpanded: true,
                          isDense: true,
                          style: _contextStyle(),
                          items: [
                            for (final store in _stores)
                              DropdownMenuItem(
                                value: store.id.value,
                                child: Text(store.displayName),
                              ),
                          ],
                          onChanged: _reviewing
                              ? null
                              : (value) => setState(() {
                                  _selectedStoreId = value;
                                  _feedback = value == null
                                      ? null
                                      : _PurchaseFeedback.success(
                                          'Store selected.',
                                        );
                                }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: TextField(
                      key: const Key('purchase.date'),
                      controller: _purchaseDateController,
                      readOnly: _reviewing,
                      style: _contextStyle(),
                      keyboardType: TextInputType.number,
                      inputFormatters: const [PurchaseDigitsFormatter.date()],
                      onChanged: (_) => setState(() {}),
                      decoration: _contextDecoration(
                        'Purchase date',
                        helper: 'dd/mm/yyyy',
                        error: _occurrenceFieldError(date: true),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: TextField(
                      key: const Key('purchase.time'),
                      controller: _purchaseTimeController,
                      readOnly: _reviewing,
                      style: _contextStyle(),
                      keyboardType: TextInputType.number,
                      inputFormatters: const [PurchaseDigitsFormatter.time()],
                      onChanged: (_) => setState(() {}),
                      decoration: _contextDecoration(
                        'Time',
                        helper: 'HH:mm',
                        error: _occurrenceFieldError(date: false),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: InputDecorator(
                      decoration: _contextDecoration('Person', optional: true),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<LocalReference?>(
                          key: const Key('purchase.person.select'),
                          value: _selectedPerson,
                          isExpanded: true,
                          isDense: true,
                          style: _contextStyle(optional: true),
                          items: [
                            const DropdownMenuItem(
                              value: null,
                              child: MarcText('Person not assigned'),
                            ),
                            for (final person in _people)
                              DropdownMenuItem(
                                value: person,
                                child: Text(person.displayLabel),
                              ),
                          ],
                          onChanged: _reviewing
                              ? null
                              : (value) =>
                                    setState(() => _selectedPerson = value),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: InputDecorator(
                      decoration: _contextDecoration(
                        'Payment method',
                        optional: true,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<LocalReference?>(
                          key: const Key('purchase.payment.select'),
                          value: _selectedPaymentMethod,
                          isExpanded: true,
                          isDense: true,
                          style: _contextStyle(optional: true),
                          items: [
                            const DropdownMenuItem(
                              value: null,
                              child: MarcText('Payment not assigned'),
                            ),
                            for (final payment in _paymentMethods)
                              DropdownMenuItem(
                                value: payment,
                                child: Text(payment.displayLabel),
                              ),
                          ],
                          onChanged: _reviewing
                              ? null
                              : (value) => setState(
                                  () => _selectedPaymentMethod = value,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          if (selectedStore != null) ...[
            const SizedBox(height: MarkeiSpacing.xs),
            MarcText(
              'Selected Store: ${selectedStore.displayName}',
              key: const Key('purchase.store.selected'),
              style: MarkeiText.metadata,
            ),
          ],
        ],
      ),
    );
  }

  Widget _productSection() {
    final selectedProduct = _selectedProduct();
    return _PurchaseSection(
      title: 'Product',
      subtitle: 'Find an existing Product or stage a new reusable Product.',
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarkeiControlBand(
              children: [
                SizedBox(
                  width: constraints.maxWidth.clamp(0, 320),
                  child: TextField(
                    key: const Key('product.code'),
                    controller: _codeController,
                    readOnly: selectedProduct != null || _editingKey != null,
                    textInputAction: TextInputAction.search,
                    onSubmitted: _editingKey == null
                        ? (_) => _findProductByCode()
                        : null,
                    decoration: _contextDecoration(
                      'Product code',
                      helper: 'Your code; fixed once saved',
                    ),
                  ),
                ),
                OutlinedButton(
                  key: const Key('product.findByCode'),
                  onPressed: _editingKey == null ? _findProductByCode : null,
                  child: const MarcText('Find code'),
                ),
              ],
            ),
            const SizedBox(height: MarkeiSpacing.sm),
            if (_products.isEmpty)
              const MarcText(
                'No Products yet. Create a Product to stage an Item.',
              )
            else
              DropdownButton<String?>(
                key: const Key('purchase.product.select'),
                value: selectedProduct?.id.value,
                hint: const MarcText('Use existing Product'),
                isExpanded: true,
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: MarcText('Create new Product'),
                  ),
                  for (final product in _products)
                    DropdownMenuItem(
                      value: product.id.value,
                      child: Text(
                        '${product.userProductCode.displayValue} · ${product.displayName}',
                      ),
                    ),
                ],
                onChanged: _editingKey != null
                    ? null
                    : (value) => setState(() {
                        if (value == null) {
                          _clearSelectedProduct();
                          _codeController.clear();
                          _nameController.clear();
                          _brandController.clear();
                        } else {
                          final selected = _selectProductId(value);
                          if (selected == null) {
                            _feedback = _PurchaseFeedback.error(
                              'product-selection-invalidated: Selected Product is not available. Choose a Product again.',
                            );
                          }
                        }
                      }),
              ),
            const SizedBox(height: MarkeiSpacing.sm),
            if (selectedProduct != null) ...[
              TextField(
                key: const Key('product.name'),
                controller: _nameController,
                readOnly: true,
                decoration: _contextDecoration('Product name'),
              ),
              const SizedBox(height: MarkeiSpacing.sm),
              TextField(
                key: const Key('product.brand'),
                controller: _brandController,
                readOnly: true,
                decoration: _contextDecoration('Brand', optional: true),
              ),
              const SizedBox(height: MarkeiSpacing.xs),
              Text(
                context.message('Mode: {p0} · {p1}', [
                  context.tr(selectedProduct.mode.name.toUpperCase()),
                  context.tr(selectedProduct.measurementKind.name),
                ]),
                key: const Key('product.immutableFacts'),
                style: MarkeiText.metadata,
              ),
              const SizedBox(height: MarkeiSpacing.sm),
              FilledButton.tonal(
                key: const Key('product.useSelected'),
                onPressed: _editingKey != null
                    ? null
                    : () => _stageExistingProduct(selectedProduct),
                child: const MarcText('Add selected Product'),
              ),
            ] else ...[
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(value: false, label: MarcText('Packaged')),
                  ButtonSegment(value: true, label: MarcText('Bulk')),
                ],
                selected: {_bulk},
                onSelectionChanged: _editingKey != null
                    ? null
                    : (value) => setState(() {
                        _bulk = value.single;
                        _recalculatePrices();
                      }),
              ),
              const SizedBox(height: MarkeiSpacing.sm),
              TextField(
                key: const Key('product.name'),
                controller: _nameController,
                readOnly: _editingKey != null,
                decoration: _contextDecoration('Product name'),
              ),
              const SizedBox(height: MarkeiSpacing.sm),
              TextField(
                key: const Key('product.brand'),
                controller: _brandController,
                readOnly: _editingKey != null,
                decoration: _contextDecoration('Brand', optional: true),
              ),
              const SizedBox(height: MarkeiSpacing.sm),
            ],
          ],
        ),
      ),
    );
  }

  Widget _quantitySection() {
    final fixedKind =
        _editingMeasurementKind ?? _selectedProduct()?.measurementKind;
    final packageLocked = _editingKey != null || _selectedProduct() != null;
    final comparableUnit = switch (_selectedMeasurementKind()) {
      MeasurementKind.mass => 'kg',
      MeasurementKind.volume => 'L',
      MeasurementKind.count => 'un',
    };
    final selectedUnit = displayQuantityUnit(_purchasedUnitController.text);
    return _PurchaseSection(
      title: 'Quantity and price',
      subtitle: _bulk
          ? 'Enter the amount bought and either price. The other price is calculated.'
          : 'Enter whole packages and either price. Unit size is the contents of one package.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth >= 420
                  ? (constraints.maxWidth - MarkeiSpacing.md) / 2
                  : constraints.maxWidth;
              Widget field(Widget child) =>
                  SizedBox(width: width, child: child);
              return Wrap(
                spacing: MarkeiSpacing.md,
                runSpacing: MarkeiSpacing.md,
                children: [
                  if (!_bulk) ...[
                    field(
                      TextField(
                        key: const Key('item.packageCount'),
                        controller: _packageCountController,
                        keyboardType: TextInputType.number,
                        decoration: _contextDecoration(
                          'Units bought',
                          helper: 'Whole packages, e.g. 2',
                        ),
                        onChanged: (_) => _previewPrices(),
                      ),
                    ),
                    field(
                      TextField(
                        key: const Key('product.packageAmount'),
                        controller: _packageAmountController,
                        readOnly: packageLocked,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: _contextDecoration(
                          'Unit size',
                          helper: packageLocked
                              ? 'From Catalogue'
                              : 'Contents per package, e.g. 500',
                        ),
                        onChanged: (_) => _previewPrices(),
                      ),
                    ),
                    field(
                      QuantityUnitPicker(
                        key: const Key('product.packageUnit'),
                        decoration: _contextDecoration('Unit'),
                        value: _packageUnitController.text,
                        kind: fixedKind,
                        onChanged: packageLocked
                            ? null
                            : (unit) => setState(() {
                                _packageUnitController.text = unit;
                                _recalculatePrices();
                              }),
                      ),
                    ),
                    field(
                      TextField(
                        key: const Key('item.quantity'),
                        controller: _purchasedAmountController,
                        readOnly: true,
                        decoration: _contextDecoration(
                          'Total contents ($comparableUnit)',
                          calculated: true,
                          helper: 'Units bought × unit size',
                        ),
                      ),
                    ),
                  ] else ...[
                    field(
                      TextField(
                        key: const Key('item.quantity'),
                        controller: _purchasedAmountController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: _contextDecoration(
                          'Amount bought',
                          helper: 'Decimals allowed, e.g. 2.5',
                        ),
                        onChanged: (_) => _previewPrices(),
                      ),
                    ),
                    field(
                      QuantityUnitPicker(
                        key: const Key('item.unit'),
                        decoration: _contextDecoration('Unit'),
                        value: _purchasedUnitController.text,
                        kind: fixedKind,
                        onChanged: (unit) => setState(() {
                          _purchasedUnitController.text = unit;
                          _recalculatePrices();
                        }),
                      ),
                    ),
                  ],
                  field(
                    TextField(
                      key: const Key('item.pricePerUnit'),
                      controller: _pricePerUnitController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: _contextDecoration(
                        _bulk
                            ? 'Unit price (BRL/$selectedUnit)'
                            : 'Unit price (BRL/package)',
                        calculated: true,
                        helper: 'Enter either price',
                      ),
                      onChanged: (_) =>
                          _previewPrices(PurchasePriceSource.unitPrice),
                    ),
                  ),
                  field(
                    TextField(
                      key: const Key('item.lineTotal'),
                      controller: _lineTotalController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: _contextDecoration(
                        'Total price (BRL)',
                        calculated: true,
                        helper: 'Enter either price',
                      ),
                      onChanged: (_) =>
                          _previewPrices(PurchasePriceSource.totalPrice),
                    ),
                  ),
                  field(
                    TextField(
                      key: const Key('item.comparablePrice'),
                      controller: _comparablePriceController,
                      readOnly: true,
                      decoration: _contextDecoration(
                        'Price per $comparableUnit (BRL)',
                        calculated: true,
                        helper: 'Calculated · based on total contents',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          const MarcText(
            'mL: millilitres · mg: milligrams · g: grams · L: litres · kg: kilograms · un: individual units',
            key: Key('item.unitGuide'),
            style: MarkeiText.metadata,
          ),
          const SizedBox(height: MarkeiSpacing.xs),
          const MarcText(
            'The last price you edit is kept when the quantity changes. Totals are rounded to cents.',
            style: MarkeiText.metadata,
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          Semantics(
            liveRegion: true,
            child: MarkeiCard(
              padding: const EdgeInsets.all(MarkeiSpacing.sm),
              color: MarkeiColors.information.withValues(alpha: 0.04),
              borderColor: MarkeiColors.information.withValues(alpha: 0.15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    _pricingError != null
                        ? Icons.info_outline
                        : Icons.calculate_outlined,
                    size: 18,
                    color: MarkeiColors.information,
                  ),
                  const SizedBox(width: MarkeiSpacing.xs),
                  Expanded(
                    child: MarcText(
                      _pricingError ??
                          (_comparablePriceController.text.isEmpty
                              ? 'Add a price: enter either unit price or total price. Marc calculates the other and the comparison price.'
                              : 'Prices ready. You can change either price; Marc keeps the last one you edit.'),
                      key: Key(
                        _pricingError != null
                            ? 'item.pricingError'
                            : 'item.priceGuidance',
                      ),
                      style: MarkeiText.body,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _editActionBand() {
    return MarkeiActionBand(
      leading: MarcText(
        _editingKey == null ? 'Editing new Item' : 'Editing staged Item',
        style: MarkeiText.label,
      ),
      children: [
        FilledButton(
          key: const Key('item.add'),
          onPressed: _editingKey == null
              ? () => _stageNewProduct(createAnyway: false)
              : _saveEditedLine,
          child: MarcText(
            _editingKey == null ? 'Add staged Item' : 'Save Item',
          ),
        ),
        if (_editingKey == null)
          FilledButton.tonal(
            key: const Key('product.createAnyway'),
            onPressed: () => _stageNewProduct(createAnyway: true),
            child: const MarcText('Create anyway'),
          ),
        OutlinedButton(
          key: const Key('purchase.review'),
          onPressed: _submitting ? null : _reviewPurchase,
          child: const MarcText('Review purchase'),
        ),
      ],
    );
  }

  Widget _reviewSection() {
    final selectedStore = _selectedStore();
    return MarkeiSection(
      title: 'Review purchase',
      subtitle: 'This draft is read-only until you go back to edit.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: MarkeiSpacing.lg,
            runSpacing: MarkeiSpacing.xs,
            children: [
              MarkeiFact(
                label: 'Store',
                value: selectedStore?.displayName ?? 'Required',
              ),
              MarkeiFact(
                label: 'Date',
                value: _purchaseDateController.text.trim().isEmpty
                    ? 'Today'
                    : _purchaseDateController.text.trim(),
              ),
              MarkeiFact(
                label: 'Time',
                value: _purchaseTimeController.text.trim().isEmpty
                    ? 'Now'
                    : _purchaseTimeController.text.trim(),
              ),
              if (_selectedPerson != null)
                MarkeiFact(
                  label: 'Person',
                  value: _selectedPerson!.displayLabel,
                ),
              if (_selectedPaymentMethod != null)
                MarkeiFact(
                  label: 'Payment',
                  value: _selectedPaymentMethod!.displayLabel,
                ),
            ],
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          FilledButton.tonal(
            key: const Key('purchase.backToEdit'),
            onPressed: _submitting
                ? null
                : () => setState(() => _reviewing = false),
            child: const MarcText('Back to edit'),
          ),
        ],
      ),
    );
  }

  Widget _feedbackPanel() {
    final feedback = _feedback!;
    final diagnostic = RegExp(
      r'^([a-z][a-z0-9]*(?:-[a-z0-9]+)+):\s*(.*)$',
      dotAll: true,
    ).firstMatch(feedback.message);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarkeiStatePanel(
          key: const Key('purchase.message'),
          title: _feedback!.isError
              ? 'Purchase needs attention'
              : 'Purchase update',
          message: diagnostic?.group(2) ?? feedback.message,
          icon: _feedback!.isError
              ? Icons.error_outline
              : Icons.check_circle_outline,
        ),
        if (diagnostic != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: MarcText(
              'Diagnostic: ${diagnostic.group(1)}',
              style: MarkeiText.metadata,
            ),
          ),
      ],
    );
  }

  Widget _similarityWarningSection() {
    return MarkeiSection(
      title: 'Similar Product found',
      key: const Key('product.similarityWarning'),
      subtitle: 'Choose an existing Product or explicitly create anyway.',
      child: Column(
        children: [
          for (final warning in _warnings)
            ListTile(
              title: Text(warning.existingProduct.displayName),
              subtitle: Text(warning.existingProduct.displayBrand),
              trailing: TextButton(
                key: Key('product.use.${warning.existingProduct.id.value}'),
                onPressed: () => _stageExistingProduct(warning.existingProduct),
                child: const MarcText('Use this Product'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _totalActionBand() {
    return MarkeiActionBand(
      leading: MarcText(
        'Staged total BRL ${(_stagedTotalMinorUnits / 100).toStringAsFixed(2)}',
        key: const Key('purchase.stagedTotal'),
        style: MarkeiText.numeric,
      ),
      children: [
        FilledButton(
          key: const Key('purchase.register'),
          onPressed: _reviewing && !_submitting ? _registerPurchase : null,
          child: MarcText(_submitting ? 'Registering...' : 'Register purchase'),
        ),
      ],
    );
  }

  Widget _stagedLinesSection(MarkeiLayoutClass layoutClass) {
    if (_lines.isEmpty) {
      return const MarkeiStatePanel(
        key: Key('purchase.emptyDraft'),
        title: 'No staged Items yet',
        message: 'Add at least one Item before reviewing this Purchase.',
        icon: Icons.shopping_basket_outlined,
      );
    }
    return MarkeiSection(
      title: 'Staged Items',
      subtitle: _reviewing
          ? 'Review these Items before registration.'
          : 'Items staged in the current editable draft.',
      child: layoutClass == MarkeiLayoutClass.wide
          ? _StagedLineTable(
              lines: _lines,
              submitting: _submitting,
              onEdit: _editLine,
              onRemove: _removeLine,
            )
          : _StagedLineCards(
              lines: _lines,
              submitting: _submitting,
              onEdit: _editLine,
              onRemove: _removeLine,
            ),
    );
  }
}

class _StagedLineTable extends StatelessWidget {
  const _StagedLineTable({
    required this.lines,
    required this.submitting,
    required this.onEdit,
    required this.onRemove,
  });

  final List<_DraftLine> lines;
  final bool submitting;
  final ValueChanged<_DraftLine> onEdit;
  final ValueChanged<_DraftLine> onRemove;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: MarcText('Product')),
          DataColumn(label: MarcText('Mode')),
          DataColumn(label: MarcText('Quantity')),
          DataColumn(label: MarcText('Line total')),
          DataColumn(label: MarcText('Actions')),
        ],
        rows: [
          for (final line in lines)
            DataRow(
              key: ValueKey('purchase.line.${line.keyValue}'),
              cells: [
                DataCell(Text(line.productLabel)),
                DataCell(MarcText(line.productMode.name.toUpperCase())),
                DataCell(MarcText(_quantityLabel(line))),
                DataCell(MarcText(_lineTotalLabel(line))),
                DataCell(
                  _LineActions(
                    line: line,
                    submitting: submitting,
                    onEdit: onEdit,
                    onRemove: onRemove,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _StagedLineCards extends StatelessWidget {
  const _StagedLineCards({
    required this.lines,
    required this.submitting,
    required this.onEdit,
    required this.onRemove,
  });

  final List<_DraftLine> lines;
  final bool submitting;
  final ValueChanged<_DraftLine> onEdit;
  final ValueChanged<_DraftLine> onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final line in lines) ...[
          MarkeiCard(
            key: Key('purchase.line.${line.keyValue}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(line.productLabel, style: MarkeiText.sectionTitle),
                const SizedBox(height: MarkeiSpacing.sm),
                Wrap(
                  spacing: MarkeiSpacing.lg,
                  runSpacing: MarkeiSpacing.xs,
                  children: [
                    MarkeiFact(
                      label: 'Mode',
                      value: line.productMode.name.toUpperCase(),
                    ),
                    MarkeiFact(label: 'Quantity', value: _quantityLabel(line)),
                    MarkeiFact(
                      label: 'Line total',
                      value: _lineTotalLabel(line),
                    ),
                  ],
                ),
                const SizedBox(height: MarkeiSpacing.sm),
                _LineActions(
                  line: line,
                  submitting: submitting,
                  onEdit: onEdit,
                  onRemove: onRemove,
                ),
              ],
            ),
          ),
          if (line != lines.last) const SizedBox(height: MarkeiSpacing.sm),
        ],
      ],
    );
  }
}

class _LineActions extends StatelessWidget {
  const _LineActions({
    required this.line,
    required this.submitting,
    required this.onEdit,
    required this.onRemove,
  });

  final _DraftLine line;
  final bool submitting;
  final ValueChanged<_DraftLine> onEdit;
  final ValueChanged<_DraftLine> onRemove;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: MarkeiSpacing.xs,
      children: [
        IconButton(
          key: Key('purchase.line.edit.${line.keyValue}'),
          tooltip: context.tr('Edit staged Item'),
          onPressed: submitting ? null : () => onEdit(line),
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          key: Key('purchase.line.remove.${line.keyValue}'),
          tooltip: context.tr('Remove staged Item'),
          onPressed: submitting ? null : () => onRemove(line),
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }
}

String _quantityLabel(_DraftLine line) {
  final item = line.item;
  final packageLabel = item.packageCount == null
      ? 'BULK'
      : '${item.packageCount} package(s)';
  return '$packageLabel · ${item.purchasedQuantity.decimalText} ${item.purchasedQuantity.unit.name}';
}

String _lineTotalLabel(_DraftLine line) {
  final total = line.item.lineTotal;
  return '${total.currencyCode} ${(total.minorUnits / 100).toStringAsFixed(2)}';
}

final class _DraftLine {
  const _DraftLine({
    required this.keyValue,
    required this.productLabel,
    required this.productMode,
    required this.measurementKind,
    required this.packageQuantity,
    required this.item,
  });

  final int keyValue;
  final String productLabel;
  final ProductMode productMode;
  final MeasurementKind measurementKind;
  final NormalizedQuantity? packageQuantity;
  final PurchaseItemDraft item;
}

final class _PurchaseFeedback {
  const _PurchaseFeedback._(this.message, {required this.isError});

  factory _PurchaseFeedback.success(String message) {
    return _PurchaseFeedback._(message, isError: false);
  }

  factory _PurchaseFeedback.error(String message) {
    return _PurchaseFeedback._(message, isError: true);
  }

  final String message;
  final bool isError;
}

final class _ProductProjection {
  const _ProductProjection({
    required this.products,
    required this.conflictedProductId,
  });

  final List<Product> products;
  final String? conflictedProductId;
}

final class _ProductSelectionState {
  const _ProductSelectionState({required this.product, required this.multiple});

  final Product? product;
  final bool multiple;
}

_ProductProjection _normalizedProductProjection(List<Product> products) {
  final byId = <String, Product>{};
  final conflictedIds = <String>{};
  for (final product in products) {
    final id = product.id.value;
    final existing = byId[id];
    if (existing == null) {
      byId[id] = product;
      continue;
    }
    if (!_sameProductFacts(existing, product)) {
      conflictedIds.add(id);
    }
  }
  final emitted = <String>{};
  final normalized = <Product>[];
  for (final product in products) {
    final id = product.id.value;
    if (conflictedIds.contains(id) || !emitted.add(id)) {
      continue;
    }
    normalized.add(product);
  }
  return _ProductProjection(
    products: List.unmodifiable(normalized),
    conflictedProductId: conflictedIds.isEmpty ? null : conflictedIds.first,
  );
}

_ProductSelectionState _selectionState(List<Product> products, String? id) {
  if (id == null) {
    return const _ProductSelectionState(product: null, multiple: false);
  }
  Product? selected;
  var count = 0;
  for (final product in products) {
    if (product.id.value == id) {
      selected = product;
      count++;
    }
  }
  return _ProductSelectionState(
    product: count == 1 ? selected : null,
    multiple: count > 1,
  );
}

bool _sameProductFacts(Product left, Product right) {
  return left.accountId.value == right.accountId.value &&
      left.userProductCode.displayValue == right.userProductCode.displayValue &&
      left.userProductCode.normalizedKey ==
          right.userProductCode.normalizedKey &&
      left.normalizationVersion == right.normalizationVersion &&
      left.displayName == right.displayName &&
      left.displayBrand == right.displayBrand &&
      left.normalizedName == right.normalizedName &&
      left.normalizedBrand == right.normalizedBrand &&
      left.mode == right.mode &&
      left.measurementKind == right.measurementKind &&
      left.packageQuantity?.decimalText == right.packageQuantity?.decimalText &&
      left.packageQuantity?.unit == right.packageQuantity?.unit;
}

String _purchaseInputError(Object error) {
  if (error is FormatException) return error.message;
  if (error is ArgumentError && error.message != null) {
    return error.message.toString();
  }
  return 'Check the quantity, unit and price before adding this item.';
}

String _formatMinorUnits(Money money) => formatPurchaseTotal(money.minorUnits);

class _PurchaseSection extends StatelessWidget {
  const _PurchaseSection({
    required this.title,
    required this.child,
    this.subtitle,
  });
  final String title;
  final String? subtitle;
  final Widget child;
  @override
  Widget build(BuildContext context) => MarkeiCard(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(MarkeiSpacing.md),
          decoration: BoxDecoration(
            color: MarkeiColors.green.withValues(alpha: 0.025),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(MarkeiRadius.md),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MarcText(
                title,
                style: MarkeiText.sectionTitle.copyWith(
                  color: MarkeiColors.brandDeepGreen,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: MarkeiSpacing.xxs),
                MarcText(subtitle!, style: MarkeiText.metadata),
              ],
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.all(MarkeiSpacing.md), child: child),
      ],
    ),
  );
}
