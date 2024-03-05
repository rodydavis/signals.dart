// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_equal.dart';

class IntEqualMapper extends SubClassMapperBase<IntEqual> {
  IntEqualMapper._();

  static IntEqualMapper? _instance;
  static IntEqualMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntEqualMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntEqual';

  static int _$id(IntEqual v) => v.id;
  static const Field<IntEqual, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntEqual v) => v.inputs;
  static const Field<IntEqual, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntEqual v) => v.offset;
  static const Field<IntEqual, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntEqual v) => v.label;
  static const Field<IntEqual, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntEqual v) => v.expanded;
  static const Field<IntEqual, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntEqual v) => v.getNode;
  static const Field<IntEqual, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntEqual> fields = const {
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
  final dynamic discriminatorValue = 'int_equal';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntEqual _instantiate(DecodingData data) {
    return IntEqual(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntEqual fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntEqual>(map);
  }

  static IntEqual fromJson(String json) {
    return ensureInitialized().decodeJson<IntEqual>(json);
  }
}

mixin IntEqualMappable {
  String toJson() {
    return IntEqualMapper.ensureInitialized()
        .encodeJson<IntEqual>(this as IntEqual);
  }

  Map<String, dynamic> toMap() {
    return IntEqualMapper.ensureInitialized()
        .encodeMap<IntEqual>(this as IntEqual);
  }

  IntEqualCopyWith<IntEqual, IntEqual, IntEqual> get copyWith =>
      _IntEqualCopyWithImpl(this as IntEqual, $identity, $identity);
  @override
  String toString() {
    return IntEqualMapper.ensureInitialized().stringifyValue(this as IntEqual);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntEqualMapper.ensureInitialized()
                .isValueEqual(this as IntEqual, other));
  }

  @override
  int get hashCode {
    return IntEqualMapper.ensureInitialized().hashValue(this as IntEqual);
  }
}

extension IntEqualValueCopy<$R, $Out> on ObjectCopyWith<$R, IntEqual, $Out> {
  IntEqualCopyWith<$R, IntEqual, $Out> get $asIntEqual =>
      $base.as((v, t, t2) => _IntEqualCopyWithImpl(v, t, t2));
}

abstract class IntEqualCopyWith<$R, $In extends IntEqual, $Out>
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
  IntEqualCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntEqualCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntEqual, $Out>
    implements IntEqualCopyWith<$R, IntEqual, $Out> {
  _IntEqualCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntEqual> $mapper =
      IntEqualMapper.ensureInitialized();
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
  IntEqual $make(CopyWithData data) => IntEqual(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntEqualCopyWith<$R2, IntEqual, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntEqualCopyWithImpl($value, $cast, t);
}
