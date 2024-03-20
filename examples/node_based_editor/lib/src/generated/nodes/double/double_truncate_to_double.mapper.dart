// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_truncate_to_double.dart';

class DoubleTruncateToDoubleMapper
    extends SubClassMapperBase<DoubleTruncateToDouble> {
  DoubleTruncateToDoubleMapper._();

  static DoubleTruncateToDoubleMapper? _instance;
  static DoubleTruncateToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleTruncateToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleTruncateToDouble';

  static int _$id(DoubleTruncateToDouble v) => v.id;
  static const Field<DoubleTruncateToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleTruncateToDouble v) =>
      v.inputs;
  static const Field<DoubleTruncateToDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleTruncateToDouble v) => v.offset;
  static const Field<DoubleTruncateToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleTruncateToDouble v) => v.label;
  static const Field<DoubleTruncateToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleTruncateToDouble v) => v.expanded;
  static const Field<DoubleTruncateToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleTruncateToDouble v) =>
      v.getNode;
  static const Field<DoubleTruncateToDouble, BaseNode Function(int)>
      _f$getNode = Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleTruncateToDouble> fields = const {
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
  final dynamic discriminatorValue = 'double_truncate_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleTruncateToDouble _instantiate(DecodingData data) {
    return DoubleTruncateToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleTruncateToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleTruncateToDouble>(map);
  }

  static DoubleTruncateToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleTruncateToDouble>(json);
  }
}

mixin DoubleTruncateToDoubleMappable {
  String toJson() {
    return DoubleTruncateToDoubleMapper.ensureInitialized()
        .encodeJson<DoubleTruncateToDouble>(this as DoubleTruncateToDouble);
  }

  Map<String, dynamic> toMap() {
    return DoubleTruncateToDoubleMapper.ensureInitialized()
        .encodeMap<DoubleTruncateToDouble>(this as DoubleTruncateToDouble);
  }

  DoubleTruncateToDoubleCopyWith<DoubleTruncateToDouble, DoubleTruncateToDouble,
          DoubleTruncateToDouble>
      get copyWith => _DoubleTruncateToDoubleCopyWithImpl(
          this as DoubleTruncateToDouble, $identity, $identity);
  @override
  String toString() {
    return DoubleTruncateToDoubleMapper.ensureInitialized()
        .stringifyValue(this as DoubleTruncateToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleTruncateToDoubleMapper.ensureInitialized()
                .isValueEqual(this as DoubleTruncateToDouble, other));
  }

  @override
  int get hashCode {
    return DoubleTruncateToDoubleMapper.ensureInitialized()
        .hashValue(this as DoubleTruncateToDouble);
  }
}

extension DoubleTruncateToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleTruncateToDouble, $Out> {
  DoubleTruncateToDoubleCopyWith<$R, DoubleTruncateToDouble, $Out>
      get $asDoubleTruncateToDouble =>
          $base.as((v, t, t2) => _DoubleTruncateToDoubleCopyWithImpl(v, t, t2));
}

abstract class DoubleTruncateToDoubleCopyWith<
    $R,
    $In extends DoubleTruncateToDouble,
    $Out> implements BaseNodeCopyWith<$R, $In, $Out> {
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
  DoubleTruncateToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleTruncateToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleTruncateToDouble, $Out>
    implements
        DoubleTruncateToDoubleCopyWith<$R, DoubleTruncateToDouble, $Out> {
  _DoubleTruncateToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleTruncateToDouble> $mapper =
      DoubleTruncateToDoubleMapper.ensureInitialized();
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
  DoubleTruncateToDouble $make(CopyWithData data) => DoubleTruncateToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleTruncateToDoubleCopyWith<$R2, DoubleTruncateToDouble, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DoubleTruncateToDoubleCopyWithImpl($value, $cast, t);
}
