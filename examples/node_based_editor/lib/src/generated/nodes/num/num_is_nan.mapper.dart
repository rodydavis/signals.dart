// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_is_nan.dart';

class NumIsNanMapper extends SubClassMapperBase<NumIsNan> {
  NumIsNanMapper._();

  static NumIsNanMapper? _instance;
  static NumIsNanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumIsNanMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumIsNan';

  static int _$id(NumIsNan v) => v.id;
  static const Field<NumIsNan, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumIsNan v) => v.inputs;
  static const Field<NumIsNan, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumIsNan v) => v.offset;
  static const Field<NumIsNan, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumIsNan v) => v.label;
  static const Field<NumIsNan, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumIsNan v) => v.expanded;
  static const Field<NumIsNan, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumIsNan v) => v.getNode;
  static const Field<NumIsNan, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumIsNan> fields = const {
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
  final dynamic discriminatorValue = 'num_is_nan';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumIsNan _instantiate(DecodingData data) {
    return NumIsNan(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumIsNan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumIsNan>(map);
  }

  static NumIsNan fromJson(String json) {
    return ensureInitialized().decodeJson<NumIsNan>(json);
  }
}

mixin NumIsNanMappable {
  String toJson() {
    return NumIsNanMapper.ensureInitialized()
        .encodeJson<NumIsNan>(this as NumIsNan);
  }

  Map<String, dynamic> toMap() {
    return NumIsNanMapper.ensureInitialized()
        .encodeMap<NumIsNan>(this as NumIsNan);
  }

  NumIsNanCopyWith<NumIsNan, NumIsNan, NumIsNan> get copyWith =>
      _NumIsNanCopyWithImpl(this as NumIsNan, $identity, $identity);
  @override
  String toString() {
    return NumIsNanMapper.ensureInitialized().stringifyValue(this as NumIsNan);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumIsNanMapper.ensureInitialized()
                .isValueEqual(this as NumIsNan, other));
  }

  @override
  int get hashCode {
    return NumIsNanMapper.ensureInitialized().hashValue(this as NumIsNan);
  }
}

extension NumIsNanValueCopy<$R, $Out> on ObjectCopyWith<$R, NumIsNan, $Out> {
  NumIsNanCopyWith<$R, NumIsNan, $Out> get $asNumIsNan =>
      $base.as((v, t, t2) => _NumIsNanCopyWithImpl(v, t, t2));
}

abstract class NumIsNanCopyWith<$R, $In extends NumIsNan, $Out>
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
  NumIsNanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumIsNanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumIsNan, $Out>
    implements NumIsNanCopyWith<$R, NumIsNan, $Out> {
  _NumIsNanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumIsNan> $mapper =
      NumIsNanMapper.ensureInitialized();
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
  NumIsNan $make(CopyWithData data) => NumIsNan(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumIsNanCopyWith<$R2, NumIsNan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumIsNanCopyWithImpl($value, $cast, t);
}
