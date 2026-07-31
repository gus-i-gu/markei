import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/pages/guide_page.dart';

void main() {
  testWidgets('Guide exposes eight local sections and focusable anchors', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: GuidePage())),
    );

    expect(find.byKey(const Key('guide.page')), findsOneWidget);
    for (var index = 1; index <= 8; index++) {
      final anchor = find.byKey(
        Key('guide.anchor.$index'),
        skipOffstage: false,
      );
      expect(anchor, findsOneWidget);
      await tester.ensureVisible(anchor);
      await tester.pumpAndSettle();
      await tester.tap(anchor);
      await tester.pumpAndSettle();
      expect(
        find.byKey(Key('guide.section.$index'), skipOffstage: false),
        findsOneWidget,
      );
    }
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Exports'), findsWidgets);
    expect(find.text('Settings'), findsWidgets);
  });
}
