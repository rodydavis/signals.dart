// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_truncate.dart';

class IntTruncateMapper extends SubClassMapperBase<IntTruncate> {
  IntTruncateMapper._();

  static IntTruncateMapper? _instance;
  static IntTruncateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntTruncateMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntTruncate';

  static int _$id(IntTruncate v) => v.id;
  static const Field<IntTruncate, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntTruncate v) => v.inputs;
  static const Field<IntTruncate, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntTruncate v) => v.offset;
  static const Field<IntTruncate, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntTruncate v) => v.label;
  static const Field<IntTruncate, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntTruncate v) => v.expanded;
  static const Field<IntTruncate, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntTruncate v) => v.getNode;
  static const Field<IntTruncate, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntTruncate> fields = const {
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
  final dynamic discriminatorValue = 'int_truncate';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntTruncate _instantiate(DecodingData data) {
    return IntTruncate(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntTruncate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntTruncate>(map);
  }

  static IntTruncate fromJson(String json) {
    return ensureInitialized().decodeJson<IntTruncate>(json);
  }
}

mixin IntTruncateMappable {
  String toJson() {
    return IntTruncateMapper.ensureInitialized()
        .encodeJson<IntTruncate>(this as IntTruncate);
  }

  Map<String, dynamic> toMap() {
    return IntTruncateMapper.ensureInitialized()
        .encodeMap<IntTruncate>(this as IntTruncate);
  }

  IntTruncateCopyWith<IntTruncate, IntTruncate, IntTruncate> get copyWith =>
      _IntTruncateCopyWithImpl(this as IntTruncate, $identity, $identity);
  @override
  String toString() {
    return IntTruncateMapper.ensureInitialized()
        .stringifyValue(this as IntTruncate);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntTruncateMapper.ensureInitialized()
                .isValueEqual(this as IntTruncate, other));
  }

  @override
  int get hashCode {
    return IntTruncateMapper.ensureInitialized().hashValue(this as IntTruncate);
  }
}

extension IntTruncateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntTruncate, $Out> {
  IntTruncateCopyWith<$R, IntTruncate, $Out> get $asIntTruncate =>
      $base.as((v, t, t2) => _IntTruncateCopyWithImpl(v, t, t2));
}

abstract class IntTruncateCopyWith<$R, $In extends IntTruncate, $Out>
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
  IntTruncateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntTruncateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntTruncate, $Out>
    implements IntTruncateCopyWith<$R, IntTruncate, $Out> {
  _IntTruncateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntTruncate> $mapper =
      IntTruncateMapper.ensureInitialized();
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
  IntTruncate $make(CopyWithData data) => IntTruncate(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntTruncateCopyWith<$R2, IntTruncate, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntTruncateCopyWithImpl($value, $cast, t);
}
