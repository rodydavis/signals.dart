// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_is_finite.dart';

class IntIsFiniteMapper extends SubClassMapperBase<IntIsFinite> {
  IntIsFiniteMapper._();

  static IntIsFiniteMapper? _instance;
  static IntIsFiniteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntIsFiniteMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntIsFinite';

  static int _$id(IntIsFinite v) => v.id;
  static const Field<IntIsFinite, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntIsFinite v) => v.inputs;
  static const Field<IntIsFinite, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntIsFinite v) => v.offset;
  static const Field<IntIsFinite, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntIsFinite v) => v.label;
  static const Field<IntIsFinite, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntIsFinite v) => v.expanded;
  static const Field<IntIsFinite, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntIsFinite v) => v.getNode;
  static const Field<IntIsFinite, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntIsFinite> fields = const {
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
  final dynamic discriminatorValue = 'int_is_finite';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntIsFinite _instantiate(DecodingData data) {
    return IntIsFinite(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntIsFinite fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntIsFinite>(map);
  }

  static IntIsFinite fromJson(String json) {
    return ensureInitialized().decodeJson<IntIsFinite>(json);
  }
}

mixin IntIsFiniteMappable {
  String toJson() {
    return IntIsFiniteMapper.ensureInitialized()
        .encodeJson<IntIsFinite>(this as IntIsFinite);
  }

  Map<String, dynamic> toMap() {
    return IntIsFiniteMapper.ensureInitialized()
        .encodeMap<IntIsFinite>(this as IntIsFinite);
  }

  IntIsFiniteCopyWith<IntIsFinite, IntIsFinite, IntIsFinite> get copyWith =>
      _IntIsFiniteCopyWithImpl(this as IntIsFinite, $identity, $identity);
  @override
  String toString() {
    return IntIsFiniteMapper.ensureInitialized()
        .stringifyValue(this as IntIsFinite);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntIsFiniteMapper.ensureInitialized()
                .isValueEqual(this as IntIsFinite, other));
  }

  @override
  int get hashCode {
    return IntIsFiniteMapper.ensureInitialized().hashValue(this as IntIsFinite);
  }
}

extension IntIsFiniteValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntIsFinite, $Out> {
  IntIsFiniteCopyWith<$R, IntIsFinite, $Out> get $asIntIsFinite =>
      $base.as((v, t, t2) => _IntIsFiniteCopyWithImpl(v, t, t2));
}

abstract class IntIsFiniteCopyWith<$R, $In extends IntIsFinite, $Out>
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
  IntIsFiniteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntIsFiniteCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntIsFinite, $Out>
    implements IntIsFiniteCopyWith<$R, IntIsFinite, $Out> {
  _IntIsFiniteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntIsFinite> $mapper =
      IntIsFiniteMapper.ensureInitialized();
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
  IntIsFinite $make(CopyWithData data) => IntIsFinite(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntIsFiniteCopyWith<$R2, IntIsFinite, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntIsFiniteCopyWithImpl($value, $cast, t);
}
