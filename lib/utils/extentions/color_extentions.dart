import 'package:flutter/material.dart';

extension ColorExtentions on Color {

  static fromHex({String code}) {
    var str = code.substring(1, 7);
    var bigint = int.parse(str, radix: 16);
    final r = (bigint >> 16) & 255;
    final g = (bigint >> 8) & 255;
    final b = bigint & 255;
    final a = 255;
    return Color.fromARGB(a, r, g, b);
  }

  MaterialColor toMaterial() {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = this.red, g = this.green, b = this.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(this.value, swatch);
  }
}
