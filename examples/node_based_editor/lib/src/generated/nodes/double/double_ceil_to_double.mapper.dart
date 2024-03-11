// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_ceil_to_double.dart';

class DoubleCeilToDoubleMapper extends SubClassMapperBase<DoubleCeilToDouble> {
  DoubleCeilToDoubleMapper._();

  static DoubleCeilToDoubleMapper? _instance;
  static DoubleCeilToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleCeilToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleCeilToDouble';

  static int _$id(DoubleCeilToDouble v) => v.id;
  static const Field<DoubleCeilToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleCeilToDouble v) =>
      v.inputs;
  static const Field<DoubleCeilToDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleCeilToDouble v) => v.offset;
  static const Field<DoubleCeilToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleCeilToDouble v) => v.label;
  static const Field<DoubleCeilToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleCeilToDouble v) => v.expanded;
  static const Field<DoubleCeilToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleCeilToDouble v) => v.getNode;
  static const Field<DoubleCeilToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleCeilToDouble> fields = const {
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
  final dynamic discriminatorValue = 'double_ceil_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleCeilToDouble _instantiate(DecodingData data) {
    return DoubleCeilToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleCeilToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleCeilToDouble>(map);
  }

  static DoubleCeilToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleCeilToDouble>(json);
  }
}

mixin DoubleCeilToDoubleMappable {
  String toJson() {
    return DoubleCeilToDoubleMapper.ensureInitialized()
        .encodeJson<DoubleCeilToDouble>(this as DoubleCeilToDouble);
  }

  Map<String, dynamic> toMap() {
    return DoubleCeilToDoubleMapper.ensureInitialized()
        .encodeMap<DoubleCeilToDouble>(this as DoubleCeilToDouble);
  }

  DoubleCeilToDoubleCopyWith<DoubleCeilToDouble, DoubleCeilToDouble,
          DoubleCeilToDouble>
      get copyWith => _DoubleCeilToDoubleCopyWithImpl(
          this as DoubleCeilToDouble, $identity, $identity);
  @override
  String toString() {
    return DoubleCeilToDoubleMapper.ensureInitialized()
        .stringifyValue(this as DoubleCeilToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleCeilToDoubleMapper.ensureInitialized()
                .isValueEqual(this as DoubleCeilToDouble, other));
  }

  @override
  int get hashCode {
    return DoubleCeilToDoubleMapper.ensureInitialized()
        .hashValue(this as DoubleCeilToDouble);
  }
}

extension DoubleCeilToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleCeilToDouble, $Out> {
  DoubleCeilToDoubleCopyWith<$R, DoubleCeilToDouble, $Out>
      get $asDoubleCeilToDouble =>
          $base.as((v, t, t2) => _DoubleCeilToDoubleCopyWithImpl(v, t, t2));
}

abstract class DoubleCeilToDoubleCopyWith<$R, $In extends DoubleCeilToDouble,
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
  DoubleCeilToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleCeilToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleCeilToDouble, $Out>
    implements DoubleCeilToDoubleCopyWith<$R, DoubleCeilToDouble, $Out> {
  _DoubleCeilToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleCeilToDouble> $mapper =
      DoubleCeilToDoubleMapper.ensureInitialized();
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
  DoubleCeilToDouble $make(CopyWithData data) => DoubleCeilToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleCeilToDoubleCopyWith<$R2, DoubleCeilToDouble, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleCeilToDoubleCopyWithImpl($value, $cast, t);
}
