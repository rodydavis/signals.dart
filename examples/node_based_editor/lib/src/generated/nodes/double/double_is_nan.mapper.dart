// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_is_nan.dart';

class DoubleIsNanMapper extends SubClassMapperBase<DoubleIsNan> {
  DoubleIsNanMapper._();

  static DoubleIsNanMapper? _instance;
  static DoubleIsNanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleIsNanMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleIsNan';

  static int _$id(DoubleIsNan v) => v.id;
  static const Field<DoubleIsNan, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleIsNan v) => v.inputs;
  static const Field<DoubleIsNan, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleIsNan v) => v.offset;
  static const Field<DoubleIsNan, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleIsNan v) => v.label;
  static const Field<DoubleIsNan, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleIsNan v) => v.expanded;
  static const Field<DoubleIsNan, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleIsNan v) => v.getNode;
  static const Field<DoubleIsNan, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleIsNan> fields = const {
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
  final dynamic discriminatorValue = 'double_is_nan';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleIsNan _instantiate(DecodingData data) {
    return DoubleIsNan(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleIsNan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleIsNan>(map);
  }

  static DoubleIsNan fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleIsNan>(json);
  }
}

mixin DoubleIsNanMappable {
  String toJson() {
    return DoubleIsNanMapper.ensureInitialized()
        .encodeJson<DoubleIsNan>(this as DoubleIsNan);
  }

  Map<String, dynamic> toMap() {
    return DoubleIsNanMapper.ensureInitialized()
        .encodeMap<DoubleIsNan>(this as DoubleIsNan);
  }

  DoubleIsNanCopyWith<DoubleIsNan, DoubleIsNan, DoubleIsNan> get copyWith =>
      _DoubleIsNanCopyWithImpl(this as DoubleIsNan, $identity, $identity);
  @override
  String toString() {
    return DoubleIsNanMapper.ensureInitialized()
        .stringifyValue(this as DoubleIsNan);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleIsNanMapper.ensureInitialized()
                .isValueEqual(this as DoubleIsNan, other));
  }

  @override
  int get hashCode {
    return DoubleIsNanMapper.ensureInitialized().hashValue(this as DoubleIsNan);
  }
}

extension DoubleIsNanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleIsNan, $Out> {
  DoubleIsNanCopyWith<$R, DoubleIsNan, $Out> get $asDoubleIsNan =>
      $base.as((v, t, t2) => _DoubleIsNanCopyWithImpl(v, t, t2));
}

abstract class DoubleIsNanCopyWith<$R, $In extends DoubleIsNan, $Out>
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
  DoubleIsNanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleIsNanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleIsNan, $Out>
    implements DoubleIsNanCopyWith<$R, DoubleIsNan, $Out> {
  _DoubleIsNanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleIsNan> $mapper =
      DoubleIsNanMapper.ensureInitialized();
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
  DoubleIsNan $make(CopyWithData data) => DoubleIsNan(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleIsNanCopyWith<$R2, DoubleIsNan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleIsNanCopyWithImpl($value, $cast, t);
}
