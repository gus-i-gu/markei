import 'package:flutter/material.dart';

abstract final class MarkeiColors {
  static const cream = Color(0xfffcfbfa);
  static const surface = Color(0xffffffff);
  static const elevatedSurface = Color(0xffffffff);
  static const secondarySurface = Color(0xfff7f6f3);
  static const green = Color(0xff105028);
  static const greenTint = Color(0xffe7f0e9);
  static const navigationSelected = Color(0xffe8e9e6);
  static const lavender = Color(0xff6554b2);
  static const lavenderTint = Color(0xfff0ecf8);
  static const warning = Color(0xffc96816);
  static const warningTint = Color(0xfffbf1e7);
  static const danger = Color(0xffb43a32);
  static const dangerTint = Color(0xfffaeceb);
  static const information = Color(0xff3f6f8f);
  static const informationTint = Color(0xffedf4f8);
  static const ink = Color(0xff1e2622);
  static const mutedInk = Color(0xff66706a);
  static const outline = Color(0xffdfe2dd);
}

enum MarkeiLayoutClass {
  compact,
  medium,
  wide;

  static MarkeiLayoutClass fromWidth(double width) {
    if (width < MarkeiBreakpoints.medium) {
      return MarkeiLayoutClass.compact;
    }
    if (width < MarkeiBreakpoints.wide) {
      return MarkeiLayoutClass.medium;
    }
    return MarkeiLayoutClass.wide;
  }
}

abstract final class MarkeiBreakpoints {
  static const double medium = 600;
  static const double wide = 1024;
}

abstract final class MarkeiSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double controlHeight = 48;
  static const double visibleControlHeight = 40;
  static const double compactGutter = 16;
  static const double mediumGutter = 24;
  static const double wideGutter = 32;
  static const double maxContentWidth = 1220;
  static const double navRailExtendedWidth = 232;
  static const double tableHeadingHeight = 42;
  static const double tableRowHeight = 46;
}

abstract final class MarkeiRadius {
  static const double sm = 6;
  static const double md = 8;
}

abstract final class MarkeiText {
  static const pageTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 32 / 26,
  );
  static const sectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 22 / 16,
  );
  static const body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
  );
  static const label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 16 / 13,
  );
  static const tableLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
  );
  static const metadata = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    color: MarkeiColors.mutedInk,
  );
  static const numeric = TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.w700,
    height: 28 / 23,
  );
}

ThemeData markeiTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: MarkeiColors.green,
    primary: MarkeiColors.green,
    secondary: MarkeiColors.lavender,
    surface: MarkeiColors.surface,
    error: MarkeiColors.danger,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: const TextTheme(
      headlineMedium: MarkeiText.pageTitle,
      titleMedium: MarkeiText.sectionTitle,
      bodyMedium: MarkeiText.body,
      labelLarge: MarkeiText.label,
    ),
    scaffoldBackgroundColor: MarkeiColors.cream,
    cardTheme: const CardThemeData(
      color: MarkeiColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: MarkeiColors.surface,
      constraints: BoxConstraints(minHeight: MarkeiSpacing.controlHeight),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(
          const Size(0, MarkeiSpacing.controlHeight),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, MarkeiSpacing.controlHeight),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, MarkeiSpacing.controlHeight),
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: MarkeiColors.surface,
      useIndicator: true,
      indicatorColor: MarkeiColors.navigationSelected,
      selectedIconTheme: const IconThemeData(color: MarkeiColors.green),
      selectedLabelTextStyle: const TextStyle(
        color: MarkeiColors.green,
        fontWeight: FontWeight.w700,
      ),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: MarkeiColors.surface,
      indicatorColor: MarkeiColors.navigationSelected,
    ),
    dividerTheme: const DividerThemeData(color: MarkeiColors.outline),
    dataTableTheme: const DataTableThemeData(
      headingRowHeight: MarkeiSpacing.tableHeadingHeight,
      dataRowMinHeight: MarkeiSpacing.tableRowHeight,
      dataRowMaxHeight: 64,
      dividerThickness: 1,
      headingTextStyle: MarkeiText.tableLabel,
      dataTextStyle: MarkeiText.body,
    ),
  );
}
