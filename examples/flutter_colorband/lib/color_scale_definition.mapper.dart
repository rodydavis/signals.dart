// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'color_scale_definition.dart';

class ColorScaleDefMapper extends ClassMapperBase<ColorScaleDef> {
  ColorScaleDefMapper._();

  static ColorScaleDefMapper? _instance;
  static ColorScaleDefMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ColorScaleDefMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ColorScaleDef';

  static Color _$color(ColorScaleDef v) => v.color;
  static const Field<ColorScaleDef, Color> _f$color = Field('color', _$color);
  static int _$darkColorsCount(ColorScaleDef v) => v.darkColorsCount;
  static const Field<ColorScaleDef, int> _f$darkColorsCount =
      Field('darkColorsCount', _$darkColorsCount, opt: true, def: 4);
  static int _$lightColorsCount(ColorScaleDef v) => v.lightColorsCount;
  static const Field<ColorScaleDef, int> _f$lightColorsCount =
      Field('lightColorsCount', _$lightColorsCount, opt: true, def: 6);
  static int _$darkness(ColorScaleDef v) => v.darkness;
  static const Field<ColorScaleDef, int> _f$darkness =
      Field('darkness', _$darkness, opt: true, def: 50);
  static int _$lightness(ColorScaleDef v) => v.lightness;
  static const Field<ColorScaleDef, int> _f$lightness =
      Field('lightness', _$lightness, opt: true, def: 80);
  static int _$darkHueAngle(ColorScaleDef v) => v.darkHueAngle;
  static const Field<ColorScaleDef, int> _f$darkHueAngle =
      Field('darkHueAngle', _$darkHueAngle, opt: true, def: 51);
  static int _$lightHueAngle(ColorScaleDef v) => v.lightHueAngle;
  static const Field<ColorScaleDef, int> _f$lightHueAngle =
      Field('lightHueAngle', _$lightHueAngle, opt: true, def: 67);
  static int _$darkSaturation(ColorScaleDef v) => v.darkSaturation;
  static const Field<ColorScaleDef, int> _f$darkSaturation =
      Field('darkSaturation', _$darkSaturation, opt: true, def: 14);
  static int _$lightSaturation(ColorScaleDef v) => v.lightSaturation;
  static const Field<ColorScaleDef, int> _f$lightSaturation =
      Field('lightSaturation', _$lightSaturation, opt: true, def: 20);

  @override
  final Map<Symbol, Field<ColorScaleDef, dynamic>> fields = const {
    #color: _f$color,
    #darkColorsCount: _f$darkColorsCount,
    #lightColorsCount: _f$lightColorsCount,
    #darkness: _f$darkness,
    #lightness: _f$lightness,
    #darkHueAngle: _f$darkHueAngle,
    #lightHueAngle: _f$lightHueAngle,
    #darkSaturation: _f$darkSaturation,
    #lightSaturation: _f$lightSaturation,
  };

  static ColorScaleDef _instantiate(DecodingData data) {
    return ColorScaleDef(
        color: data.dec(_f$color),
        darkColorsCount: data.dec(_f$darkColorsCount),
        lightColorsCount: data.dec(_f$lightColorsCount),
        darkness: data.dec(_f$darkness),
        lightness: data.dec(_f$lightness),
        darkHueAngle: data.dec(_f$darkHueAngle),
        lightHueAngle: data.dec(_f$lightHueAngle),
        darkSaturation: data.dec(_f$darkSaturation),
        lightSaturation: data.dec(_f$lightSaturation));
  }

  @override
  final Function instantiate = _instantiate;

  static ColorScaleDef fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ColorScaleDef>(map);
  }

  static ColorScaleDef fromJson(String json) {
    return ensureInitialized().decodeJson<ColorScaleDef>(json);
  }
}

mixin ColorScaleDefMappable {
  String toJson() {
    return ColorScaleDefMapper.ensureInitialized()
        .encodeJson<ColorScaleDef>(this as ColorScaleDef);
  }

  Map<String, dynamic> toMap() {
    return ColorScaleDefMapper.ensureInitialized()
        .encodeMap<ColorScaleDef>(this as ColorScaleDef);
  }

  ColorScaleDefCopyWith<ColorScaleDef, ColorScaleDef, ColorScaleDef>
      get copyWith => _ColorScaleDefCopyWithImpl(
          this as ColorScaleDef, $identity, $identity);
  @override
  String toString() {
    return ColorScaleDefMapper.ensureInitialized()
        .stringifyValue(this as ColorScaleDef);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ColorScaleDefMapper.ensureInitialized()
                .isValueEqual(this as ColorScaleDef, other));
  }

  @override
  int get hashCode {
    return ColorScaleDefMapper.ensureInitialized()
        .hashValue(this as ColorScaleDef);
  }
}

extension ColorScaleDefValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ColorScaleDef, $Out> {
  ColorScaleDefCopyWith<$R, ColorScaleDef, $Out> get $asColorScaleDef =>
      $base.as((v, t, t2) => _ColorScaleDefCopyWithImpl(v, t, t2));
}

abstract class ColorScaleDefCopyWith<$R, $In extends ColorScaleDef, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {Color? color,
      int? darkColorsCount,
      int? lightColorsCount,
      int? darkness,
      int? lightness,
      int? darkHueAngle,
      int? lightHueAngle,
      int? darkSaturation,
      int? lightSaturation});
  ColorScaleDefCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ColorScaleDefCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ColorScaleDef, $Out>
    implements ColorScaleDefCopyWith<$R, ColorScaleDef, $Out> {
  _ColorScaleDefCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ColorScaleDef> $mapper =
      ColorScaleDefMapper.ensureInitialized();
  @override
  $R call(
          {Color? color,
          int? darkColorsCount,
          int? lightColorsCount,
          int? darkness,
          int? lightness,
          int? darkHueAngle,
          int? lightHueAngle,
          int? darkSaturation,
          int? lightSaturation}) =>
      $apply(FieldCopyWithData({
        if (color != null) #color: color,
        if (darkColorsCount != null) #darkColorsCount: darkColorsCount,
        if (lightColorsCount != null) #lightColorsCount: lightColorsCount,
        if (darkness != null) #darkness: darkness,
        if (lightness != null) #lightness: lightness,
        if (darkHueAngle != null) #darkHueAngle: darkHueAngle,
        if (lightHueAngle != null) #lightHueAngle: lightHueAngle,
        if (darkSaturation != null) #darkSaturation: darkSaturation,
        if (lightSaturation != null) #lightSaturation: lightSaturation
      }));
  @override
  ColorScaleDef $make(CopyWithData data) => ColorScaleDef(
      color: data.get(#color, or: $value.color),
      darkColorsCount: data.get(#darkColorsCount, or: $value.darkColorsCount),
      lightColorsCount:
          data.get(#lightColorsCount, or: $value.lightColorsCount),
      darkness: data.get(#darkness, or: $value.darkness),
      lightness: data.get(#lightness, or: $value.lightness),
      darkHueAngle: data.get(#darkHueAngle, or: $value.darkHueAngle),
      lightHueAngle: data.get(#lightHueAngle, or: $value.lightHueAngle),
      darkSaturation: data.get(#darkSaturation, or: $value.darkSaturation),
      lightSaturation: data.get(#lightSaturation, or: $value.lightSaturation));

  @override
  ColorScaleDefCopyWith<$R2, ColorScaleDef, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ColorScaleDefCopyWithImpl($value, $cast, t);
}
