import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/markei_app.dart';
import 'package:markei/app/markei_composition.dart';
import 'package:markei/app/pages/home_page.dart';
import 'package:markei/application/language_preference.dart';
import 'package:markei/application/analytics.dart';
import 'package:markei/application/analytics_workspace.dart';
import 'package:markei/domain/analytics/analytics_models.dart';
import 'package:markei/domain/analytics/analytics_registry.dart';
import 'package:markei/l10n/analytics_copy.dart';
import 'package:markei/application/history_export.dart';
import 'package:markei/application/purchase_history.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/infrastructure/local/local_database.dart' hide Product;
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';
import 'package:markei/infrastructure/platform/file_language_preference.dart';
import 'package:markei/l10n/language_controller.dart';
import 'package:markei/l10n/marc_localizations.dart';
import 'package:markei/l10n/messages.g.dart';
import '../application/analytics_axes_test.dart' as fixture;

const account = AccountId('locale-account');
const device = DeviceId('locale-device');

void main() {
  test(
    'localized Analytics reports retain the frozen calculations and counts',
    () async {
      final repository = _AnalyticsEvidence();
      final controller = AnalyticsWorkspaceController(
        accountId: account,
        repository: repository,
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      controller.setDeterminant(AnalyticsDeterminantKind.timeMonthUtc);
      controller.selectAllDeterminants();
      controller.toggleVariable(AnalyticsVariable.unitPrice);
      controller.setOperation(AnalyticsOperation.mean);
      controller.runAndSave();
      final record = controller.snapshot.records.single;
      final fingerprint = record.fingerprint;
      final values = record.entries
          .map((e) => (e.value as AnalyticsIntegerResultValue).value)
          .toList();
      final source = record.interpretation;
      final translated = localizedAnalyticsInterpretation(
        record,
        const MarcMessages('pt'),
      );
      expect(translated, contains('Média'));
      expect(translated, contains('2 itens contidos'));
      expect(translated, contains('2 grupo(s)'));
      final pdf = ascii.decode(
        analyticsRecordPdfBytes(record, messages: const MarcMessages('pt')),
      );
      expect(pdf, contains('Tabela de resultados'));
      expect(pdf, contains(r'An\341lises'));
      final csv = analyticsRecordCsv(
        record,
        await repository.loadEvidence(account),
        messages: const MarcMessages('es'),
      );
      expect(csv, contains('Nescau'));
      expect(csv, contains('Condor'));
      expect(csv, contains('10.00'));
      expect(record.interpretation, source);
      expect(record.fingerprint, fingerprint);
      expect(
        record.entries
            .map((e) => (e.value as AnalyticsIntegerResultValue).value)
            .toList(),
        values,
      );
    },
  );
  test('all catalogues have identical keys and placeholders', () {
    final source = messagesEn.keys.toSet();
    expect(messagesPt.keys.toSet(), source);
    expect(messagesEs.keys.toSet(), source);
    for (final text in source) {
      Set<String> parameters(String text) =>
          RegExp(r'\{p\d+\}').allMatches(text).map((m) => m[0]!).toSet();
      expect(parameters(messagesPt[text]!), parameters(text), reason: text);
      expect(parameters(messagesEs[text]!), parameters(text), reason: text);
    }
  });

  test('mixed messages preserve user input and diagnostic codes', () {
    const pt = MarcMessages('pt');
    const es = MarcMessages('es');
    expect(pt.message('Welcome, {p0}', ['Home']), 'Boas-vindas, Home');
    expect(es.message('Purchase at {p0}', ['Settings']), 'Compra en Settings');
    expect(
      pt.display('Enrollment: device-enrolled'),
      'Cadastro do dispositivo: device-enrolled',
    );
    expect(
      es.display('Pending 2, uploading 0, failed 0, unknown 0'),
      'Pendientes 2, enviando 0, fallidos 0, desconocidos 0',
    );
    expect(pt.numericCopy('BRL 12.34'), 'BRL 12,34');
    expect(pt.display('Readiness: unavailable'), 'Prontidão: unavailable');
    expect(
      pt.display(
        'purchase-registration-resolve-product-failed: Purchase registration failed. The operation was not applied. The operation was rolled back. Keep the draft and report this code. The draft is still available.',
      ),
      contains('O registro da compra falhou.'),
    );
    expect(pt.display('258619dd'), '258619dd');
    expect(pt.message('Welcome, {p0}', ['{p1}']), 'Boas-vindas, {p1}');
  });

  test('language is persisted and can return to device language', () async {
    final directory = await Directory.systemTemp.createTemp('marc-language-');
    addTearDown(() => directory.delete(recursive: true));
    final repository = FileLanguagePreferenceRepository(
      directory: () async => directory,
    );
    final controller = LanguageController(repository);
    addTearDown(controller.dispose);
    await controller.load();
    expect(controller.selection, isNull);
    await controller.select('pt_BR');
    expect(controller.locale, const Locale('pt', 'BR'));
    final reopened = LanguageController(repository);
    addTearDown(reopened.dispose);
    await reopened.load();
    expect(reopened.selection, 'pt_BR');
    await reopened.select('es');
    expect(await repository.readLanguage(), 'es');
    await reopened.select(null);
    expect(await repository.readLanguage(), isNull);
  });

  test(
    'failed persistence keeps the prior preference; corrupt read is visible',
    () async {
      final repository = _FailingPreference();
      final controller = LanguageController(repository);
      addTearDown(controller.dispose);
      await controller.load();
      expect(controller.error, isNotNull);
      controller.selection = 'en';
      await controller.select('es');
      expect(controller.selection, 'en');
      expect(controller.error, contains('previous preference'));
    },
  );

  test(
    'history PDF supports Portuguese and Spanish accents without throwing',
    () {
      final bundle = PurchaseExportBundle(
        purchases: [
          PurchaseDetail(
            entry: PurchaseHistoryEntry(
              purchaseId: const PurchaseId('accent'),
              storeName: 'São João',
              occurrenceTime: DateTime.utc(2026, 10, 5, 12),
              currencyCode: 'BRL',
              totalMinorUnits: 1299,
              itemCount: 0,
              personLabel: 'José',
              paymentMethodLabel: 'Débito',
            ),
            items: const [],
          ),
        ],
      );
      final pt = ascii.decode(
        purchaseBundlePdfBytes(bundle, messages: const MarcMessages('pt')),
      );
      final es = ascii.decode(
        purchaseBundlePdfBytes(bundle, messages: const MarcMessages('es')),
      );
      expect(pt, contains('selecionadas'));
      expect(es, contains('seleccionadas'));
      expect(pt, contains('/WinAnsiEncoding'));
      expect(pt, contains(r'S\343o Jo\343o'));
      expect(es, contains(r'Jos\351'));
    },
  );

  testWidgets('unsupported device locale falls back to English', (
    tester,
  ) async {
    tester.platformDispatcher.localeTestValue = const Locale('ja');
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    await tester.pumpWidget(
      MaterialApp(
        supportedLocales: MarcLocalizations.supportedLocales,
        localizationsDelegates: const [
          MarcLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        home: Scaffold(body: HomePage(onNavigate: (_) {})),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Translations under review'), findsOneWidget);
    expect(find.text('Register purchase'), findsWidgets);
  });

  for (final language in ['pt_BR', 'es']) {
    testWidgets('$language pages translate and switching keeps a Purchase draft', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final queries = LocalQueryRepository(db);
      await queries.createStore(account, 'Home');
      await queries.createProduct(
        account,
        const ProductDraft(
          userCode: 'Settings',
          name: 'Home',
          brand: 'Store',
          mode: ProductMode.packaged,
          measurementKind: MeasurementKind.count,
          packageAmount: '1',
          packageUnit: 'unit',
        ),
      );
      final preferences = MemoryLanguagePreferenceRepository(language);
      final composition = MarkeiComposition(
        database: db,
        purchaseRegistration: LocalPurchaseRepository(db),
        catalogueQueries: queries,
        purchaseHistory: queries,
        references: queries,
        preferences: queries,
        productLists: queries,
        purchaseExports: queries,
        accountId: account,
        deviceId: device,
        languagePreferences: preferences,
      );
      await tester.pumpWidget(MarkeiApp(composition: composition));
      await _ready(tester);
      final copy = MarcMessages(language);
      expect(
        find.text(copy.display('Translations under review')),
        findsOneWidget,
      );
      for (final destination in [
        'Catalogue',
        'History',
        'Lists',
        'Household',
        'Guide',
        'Documentation',
        'Audit',
        'Analytics',
      ]) {
        await tester.tap(find.text(copy.display(destination)).first);
        await _ready(tester);
        expect(find.text(copy.display(destination)), findsWidgets);
        expect(tester.takeException(), isNull);
        if (destination == 'Catalogue') {
          expect(find.text('Home'), findsWidgets);
          expect(find.textContaining('Settings'), findsWidgets);
        }
      }
      await tester.tap(find.text(copy.display('Purchase')).first);
      await _ready(tester);
      await _enter(tester, 'product.name', 'My unchanged draft');
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('product.name')))
            .decoration!
            .labelText,
        contains(copy.display('Product name')),
      );
      await _enter(tester, 'purchase.date', '31022026');
      expect(
        find.text(copy.display('Enter a valid calendar date.')),
        findsOneWidget,
      );
      // Settings remains accessible while the draft page stays in IndexedStack.
      await tester.tap(find.text(copy.display('Settings')).first);
      await _ready(tester);
      final dropdown = find.byWidgetPredicate(
        (w) =>
            w is DropdownButtonFormField<String> &&
            w.key.toString().contains('settings.language.'),
      );
      await tester.ensureVisible(dropdown);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('English').last);
      await _ready(tester);
      expect(preferences.language, 'en');
      await tester.tap(find.text('Purchase').first);
      await _ready(tester);
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('product.name')))
            .controller!
            .text,
        'My unchanged draft',
      );
      // Display and stored Product fields remain user data, even when they match UI labels.
      final product = (await queries.listProducts(account)).single;
      expect(product.displayName, 'Home');
      expect(product.displayBrand, 'Store');
      expect(product.userProductCode.displayValue, 'Settings');
      expect(tester.takeException(), isNull);
    });
  }
}

Future<void> _ready(WidgetTester tester) async {
  for (var i = 0; i < 20; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _enter(WidgetTester tester, String key, String value) async {
  final field = find.byKey(Key(key));
  if (field.evaluate().isEmpty) {
    await tester.drag(
      find.byKey(const Key('purchase.page')),
      const Offset(0, 1500),
    );
    await _ready(tester);
  }
  await tester.ensureVisible(field);
  await _ready(tester);
  await tester.enterText(field, value);
  await _ready(tester);
}

class _FailingPreference implements LanguagePreferenceRepository {
  @override
  Future<String?> readLanguage() async => throw const FormatException();
  @override
  Future<void> writeLanguage(String? language) async =>
      throw const FileSystemException();
}

class _AnalyticsEvidence implements AnalyticsEvidenceRepository {
  @override
  Future<AnalyticsDataset> loadEvidence(AccountId accountId) async =>
      AnalyticsDataset(
        accountId: accountId,
        rows: [
          fixture.row('1', 'Nescau', 'Condor', 1, 1000),
          fixture.row('2', 'Nescau', 'Condor', 2, 2000),
        ],
      );
}
