import 'package:flutter/material.dart';

/// A class that holds default values for UI elements.
/// This ensures a consistent look and feel across the app.
class AppDefaults {
  /// Private constructor to prevent instantiation.
  AppDefaults._();

  // Default padding and margin values
  static const double padding = 16.0;
  static const double margin = 16.0;

  // Default border radius
  static final BorderRadius borderRadius = BorderRadius.circular(12.0);

  // Default box shadow
  static final List<BoxShadow> boxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      spreadRadius: 1,
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ];
}