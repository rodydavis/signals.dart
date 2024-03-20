// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_divide.dart';

class DoubleDivideMapper extends SubClassMapperBase<DoubleDivide> {
  DoubleDivideMapper._();

  static DoubleDivideMapper? _instance;
  static DoubleDivideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleDivideMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleDivide';

  static int _$id(DoubleDivide v) => v.id;
  static const Field<DoubleDivide, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleDivide v) => v.inputs;
  static const Field<DoubleDivide, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleDivide v) => v.offset;
  static const Field<DoubleDivide, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleDivide v) => v.label;
  static const Field<DoubleDivide, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleDivide v) => v.expanded;
  static const Field<DoubleDivide, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleDivide v) => v.getNode;
  static const Field<DoubleDivide, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleDivide> fields = const {
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
  final dynamic discriminatorValue = 'double_divide';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleDivide _instantiate(DecodingData data) {
    return DoubleDivide(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleDivide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleDivide>(map);
  }

  static DoubleDivide fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleDivide>(json);
  }
}

mixin DoubleDivideMappable {
  String toJson() {
    return DoubleDivideMapper.ensureInitialized()
        .encodeJson<DoubleDivide>(this as DoubleDivide);
  }

  Map<String, dynamic> toMap() {
    return DoubleDivideMapper.ensureInitialized()
        .encodeMap<DoubleDivide>(this as DoubleDivide);
  }

  DoubleDivideCopyWith<DoubleDivide, DoubleDivide, DoubleDivide> get copyWith =>
      _DoubleDivideCopyWithImpl(this as DoubleDivide, $identity, $identity);
  @override
  String toString() {
    return DoubleDivideMapper.ensureInitialized()
        .stringifyValue(this as DoubleDivide);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleDivideMapper.ensureInitialized()
                .isValueEqual(this as DoubleDivide, other));
  }

  @override
  int get hashCode {
    return DoubleDivideMapper.ensureInitialized()
        .hashValue(this as DoubleDivide);
  }
}

extension DoubleDivideValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleDivide, $Out> {
  DoubleDivideCopyWith<$R, DoubleDivide, $Out> get $asDoubleDivide =>
      $base.as((v, t, t2) => _DoubleDivideCopyWithImpl(v, t, t2));
}

abstract class DoubleDivideCopyWith<$R, $In extends DoubleDivide, $Out>
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
  DoubleDivideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleDivideCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleDivide, $Out>
    implements DoubleDivideCopyWith<$R, DoubleDivide, $Out> {
  _DoubleDivideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleDivide> $mapper =
      DoubleDivideMapper.ensureInitialized();
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
  DoubleDivide $make(CopyWithData data) => DoubleDivide(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleDivideCopyWith<$R2, DoubleDivide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleDivideCopyWithImpl($value, $cast, t);
}
