import 'dart:math';
import 'package:flutter/material.dart';

enum BrightnessMode { light, medium, dark }

class Colormanagement {
  static List<Color> generateGradient(
    Color baseColor, {
    BrightnessMode mode = BrightnessMode.medium,
  }) {
    final hsl = HSLColor.fromColor(baseColor);

    switch (mode) {
      case BrightnessMode.light:
        // Light mode: pastel to vivid highlight
        return [
          hsl
              .withSaturation((hsl.saturation * 0.7).clamp(0.0, 1.0))
              .withLightness((hsl.lightness + 0.35).clamp(0.0, 1.0))
              .toColor(),
          hsl
              .withSaturation((hsl.saturation + 0.3).clamp(0.0, 1.0))
              .withLightness((hsl.lightness - 0.05).clamp(0.0, 1.0))
              .toColor(),
        ];

      case BrightnessMode.dark:
        // Dark mode: rich color to almost black tone
        return [
          hsl
              .withSaturation((hsl.saturation + 0.25).clamp(0.0, 1.0))
              .withLightness((hsl.lightness - 0.25).clamp(0.0, 1.0))
              .toColor(),
          hsl
              .withSaturation((hsl.saturation + 0.15).clamp(0.0, 1.0))
              .withLightness((hsl.lightness - 0.45).clamp(0.0, 1.0))
              .toColor(),
        ];

      case BrightnessMode.medium:
      default:
        // Medium mode: vivid contrast, warm accent shift
        return [
          hsl
              .withHue((hsl.hue + 4) % 360)
              .withSaturation((hsl.saturation + 0.25).clamp(0.0, 1.0))
              .withLightness((hsl.lightness + 0.25).clamp(0.0, 1.0))
              .toColor(),
          hsl
              .withHue((hsl.hue - 5) % 360)
              .withSaturation((hsl.saturation + 0.45).clamp(0.0, 1.0))
              .withLightness((hsl.lightness - 0.25).clamp(0.0, 1.0))
              .toColor(),
        ];
    }
  }

  static Color hexStringToColor(String hexColorString) {
    // Remove the '#' prefix if it exists
    String hexColor = hexColorString.replaceAll("#", "");

    // Ensure the string has the correct length
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor; // Add full opacity (FF) if absent
    }

    return Color(int.parse("0x$hexColor"));
  }

  static BrightnessMode getRandomBrightnessMode() {
    final modes = BrightnessMode.values; // [light, medium, dark]
    final random = Random();
    return modes[random.nextInt(modes.length)];
  }
}
