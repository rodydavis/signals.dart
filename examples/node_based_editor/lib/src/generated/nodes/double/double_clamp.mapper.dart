// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_clamp.dart';

class DoubleClampMapper extends SubClassMapperBase<DoubleClamp> {
  DoubleClampMapper._();

  static DoubleClampMapper? _instance;
  static DoubleClampMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleClampMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleClamp';

  static int _$id(DoubleClamp v) => v.id;
  static const Field<DoubleClamp, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleClamp v) => v.inputs;
  static const Field<DoubleClamp, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleClamp v) => v.offset;
  static const Field<DoubleClamp, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleClamp v) => v.label;
  static const Field<DoubleClamp, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleClamp v) => v.expanded;
  static const Field<DoubleClamp, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleClamp v) => v.getNode;
  static const Field<DoubleClamp, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleClamp> fields = const {
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
  final dynamic discriminatorValue = 'double_clamp';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleClamp _instantiate(DecodingData data) {
    return DoubleClamp(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleClamp fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleClamp>(map);
  }

  static DoubleClamp fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleClamp>(json);
  }
}

mixin DoubleClampMappable {
  String toJson() {
    return DoubleClampMapper.ensureInitialized()
        .encodeJson<DoubleClamp>(this as DoubleClamp);
  }

  Map<String, dynamic> toMap() {
    return DoubleClampMapper.ensureInitialized()
        .encodeMap<DoubleClamp>(this as DoubleClamp);
  }

  DoubleClampCopyWith<DoubleClamp, DoubleClamp, DoubleClamp> get copyWith =>
      _DoubleClampCopyWithImpl(this as DoubleClamp, $identity, $identity);
  @override
  String toString() {
    return DoubleClampMapper.ensureInitialized()
        .stringifyValue(this as DoubleClamp);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleClampMapper.ensureInitialized()
                .isValueEqual(this as DoubleClamp, other));
  }

  @override
  int get hashCode {
    return DoubleClampMapper.ensureInitialized().hashValue(this as DoubleClamp);
  }
}

extension DoubleClampValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleClamp, $Out> {
  DoubleClampCopyWith<$R, DoubleClamp, $Out> get $asDoubleClamp =>
      $base.as((v, t, t2) => _DoubleClampCopyWithImpl(v, t, t2));
}

abstract class DoubleClampCopyWith<$R, $In extends DoubleClamp, $Out>
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
  DoubleClampCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleClampCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleClamp, $Out>
    implements DoubleClampCopyWith<$R, DoubleClamp, $Out> {
  _DoubleClampCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleClamp> $mapper =
      DoubleClampMapper.ensureInitialized();
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
  DoubleClamp $make(CopyWithData data) => DoubleClamp(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleClampCopyWith<$R2, DoubleClamp, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleClampCopyWithImpl($value, $cast, t);
}
