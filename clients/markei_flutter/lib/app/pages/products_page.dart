import 'package:flutter/material.dart';

import '../../application/catalogue_queries.dart';
import '../../domain/catalogue/product.dart';
import '../../domain/shared/ids.dart';
import '../../domain/shared/quantity.dart';
import '../../domain/store/store.dart';
import '../design/markei_theme.dart';
import '../widgets/markei_components.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({
    required this.accountId,
    required this.catalogueQueries,
    required this.refreshSignal,
    required this.onChanged,
    super.key,
  });

  final AccountId accountId;
  final CatalogueQueryRepository catalogueQueries;
  final int refreshSignal;
  final VoidCallback onChanged;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _searchController = TextEditingController();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _packageAmountController = TextEditingController(text: '1');
  final _packageUnitController = TextEditingController(text: 'kg');
  final _storeNameController = TextEditingController();
  List<Product> _products = const [];
  List<Store> _stores = const [];
  List<ProductSimilarityWarning> _warnings = const [];
  bool _loading = true;
  bool _bulk = false;
  _ProductSort _sort = _ProductSort.az;
  Product? _selectedDetail;
  String? _message;
  bool _messageIsError = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void didUpdateWidget(covariant ProductsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshSignal != widget.refreshSignal) {
      _loadProducts(clearMessage: false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _codeController.dispose();
    _nameController.dispose();
    _brandController.dispose();
    _packageAmountController.dispose();
    _packageUnitController.dispose();
    _storeNameController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts({bool clearMessage = true}) async {
    setState(() => _loading = true);
    try {
      final products = await widget.catalogueQueries.listProducts(
        widget.accountId,
      );
      final stores = await widget.catalogueQueries.listStores(widget.accountId);
      if (!mounted) {
        return;
      }
      setState(() {
        _products = products;
        _stores = stores;
        _loading = false;
        if (clearMessage) {
          _message = null;
        }
      });
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _message = 'Products could not be loaded. Try again.';
        _messageIsError = true;
      });
    }
  }

  Future<void> _checkSimilar() async {
    try {
      final warnings = await widget.catalogueQueries.similarityWarnings(
        widget.accountId,
        _draft(),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _warnings = warnings;
        _message = warnings.isEmpty
            ? 'No similar Product found.'
            : 'Similar Product found. Use an existing Product or create anyway.';
        _messageIsError = false;
      });
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _message = 'Check the Product details and try again.';
        _messageIsError = true;
      });
    }
  }

  Future<void> _createProduct({required bool createAnyway}) async {
    if (!createAnyway) {
      await _checkSimilar();
      if (_warnings.isNotEmpty) {
        return;
      }
    }
    try {
      await widget.catalogueQueries.createProduct(widget.accountId, _draft());
      if (!mounted) {
        return;
      }
      setState(() {
        _warnings = const [];
        _message = 'Product created locally.';
        _messageIsError = false;
        _codeController.clear();
        _nameController.clear();
        _brandController.clear();
      });
      await _loadProducts();
      widget.onChanged();
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _message =
            'Product could not be created. Check the details and try again.';
        _messageIsError = true;
      });
    }
  }

  Future<void> _createStore() async {
    try {
      await widget.catalogueQueries.createStore(
        widget.accountId,
        _storeNameController.text,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _message = 'Store created locally.';
        _messageIsError = false;
        _storeNameController.clear();
      });
      await _loadProducts(clearMessage: false);
      widget.onChanged();
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _message = 'Store could not be created. Enter a Store name.';
        _messageIsError = true;
      });
    }
  }

  ProductDraft _draft() {
    return ProductDraft(
      userCode: _codeController.text,
      name: _nameController.text,
      brand: _brandController.text,
      mode: _bulk ? ProductMode.bulk : ProductMode.packaged,
      measurementKind: _measurementKindFromUnit(),
      packageAmount: _bulk ? null : _packageAmountController.text,
      packageUnit: _bulk ? null : _packageUnitController.text,
    );
  }

  MeasurementKind _measurementKindFromUnit() {
    final unit = _packageUnitController.text.trim().toLowerCase();
    if (unit == 'l' || unit == 'ml') {
      return MeasurementKind.volume;
    }
    if (unit == 'un' || unit == 'unit') {
      return MeasurementKind.count;
    }
    return MeasurementKind.mass;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const MarkeiStatePanel(
        key: Key('products.loading'),
        title: 'Loading Catalogue',
        message: 'Loading Products and Stores.',
        icon: Icons.hourglass_empty,
      );
    }
    final query = _searchController.text.trim().toLowerCase();
    final visible = _products.where((product) {
      if (query.isEmpty) {
        return true;
      }
      return product.displayName.toLowerCase().contains(query) ||
          product.displayBrand.toLowerCase().contains(query) ||
          product.userProductCode.displayValue.toLowerCase().contains(query);
    }).toList();
    visible.sort((left, right) {
      final comparison = left.displayName.toLowerCase().compareTo(
        right.displayName.toLowerCase(),
      );
      if (comparison != 0) {
        return _sort == _ProductSort.az ? comparison : -comparison;
      }
      return left.id.value.compareTo(right.id.value);
    });
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutClass = MarkeiLayoutClass.fromWidth(constraints.maxWidth);
        final wide = layoutClass == MarkeiLayoutClass.wide;
        return ListView(
          key: const Key('products.page'),
          children: [
            MarkeiPageHeader(
              title: 'Catalogue',
              purpose:
                  'Manage reusable Products and supporting Stores for purchase registration.',
              icon: Icons.inventory_2_outlined,
              trailing: Text(
                '${_products.length} Product(s)',
                style: MarkeiText.metadata,
              ),
            ),
            const SizedBox(height: MarkeiSpacing.md),
            _catalogueControls(wide: wide),
            const SizedBox(height: MarkeiSpacing.md),
            if (_products.isEmpty)
              MarkeiStatePanel(
                key: const Key('products.empty'),
                title: 'No Products yet',
                message: _stores.isEmpty
                    ? 'Create a Store and reusable Product before registering purchases.'
                    : 'Create a reusable Product below.',
                icon: Icons.inventory_2_outlined,
              )
            else if (visible.isEmpty)
              const MarkeiStatePanel(
                key: Key('products.noMatch'),
                title: 'No matching Product',
                message:
                    'The current search produced no Product in this Catalogue.',
                icon: Icons.search_off,
              )
            else if (wide)
              _ProductTable(products: visible, onDetail: _showProductDetail)
            else
              _ProductCards(products: visible, onDetail: _showProductDetail),
            if (_selectedDetail != null) ...[
              const SizedBox(height: MarkeiSpacing.md),
              _ProductDetail(product: _selectedDetail!),
            ],
            const SizedBox(height: MarkeiSpacing.md),
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _createProductSection()),
                  const SizedBox(width: MarkeiSpacing.md),
                  Expanded(flex: 2, child: _similaritySection()),
                ],
              )
            else ...[
              _createProductSection(),
              const SizedBox(height: MarkeiSpacing.md),
              _similaritySection(),
            ],
            const SizedBox(height: MarkeiSpacing.md),
            _storesSection(),
          ],
        );
      },
    );
  }

  Widget _catalogueControls({required bool wide}) {
    return MarkeiControlBand(
      children: [
        SizedBox(
          width: wide ? 420 : double.infinity,
          child: TextField(
            key: const Key('products.search'),
            controller: _searchController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'Search Products',
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        SizedBox(
          width: wide ? 180 : double.infinity,
          child: DropdownButtonFormField<_ProductSort>(
            key: const Key('products.sort'),
            initialValue: _sort,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Sort'),
            items: const [
              DropdownMenuItem(value: _ProductSort.az, child: Text('A-Z')),
              DropdownMenuItem(value: _ProductSort.za, child: Text('Z-A')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _sort = value);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _createProductSection() {
    return MarkeiSection(
      title: 'Register product',
      subtitle: 'Create reusable Product facts for future Purchases.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: false, label: Text('Packaged')),
              ButtonSegment(value: true, label: Text('Bulk')),
            ],
            selected: {_bulk},
            onSelectionChanged: (value) => setState(() => _bulk = value.single),
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          TextField(
            key: const Key('products.create.code'),
            controller: _codeController,
            decoration: const InputDecoration(labelText: 'Product code'),
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          TextField(
            key: const Key('products.create.name'),
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Product name'),
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          TextField(
            key: const Key('products.create.brand'),
            controller: _brandController,
            decoration: const InputDecoration(labelText: 'Brand'),
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          if (!_bulk)
            Wrap(
              spacing: MarkeiSpacing.sm,
              runSpacing: MarkeiSpacing.sm,
              children: [
                SizedBox(
                  width: 220,
                  child: TextField(
                    key: const Key('products.create.packageAmount'),
                    controller: _packageAmountController,
                    decoration: const InputDecoration(
                      labelText: 'Package size',
                    ),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: TextField(
                    key: const Key('products.create.packageUnit'),
                    controller: _packageUnitController,
                    decoration: const InputDecoration(
                      labelText: 'Package unit',
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 12),
          MarkeiControlBand(
            children: [
              FilledButton(
                key: const Key('products.create'),
                onPressed: () => _createProduct(createAnyway: false),
                child: const Text('Create Product'),
              ),
              FilledButton.tonal(
                key: const Key('products.createAnyway'),
                onPressed: () => _createProduct(createAnyway: true),
                child: const Text('Create anyway'),
              ),
              OutlinedButton(
                key: const Key('products.retry'),
                onPressed: _loadProducts,
                child: const Text('Retry'),
              ),
            ],
          ),
          if (_message != null) ...[
            const SizedBox(height: 12),
            Text(
              _message!,
              key: const Key('products.message'),
              style: TextStyle(
                color: _messageIsError
                    ? Theme.of(context).colorScheme.error
                    : null,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _similaritySection() {
    return MarkeiSection(
      title: 'Similar product found',
      subtitle: 'Choose an existing Product or explicitly create anyway.',
      child: _warnings.isEmpty
          ? const Text(
              'No unresolved similarity decision.',
              key: Key('products.similar.empty'),
            )
          : Column(
              key: const Key('products.similar'),
              children: [
                for (final warning in _warnings)
                  ListTile(
                    title: Text(warning.existingProduct.displayName),
                    subtitle: Text(warning.existingProduct.displayBrand),
                  ),
              ],
            ),
    );
  }

  Widget _storesSection() {
    return MarkeiSection(
      title: 'Stores',
      subtitle: 'Supporting local Store names used by Purchases.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_stores.isEmpty)
            const Text('No Stores yet.', key: Key('stores.empty'))
          else
            Wrap(
              spacing: MarkeiSpacing.xs,
              runSpacing: MarkeiSpacing.xs,
              children: [
                for (final store in _stores)
                  Chip(
                    key: Key('stores.store.${store.id.value}'),
                    label: Text(store.displayName),
                  ),
              ],
            ),
          const SizedBox(height: MarkeiSpacing.sm),
          TextField(
            key: const Key('stores.create.name'),
            controller: _storeNameController,
            decoration: const InputDecoration(labelText: 'Store name'),
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          FilledButton(
            key: const Key('stores.create'),
            onPressed: _createStore,
            child: const Text('Create Store'),
          ),
        ],
      ),
    );
  }

  void _showProductDetail(Product product) {
    setState(() => _selectedDetail = product);
  }
}

enum _ProductSort { az, za }

class _ProductTable extends StatelessWidget {
  const _ProductTable({required this.products, required this.onDetail});

  final List<Product> products;
  final ValueChanged<Product> onDetail;

  @override
  Widget build(BuildContext context) {
    return MarkeiCard(
      padding: const EdgeInsets.all(MarkeiSpacing.xs),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Product code')),
            DataColumn(label: Text('Product / Brand')),
            DataColumn(label: Text('Mode')),
            DataColumn(label: Text('Package')),
            DataColumn(label: Text('Measurement')),
            DataColumn(label: Text('Details')),
          ],
          rows: [
            for (final product in products)
              DataRow(
                key: ValueKey('products.row.${product.id.value}'),
                cells: [
                  DataCell(
                    Text(product.userProductCode.displayValue),
                    onTap: () => onDetail(product),
                  ),
                  DataCell(
                    Text('${product.displayName}\n${product.displayBrand}'),
                    onTap: () => onDetail(product),
                  ),
                  DataCell(Text(_modeLabel(product))),
                  DataCell(Text(_packageLabel(product))),
                  DataCell(Text(product.measurementKind.name)),
                  DataCell(
                    TextButton(
                      key: Key('products.view.${product.id.value}'),
                      onPressed: () => onDetail(product),
                      child: const Text('View details'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ProductCards extends StatelessWidget {
  const _ProductCards({required this.products, required this.onDetail});

  final List<Product> products;
  final ValueChanged<Product> onDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final product in products) ...[
          MarkeiCard(
            key: Key('products.product.${product.id.value}'),
            child: InkWell(
              onTap: () => onDetail(product),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.userProductCode.displayValue,
                    style: MarkeiText.metadata,
                  ),
                  const SizedBox(height: MarkeiSpacing.xxs),
                  Text(product.displayName, style: MarkeiText.sectionTitle),
                  Text(product.displayBrand),
                  const SizedBox(height: MarkeiSpacing.sm),
                  Wrap(
                    spacing: MarkeiSpacing.lg,
                    runSpacing: MarkeiSpacing.xs,
                    children: [
                      MarkeiFact(label: 'Mode', value: _modeLabel(product)),
                      MarkeiFact(
                        label: 'Package',
                        value: _packageLabel(product),
                      ),
                      MarkeiFact(
                        label: 'Measurement',
                        value: product.measurementKind.name,
                      ),
                    ],
                  ),
                  const SizedBox(height: MarkeiSpacing.sm),
                  OutlinedButton(
                    key: Key('products.view.${product.id.value}'),
                    onPressed: () => onDetail(product),
                    child: const Text('View details'),
                  ),
                ],
              ),
            ),
          ),
          if (product != products.last)
            const SizedBox(height: MarkeiSpacing.sm),
        ],
      ],
    );
  }
}

class _ProductDetail extends StatelessWidget {
  const _ProductDetail({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final package = product.packageQuantity;
    return MarkeiCard(
      key: const Key('products.detail'),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Product details', style: MarkeiText.sectionTitle),
            const SizedBox(height: MarkeiSpacing.sm),
            Wrap(
              spacing: MarkeiSpacing.lg,
              runSpacing: MarkeiSpacing.xs,
              children: [
                MarkeiFact(
                  label: 'Code',
                  value: product.userProductCode.displayValue,
                ),
                MarkeiFact(label: 'Name', value: product.displayName),
                MarkeiFact(label: 'Brand', value: product.displayBrand),
                MarkeiFact(label: 'Mode', value: _modeLabel(product)),
                if (package != null)
                  MarkeiFact(
                    label: 'Package',
                    value: '${package.decimalText} ${package.unit.name}',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _modeLabel(Product product) {
  return product.mode == ProductMode.bulk ? 'Bulk' : 'Packaged';
}

String _packageLabel(Product product) {
  final package = product.packageQuantity;
  if (package == null) {
    return 'Bulk';
  }
  return '${package.decimalText} ${package.unit.name}';
}
