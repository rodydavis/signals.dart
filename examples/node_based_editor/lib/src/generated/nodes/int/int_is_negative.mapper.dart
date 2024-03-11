// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_is_negative.dart';

class IntIsNegativeMapper extends SubClassMapperBase<IntIsNegative> {
  IntIsNegativeMapper._();

  static IntIsNegativeMapper? _instance;
  static IntIsNegativeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntIsNegativeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntIsNegative';

  static int _$id(IntIsNegative v) => v.id;
  static const Field<IntIsNegative, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntIsNegative v) => v.inputs;
  static const Field<IntIsNegative, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntIsNegative v) => v.offset;
  static const Field<IntIsNegative, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntIsNegative v) => v.label;
  static const Field<IntIsNegative, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntIsNegative v) => v.expanded;
  static const Field<IntIsNegative, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntIsNegative v) => v.getNode;
  static const Field<IntIsNegative, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntIsNegative> fields = const {
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
  final dynamic discriminatorValue = 'int_is_negative';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntIsNegative _instantiate(DecodingData data) {
    return IntIsNegative(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntIsNegative fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntIsNegative>(map);
  }

  static IntIsNegative fromJson(String json) {
    return ensureInitialized().decodeJson<IntIsNegative>(json);
  }
}

mixin IntIsNegativeMappable {
  String toJson() {
    return IntIsNegativeMapper.ensureInitialized()
        .encodeJson<IntIsNegative>(this as IntIsNegative);
  }

  Map<String, dynamic> toMap() {
    return IntIsNegativeMapper.ensureInitialized()
        .encodeMap<IntIsNegative>(this as IntIsNegative);
  }

  IntIsNegativeCopyWith<IntIsNegative, IntIsNegative, IntIsNegative>
      get copyWith => _IntIsNegativeCopyWithImpl(
          this as IntIsNegative, $identity, $identity);
  @override
  String toString() {
    return IntIsNegativeMapper.ensureInitialized()
        .stringifyValue(this as IntIsNegative);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntIsNegativeMapper.ensureInitialized()
                .isValueEqual(this as IntIsNegative, other));
  }

  @override
  int get hashCode {
    return IntIsNegativeMapper.ensureInitialized()
        .hashValue(this as IntIsNegative);
  }
}

extension IntIsNegativeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntIsNegative, $Out> {
  IntIsNegativeCopyWith<$R, IntIsNegative, $Out> get $asIntIsNegative =>
      $base.as((v, t, t2) => _IntIsNegativeCopyWithImpl(v, t, t2));
}

abstract class IntIsNegativeCopyWith<$R, $In extends IntIsNegative, $Out>
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
  IntIsNegativeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntIsNegativeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntIsNegative, $Out>
    implements IntIsNegativeCopyWith<$R, IntIsNegative, $Out> {
  _IntIsNegativeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntIsNegative> $mapper =
      IntIsNegativeMapper.ensureInitialized();
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
  IntIsNegative $make(CopyWithData data) => IntIsNegative(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntIsNegativeCopyWith<$R2, IntIsNegative, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntIsNegativeCopyWithImpl($value, $cast, t);
}
