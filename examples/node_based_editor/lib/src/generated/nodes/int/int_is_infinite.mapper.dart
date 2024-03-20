// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_is_infinite.dart';

class IntIsInfiniteMapper extends SubClassMapperBase<IntIsInfinite> {
  IntIsInfiniteMapper._();

  static IntIsInfiniteMapper? _instance;
  static IntIsInfiniteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntIsInfiniteMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntIsInfinite';

  static int _$id(IntIsInfinite v) => v.id;
  static const Field<IntIsInfinite, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntIsInfinite v) => v.inputs;
  static const Field<IntIsInfinite, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntIsInfinite v) => v.offset;
  static const Field<IntIsInfinite, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntIsInfinite v) => v.label;
  static const Field<IntIsInfinite, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntIsInfinite v) => v.expanded;
  static const Field<IntIsInfinite, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntIsInfinite v) => v.getNode;
  static const Field<IntIsInfinite, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntIsInfinite> fields = const {
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
  final dynamic discriminatorValue = 'int_is_infinite';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntIsInfinite _instantiate(DecodingData data) {
    return IntIsInfinite(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntIsInfinite fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntIsInfinite>(map);
  }

  static IntIsInfinite fromJson(String json) {
    return ensureInitialized().decodeJson<IntIsInfinite>(json);
  }
}

mixin IntIsInfiniteMappable {
  String toJson() {
    return IntIsInfiniteMapper.ensureInitialized()
        .encodeJson<IntIsInfinite>(this as IntIsInfinite);
  }

  Map<String, dynamic> toMap() {
    return IntIsInfiniteMapper.ensureInitialized()
        .encodeMap<IntIsInfinite>(this as IntIsInfinite);
  }

  IntIsInfiniteCopyWith<IntIsInfinite, IntIsInfinite, IntIsInfinite>
      get copyWith => _IntIsInfiniteCopyWithImpl(
          this as IntIsInfinite, $identity, $identity);
  @override
  String toString() {
    return IntIsInfiniteMapper.ensureInitialized()
        .stringifyValue(this as IntIsInfinite);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntIsInfiniteMapper.ensureInitialized()
                .isValueEqual(this as IntIsInfinite, other));
  }

  @override
  int get hashCode {
    return IntIsInfiniteMapper.ensureInitialized()
        .hashValue(this as IntIsInfinite);
  }
}

extension IntIsInfiniteValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntIsInfinite, $Out> {
  IntIsInfiniteCopyWith<$R, IntIsInfinite, $Out> get $asIntIsInfinite =>
      $base.as((v, t, t2) => _IntIsInfiniteCopyWithImpl(v, t, t2));
}

abstract class IntIsInfiniteCopyWith<$R, $In extends IntIsInfinite, $Out>
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
  IntIsInfiniteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntIsInfiniteCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntIsInfinite, $Out>
    implements IntIsInfiniteCopyWith<$R, IntIsInfinite, $Out> {
  _IntIsInfiniteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntIsInfinite> $mapper =
      IntIsInfiniteMapper.ensureInitialized();
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
  IntIsInfinite $make(CopyWithData data) => IntIsInfinite(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntIsInfiniteCopyWith<$R2, IntIsInfinite, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntIsInfiniteCopyWithImpl($value, $cast, t);
}
