import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'color_scale_definition.mapper.dart';

@MappableClass()
class ColorScaleDef with ColorScaleDefMappable {
  final Color color;

  final int darkColorsCount;
  final int lightColorsCount;
  final int darkness;
  final int lightness;
  final int darkHueAngle;
  final int lightHueAngle;
  final int darkSaturation;
  final int lightSaturation;

  ColorScaleDef({
    required this.color,
    this.darkColorsCount = 4,
    this.lightColorsCount = 6,
    this.darkness = 50,
    this.lightness = 80,
    this.darkHueAngle = 51,
    this.lightHueAngle = 67,
    this.darkSaturation = 14,
    this.lightSaturation = 20,
  });

  HSLColor get hsl => HSLColor.fromColor(color);

  List<List<HSLColor>> render() => [buildDarkColors(), buildLightColors()];

  List<HSLColor> buildDarkColors() {
    final rs = <HSLColor>[];

    final darkness = hsl.lightness - (hsl.lightness * this.darkness / 100);

    final darknessHue = (hsl.hue + darkHueAngle).clamp(.0, 360.0);

    double darknessSaturation = darkSaturation > 0
        ? hsl.saturation + ((1 - hsl.saturation) * darkSaturation / 100)
        : hsl.saturation + hsl.saturation * darkSaturation / 100;

    final dark = hsl
        .withLightness(darkness)
        .withHue(darknessHue)
        .withSaturation(darknessSaturation);

    for (int i = 0; i < darkColorsCount; i++) {
      rs.add(HSLColor.lerp(dark, hsl, i * (1 / darkColorsCount))!);
    }

    assert(rs.length == darkColorsCount);

    return rs;
  }

  List<HSLColor> buildLightColors() {
    final rs = <HSLColor>[];

    final lightDiff = (1 - hsl.lightness) * this.lightness / 100;
    final lightness = hsl.lightness + lightDiff;

    final lightnessHue = (hsl.hue + lightHueAngle).clamp(.0, 360.0);

    double lightnessSaturation = lightSaturation > 0
        ? hsl.saturation + ((1 - hsl.saturation) * lightSaturation / 100)
        : hsl.saturation + hsl.saturation * lightSaturation / 100;

    final light = hsl
        .withLightness(lightness)
        .withHue(lightnessHue)
        .withSaturation(lightnessSaturation);

    for (int i = 0; i < lightColorsCount; i++) {
      rs.add(HSLColor.lerp(light, hsl, i * (1 / lightColorsCount))!);
    }

    assert(rs.length == lightColorsCount);

    return rs.reversed.toList();
  }
}
