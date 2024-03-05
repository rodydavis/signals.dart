// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_nan.dart';

class DoubleNanMapper extends SubClassMapperBase<DoubleNan> {
  DoubleNanMapper._();

  static DoubleNanMapper? _instance;
  static DoubleNanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleNanMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleNan';

  static int _$id(DoubleNan v) => v.id;
  static const Field<DoubleNan, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleNan v) => v.inputs;
  static const Field<DoubleNan, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleNan v) => v.offset;
  static const Field<DoubleNan, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleNan v) => v.label;
  static const Field<DoubleNan, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleNan v) => v.expanded;
  static const Field<DoubleNan, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleNan v) => v.getNode;
  static const Field<DoubleNan, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleNan> fields = const {
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
  final dynamic discriminatorValue = 'double_nan';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleNan _instantiate(DecodingData data) {
    return DoubleNan(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleNan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleNan>(map);
  }

  static DoubleNan fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleNan>(json);
  }
}

mixin DoubleNanMappable {
  String toJson() {
    return DoubleNanMapper.ensureInitialized()
        .encodeJson<DoubleNan>(this as DoubleNan);
  }

  Map<String, dynamic> toMap() {
    return DoubleNanMapper.ensureInitialized()
        .encodeMap<DoubleNan>(this as DoubleNan);
  }

  DoubleNanCopyWith<DoubleNan, DoubleNan, DoubleNan> get copyWith =>
      _DoubleNanCopyWithImpl(this as DoubleNan, $identity, $identity);
  @override
  String toString() {
    return DoubleNanMapper.ensureInitialized()
        .stringifyValue(this as DoubleNan);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleNanMapper.ensureInitialized()
                .isValueEqual(this as DoubleNan, other));
  }

  @override
  int get hashCode {
    return DoubleNanMapper.ensureInitialized().hashValue(this as DoubleNan);
  }
}

extension DoubleNanValueCopy<$R, $Out> on ObjectCopyWith<$R, DoubleNan, $Out> {
  DoubleNanCopyWith<$R, DoubleNan, $Out> get $asDoubleNan =>
      $base.as((v, t, t2) => _DoubleNanCopyWithImpl(v, t, t2));
}

abstract class DoubleNanCopyWith<$R, $In extends DoubleNan, $Out>
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
  DoubleNanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleNanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleNan, $Out>
    implements DoubleNanCopyWith<$R, DoubleNan, $Out> {
  _DoubleNanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleNan> $mapper =
      DoubleNanMapper.ensureInitialized();
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
  DoubleNan $make(CopyWithData data) => DoubleNan(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleNanCopyWith<$R2, DoubleNan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleNanCopyWithImpl($value, $cast, t);
}
