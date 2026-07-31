import 'package:flutter/material.dart';

abstract final class MarkeiColors {
  static const cream = Color(0xfff6f1e8);
  static const surface = Color(0xfffffcf6);
  static const elevatedSurface = Color(0xffffffff);
  static const green = Color(0xff1f5f4b);
  static const lavender = Color(0xff8270c8);
  static const warning = Color(0xffb45f06);
  static const danger = Color(0xffb3261e);
  static const information = Color(0xff386a8c);
  static const ink = Color(0xff1d2a24);
  static const mutedInk = Color(0xff64736b);
  static const outline = Color(0xffd8d0c4);
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
  static const double compactGutter = 12;
  static const double mediumGutter = 20;
  static const double wideGutter = 28;
  static const double maxContentWidth = 1180;
  static const double navRailExtendedWidth = 192;
}

abstract final class MarkeiRadius {
  static const double sm = 6;
  static const double md = 8;
}

abstract final class MarkeiText {
  static const pageTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );
  static const sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );
  static const body = TextStyle(fontSize: 14, height: 1.35);
  static const label = TextStyle(fontSize: 13, fontWeight: FontWeight.w700);
  static const metadata = TextStyle(fontSize: 12, color: MarkeiColors.mutedInk);
  static const numeric = TextStyle(fontSize: 22, fontWeight: FontWeight.w800);
}

ThemeData markeiTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: MarkeiColors.green,
    primary: MarkeiColors.green,
    secondary: MarkeiColors.lavender,
    surface: MarkeiColors.surface,
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
      selectedIconTheme: const IconThemeData(color: MarkeiColors.green),
      selectedLabelTextStyle: const TextStyle(
        color: MarkeiColors.green,
        fontWeight: FontWeight.w700,
      ),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: MarkeiColors.surface,
      indicatorColor: Color(0xffdfeee4),
    ),
  );
}
