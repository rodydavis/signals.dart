// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_to_string.dart';

class DoubleToStringMapper extends SubClassMapperBase<DoubleToString> {
  DoubleToStringMapper._();

  static DoubleToStringMapper? _instance;
  static DoubleToStringMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleToStringMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleToString';

  static int _$id(DoubleToString v) => v.id;
  static const Field<DoubleToString, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleToString v) => v.inputs;
  static const Field<DoubleToString, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleToString v) => v.offset;
  static const Field<DoubleToString, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleToString v) => v.label;
  static const Field<DoubleToString, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleToString v) => v.expanded;
  static const Field<DoubleToString, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleToString v) => v.getNode;
  static const Field<DoubleToString, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleToString> fields = const {
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
  final dynamic discriminatorValue = 'double_to_string';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleToString _instantiate(DecodingData data) {
    return DoubleToString(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleToString fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleToString>(map);
  }

  static DoubleToString fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleToString>(json);
  }
}

mixin DoubleToStringMappable {
  String toJson() {
    return DoubleToStringMapper.ensureInitialized()
        .encodeJson<DoubleToString>(this as DoubleToString);
  }

  Map<String, dynamic> toMap() {
    return DoubleToStringMapper.ensureInitialized()
        .encodeMap<DoubleToString>(this as DoubleToString);
  }

  DoubleToStringCopyWith<DoubleToString, DoubleToString, DoubleToString>
      get copyWith => _DoubleToStringCopyWithImpl(
          this as DoubleToString, $identity, $identity);
  @override
  String toString() {
    return DoubleToStringMapper.ensureInitialized()
        .stringifyValue(this as DoubleToString);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleToStringMapper.ensureInitialized()
                .isValueEqual(this as DoubleToString, other));
  }

  @override
  int get hashCode {
    return DoubleToStringMapper.ensureInitialized()
        .hashValue(this as DoubleToString);
  }
}

extension DoubleToStringValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleToString, $Out> {
  DoubleToStringCopyWith<$R, DoubleToString, $Out> get $asDoubleToString =>
      $base.as((v, t, t2) => _DoubleToStringCopyWithImpl(v, t, t2));
}

abstract class DoubleToStringCopyWith<$R, $In extends DoubleToString, $Out>
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
  DoubleToStringCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleToStringCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleToString, $Out>
    implements DoubleToStringCopyWith<$R, DoubleToString, $Out> {
  _DoubleToStringCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleToString> $mapper =
      DoubleToStringMapper.ensureInitialized();
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
  DoubleToString $make(CopyWithData data) => DoubleToString(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleToStringCopyWith<$R2, DoubleToString, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleToStringCopyWithImpl($value, $cast, t);
}
