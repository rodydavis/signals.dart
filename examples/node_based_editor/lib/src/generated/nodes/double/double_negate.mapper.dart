// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_negate.dart';

class DoubleNegateMapper extends SubClassMapperBase<DoubleNegate> {
  DoubleNegateMapper._();

  static DoubleNegateMapper? _instance;
  static DoubleNegateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleNegateMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleNegate';

  static int _$id(DoubleNegate v) => v.id;
  static const Field<DoubleNegate, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleNegate v) => v.inputs;
  static const Field<DoubleNegate, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleNegate v) => v.offset;
  static const Field<DoubleNegate, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleNegate v) => v.label;
  static const Field<DoubleNegate, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleNegate v) => v.expanded;
  static const Field<DoubleNegate, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleNegate v) => v.getNode;
  static const Field<DoubleNegate, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleNegate> fields = const {
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
  final dynamic discriminatorValue = 'double_negate';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleNegate _instantiate(DecodingData data) {
    return DoubleNegate(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleNegate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleNegate>(map);
  }

  static DoubleNegate fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleNegate>(json);
  }
}

mixin DoubleNegateMappable {
  String toJson() {
    return DoubleNegateMapper.ensureInitialized()
        .encodeJson<DoubleNegate>(this as DoubleNegate);
  }

  Map<String, dynamic> toMap() {
    return DoubleNegateMapper.ensureInitialized()
        .encodeMap<DoubleNegate>(this as DoubleNegate);
  }

  DoubleNegateCopyWith<DoubleNegate, DoubleNegate, DoubleNegate> get copyWith =>
      _DoubleNegateCopyWithImpl(this as DoubleNegate, $identity, $identity);
  @override
  String toString() {
    return DoubleNegateMapper.ensureInitialized()
        .stringifyValue(this as DoubleNegate);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleNegateMapper.ensureInitialized()
                .isValueEqual(this as DoubleNegate, other));
  }

  @override
  int get hashCode {
    return DoubleNegateMapper.ensureInitialized()
        .hashValue(this as DoubleNegate);
  }
}

extension DoubleNegateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleNegate, $Out> {
  DoubleNegateCopyWith<$R, DoubleNegate, $Out> get $asDoubleNegate =>
      $base.as((v, t, t2) => _DoubleNegateCopyWithImpl(v, t, t2));
}

abstract class DoubleNegateCopyWith<$R, $In extends DoubleNegate, $Out>
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
  DoubleNegateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleNegateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleNegate, $Out>
    implements DoubleNegateCopyWith<$R, DoubleNegate, $Out> {
  _DoubleNegateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleNegate> $mapper =
      DoubleNegateMapper.ensureInitialized();
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
  DoubleNegate $make(CopyWithData data) => DoubleNegate(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleNegateCopyWith<$R2, DoubleNegate, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleNegateCopyWithImpl($value, $cast, t);
}
