import 'package:flutter/material.dart';

AppColorsBase colorsManagerNormal = _ColorsManagerDeepBlue();


// ========================== 🔥 Abstract Base Colors Class 🔥 ==========================

abstract class AppColorsBase {
  // ========================== 🔥 Primary Colors 🔥 ==========================

  /// Main primary color used throughout the app.
  Color get primary;


  Color get secondaryPrimary;

  // ========================== 🔥 Text Colors 🔥 ==========================

  /// Default text color for general content.
  Color get textPrimary;

  /// Secondary text color for less emphasis content.
  Color get textSecondary;

  // ========================== 🔥 Background Colors 🔥 ==========================

  /// General background color for screens and containers.
  Color get background;

  /// Background color for cards and elevated containers.
  Color get cardBackground;

  /// Divider or section background to separate content.
  Color get divider;

  // ========================== 🔥 Border Colors 🔥 ==========================

  /// Standard border color for inputs and containers.
  Color get border;

  // ========================== 🔥 Button Colors 🔥 ==========================

  /// Disabled button color for inactive states.
  Color get buttonDisabled;

  // ========================== 🔥 Status Colors 🔥 ==========================

  /// Success color for positive feedback.
  Color get success;

  /// Warning color for caution messages.
  Color get warning;

  /// Error color for error messages and indicators.
  Color get error;

  Color get info;
}

// ========================== 🔥 ColorsManagerNormal 🔥 ==========================

class _ColorsManagerDeepBlue implements AppColorsBase {
  // ========================== 🔥 Primary Colors 🔥 ==========================
  @override
  Color get primary => const Color(0xff04a6a8);


  @override
  Color get secondaryPrimary => const Color(0xFF1F78B4);

  // ========================== 🔥 Text Colors 🔥 ==========================
  @override
  Color get textPrimary => const Color(0xFF000000);

  @override
  Color get textSecondary => const Color(0xff8c8c8c);

  // ========================== 🔥 Background Colors 🔥 ==========================
  @override
  Color get background => const Color(0xFFFFFFFF);

  @override
  Color get cardBackground => const Color(0xFFFFFFFF);

  @override
  Color get divider => const Color(0xFFC5C5C5);

  // ========================== 🔥 Border Colors 🔥 ==========================
  @override
  Color get border => const Color(0xFFCBCBCB);

  // ========================== 🔥 Button Colors 🔥 ==========================
  @override
  Color get buttonDisabled => const Color(0xFFBDBDBD);

  // ========================== 🔥 Status Colors 🔥 ==========================
  @override
  Color get success => const Color(0xFF4CAF50);

  @override
  Color get warning => const Color(0xFFFFC107);

  @override
  Color get error => const Color(0xFFF44336);

  @override
  Color get info => const Color(0xFF2196F3);
}

