// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'regex_to_pattern.dart';

class RegexToPatternMapper extends SubClassMapperBase<RegexToPattern> {
  RegexToPatternMapper._();

  static RegexToPatternMapper? _instance;
  static RegexToPatternMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegexToPatternMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'RegexToPattern';

  static int _$id(RegexToPattern v) => v.id;
  static const Field<RegexToPattern, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(RegexToPattern v) => v.inputs;
  static const Field<RegexToPattern, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(RegexToPattern v) => v.offset;
  static const Field<RegexToPattern, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(RegexToPattern v) => v.label;
  static const Field<RegexToPattern, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(RegexToPattern v) => v.expanded;
  static const Field<RegexToPattern, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(RegexToPattern v) => v.getNode;
  static const Field<RegexToPattern, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<RegexToPattern> fields = const {
    #id: _f$id,
    #inputs: _f$inputs,
    #offset: _f$offset,
    #label: _f$label,
    #expanded: _f$expanded,
    #getNode: _f$getNode,
  };

  @override
  final String discriminatorKey = '__type';
  @override
  final dynamic discriminatorValue = 'regex_to_pattern';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static RegexToPattern _instantiate(DecodingData data) {
    return RegexToPattern(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static RegexToPattern fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegexToPattern>(map);
  }

  static RegexToPattern fromJson(String json) {
    return ensureInitialized().decodeJson<RegexToPattern>(json);
  }
}

mixin RegexToPatternMappable {
  String toJson() {
    return RegexToPatternMapper.ensureInitialized()
        .encodeJson<RegexToPattern>(this as RegexToPattern);
  }

  Map<String, dynamic> toMap() {
    return RegexToPatternMapper.ensureInitialized()
        .encodeMap<RegexToPattern>(this as RegexToPattern);
  }

  RegexToPatternCopyWith<RegexToPattern, RegexToPattern, RegexToPattern>
      get copyWith => _RegexToPatternCopyWithImpl(
          this as RegexToPattern, $identity, $identity);
  @override
  String toString() {
    return RegexToPatternMapper.ensureInitialized()
        .stringifyValue(this as RegexToPattern);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RegexToPatternMapper.ensureInitialized()
                .isValueEqual(this as RegexToPattern, other));
  }

  @override
  int get hashCode {
    return RegexToPatternMapper.ensureInitialized()
        .hashValue(this as RegexToPattern);
  }
}

extension RegexToPatternValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegexToPattern, $Out> {
  RegexToPatternCopyWith<$R, RegexToPattern, $Out> get $asRegexToPattern =>
      $base.as((v, t, t2) => _RegexToPatternCopyWithImpl(v, t, t2));
}

abstract class RegexToPatternCopyWith<$R, $In extends RegexToPattern, $Out>
    implements BaseNodeCopyWith<$R, $In, $Out> {
  @override
  MapCopyWith<$R, String, NodeInput<dynamic>,
      ObjectCopyWith<$R, NodeInput<dynamic>, NodeInput<dynamic>>> get inputs;
  @override
  $R call(
      {int? id,
      Map<String, NodeInput<dynamic>>? inputs,
      Signal<NodeOffset>? offset,
      Signal<String>? label,
      Signal<bool>? expanded});
  RegexToPatternCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RegexToPatternCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegexToPattern, $Out>
    implements RegexToPatternCopyWith<$R, RegexToPattern, $Out> {
  _RegexToPatternCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegexToPattern> $mapper =
      RegexToPatternMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, NodeInput<dynamic>,
          ObjectCopyWith<$R, NodeInput<dynamic>, NodeInput<dynamic>>>
      get inputs => MapCopyWith($value.inputs,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(inputs: v));
  @override
  $R call(
          {int? id,
          Map<String, NodeInput<dynamic>>? inputs,
          Signal<NodeOffset>? offset,
          Signal<String>? label,
          Signal<bool>? expanded}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (inputs != null) #inputs: inputs,
        if (offset != null) #offset: offset,
        if (label != null) #label: label,
        if (expanded != null) #expanded: expanded
      }));
  @override
  RegexToPattern $make(CopyWithData data) => RegexToPattern(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  RegexToPatternCopyWith<$R2, RegexToPattern, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RegexToPatternCopyWithImpl($value, $cast, t);
}
