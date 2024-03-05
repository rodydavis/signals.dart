// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_truncate.dart';

class DoubleTruncateMapper extends SubClassMapperBase<DoubleTruncate> {
  DoubleTruncateMapper._();

  static DoubleTruncateMapper? _instance;
  static DoubleTruncateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleTruncateMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleTruncate';

  static int _$id(DoubleTruncate v) => v.id;
  static const Field<DoubleTruncate, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleTruncate v) => v.inputs;
  static const Field<DoubleTruncate, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleTruncate v) => v.offset;
  static const Field<DoubleTruncate, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleTruncate v) => v.label;
  static const Field<DoubleTruncate, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleTruncate v) => v.expanded;
  static const Field<DoubleTruncate, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleTruncate v) => v.getNode;
  static const Field<DoubleTruncate, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleTruncate> fields = const {
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
  final dynamic discriminatorValue = 'double_truncate';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleTruncate _instantiate(DecodingData data) {
    return DoubleTruncate(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleTruncate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleTruncate>(map);
  }

  static DoubleTruncate fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleTruncate>(json);
  }
}

mixin DoubleTruncateMappable {
  String toJson() {
    return DoubleTruncateMapper.ensureInitialized()
        .encodeJson<DoubleTruncate>(this as DoubleTruncate);
  }

  Map<String, dynamic> toMap() {
    return DoubleTruncateMapper.ensureInitialized()
        .encodeMap<DoubleTruncate>(this as DoubleTruncate);
  }

  DoubleTruncateCopyWith<DoubleTruncate, DoubleTruncate, DoubleTruncate>
      get copyWith => _DoubleTruncateCopyWithImpl(
          this as DoubleTruncate, $identity, $identity);
  @override
  String toString() {
    return DoubleTruncateMapper.ensureInitialized()
        .stringifyValue(this as DoubleTruncate);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleTruncateMapper.ensureInitialized()
                .isValueEqual(this as DoubleTruncate, other));
  }

  @override
  int get hashCode {
    return DoubleTruncateMapper.ensureInitialized()
        .hashValue(this as DoubleTruncate);
  }
}

extension DoubleTruncateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleTruncate, $Out> {
  DoubleTruncateCopyWith<$R, DoubleTruncate, $Out> get $asDoubleTruncate =>
      $base.as((v, t, t2) => _DoubleTruncateCopyWithImpl(v, t, t2));
}

abstract class DoubleTruncateCopyWith<$R, $In extends DoubleTruncate, $Out>
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
  DoubleTruncateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleTruncateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleTruncate, $Out>
    implements DoubleTruncateCopyWith<$R, DoubleTruncate, $Out> {
  _DoubleTruncateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleTruncate> $mapper =
      DoubleTruncateMapper.ensureInitialized();
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
  DoubleTruncate $make(CopyWithData data) => DoubleTruncate(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleTruncateCopyWith<$R2, DoubleTruncate, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleTruncateCopyWithImpl($value, $cast, t);
}
