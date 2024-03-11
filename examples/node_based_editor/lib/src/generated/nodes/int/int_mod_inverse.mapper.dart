// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_mod_inverse.dart';

class IntModInverseMapper extends SubClassMapperBase<IntModInverse> {
  IntModInverseMapper._();

  static IntModInverseMapper? _instance;
  static IntModInverseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntModInverseMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntModInverse';

  static int _$id(IntModInverse v) => v.id;
  static const Field<IntModInverse, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntModInverse v) => v.inputs;
  static const Field<IntModInverse, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntModInverse v) => v.offset;
  static const Field<IntModInverse, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntModInverse v) => v.label;
  static const Field<IntModInverse, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntModInverse v) => v.expanded;
  static const Field<IntModInverse, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntModInverse v) => v.getNode;
  static const Field<IntModInverse, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntModInverse> fields = const {
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
  final dynamic discriminatorValue = 'int_mod_inverse';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntModInverse _instantiate(DecodingData data) {
    return IntModInverse(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntModInverse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntModInverse>(map);
  }

  static IntModInverse fromJson(String json) {
    return ensureInitialized().decodeJson<IntModInverse>(json);
  }
}

mixin IntModInverseMappable {
  String toJson() {
    return IntModInverseMapper.ensureInitialized()
        .encodeJson<IntModInverse>(this as IntModInverse);
  }

  Map<String, dynamic> toMap() {
    return IntModInverseMapper.ensureInitialized()
        .encodeMap<IntModInverse>(this as IntModInverse);
  }

  IntModInverseCopyWith<IntModInverse, IntModInverse, IntModInverse>
      get copyWith => _IntModInverseCopyWithImpl(
          this as IntModInverse, $identity, $identity);
  @override
  String toString() {
    return IntModInverseMapper.ensureInitialized()
        .stringifyValue(this as IntModInverse);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntModInverseMapper.ensureInitialized()
                .isValueEqual(this as IntModInverse, other));
  }

  @override
  int get hashCode {
    return IntModInverseMapper.ensureInitialized()
        .hashValue(this as IntModInverse);
  }
}

extension IntModInverseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntModInverse, $Out> {
  IntModInverseCopyWith<$R, IntModInverse, $Out> get $asIntModInverse =>
      $base.as((v, t, t2) => _IntModInverseCopyWithImpl(v, t, t2));
}

abstract class IntModInverseCopyWith<$R, $In extends IntModInverse, $Out>
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
  IntModInverseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntModInverseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntModInverse, $Out>
    implements IntModInverseCopyWith<$R, IntModInverse, $Out> {
  _IntModInverseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntModInverse> $mapper =
      IntModInverseMapper.ensureInitialized();
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
  IntModInverse $make(CopyWithData data) => IntModInverse(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntModInverseCopyWith<$R2, IntModInverse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntModInverseCopyWithImpl($value, $cast, t);
}
