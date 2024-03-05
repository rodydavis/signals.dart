// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_sign.dart';

class DoubleSignMapper extends SubClassMapperBase<DoubleSign> {
  DoubleSignMapper._();

  static DoubleSignMapper? _instance;
  static DoubleSignMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleSignMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleSign';

  static int _$id(DoubleSign v) => v.id;
  static const Field<DoubleSign, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleSign v) => v.inputs;
  static const Field<DoubleSign, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleSign v) => v.offset;
  static const Field<DoubleSign, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleSign v) => v.label;
  static const Field<DoubleSign, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleSign v) => v.expanded;
  static const Field<DoubleSign, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleSign v) => v.getNode;
  static const Field<DoubleSign, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleSign> fields = const {
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
  final dynamic discriminatorValue = 'double_sign';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleSign _instantiate(DecodingData data) {
    return DoubleSign(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleSign fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleSign>(map);
  }

  static DoubleSign fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleSign>(json);
  }
}

mixin DoubleSignMappable {
  String toJson() {
    return DoubleSignMapper.ensureInitialized()
        .encodeJson<DoubleSign>(this as DoubleSign);
  }

  Map<String, dynamic> toMap() {
    return DoubleSignMapper.ensureInitialized()
        .encodeMap<DoubleSign>(this as DoubleSign);
  }

  DoubleSignCopyWith<DoubleSign, DoubleSign, DoubleSign> get copyWith =>
      _DoubleSignCopyWithImpl(this as DoubleSign, $identity, $identity);
  @override
  String toString() {
    return DoubleSignMapper.ensureInitialized()
        .stringifyValue(this as DoubleSign);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleSignMapper.ensureInitialized()
                .isValueEqual(this as DoubleSign, other));
  }

  @override
  int get hashCode {
    return DoubleSignMapper.ensureInitialized().hashValue(this as DoubleSign);
  }
}

extension DoubleSignValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleSign, $Out> {
  DoubleSignCopyWith<$R, DoubleSign, $Out> get $asDoubleSign =>
      $base.as((v, t, t2) => _DoubleSignCopyWithImpl(v, t, t2));
}

abstract class DoubleSignCopyWith<$R, $In extends DoubleSign, $Out>
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
  DoubleSignCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleSignCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleSign, $Out>
    implements DoubleSignCopyWith<$R, DoubleSign, $Out> {
  _DoubleSignCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleSign> $mapper =
      DoubleSignMapper.ensureInitialized();
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
  DoubleSign $make(CopyWithData data) => DoubleSign(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleSignCopyWith<$R2, DoubleSign, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleSignCopyWithImpl($value, $cast, t);
}
