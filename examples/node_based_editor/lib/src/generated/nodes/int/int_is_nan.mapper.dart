// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_is_nan.dart';

class IntIsNanMapper extends SubClassMapperBase<IntIsNan> {
  IntIsNanMapper._();

  static IntIsNanMapper? _instance;
  static IntIsNanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntIsNanMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntIsNan';

  static int _$id(IntIsNan v) => v.id;
  static const Field<IntIsNan, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntIsNan v) => v.inputs;
  static const Field<IntIsNan, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntIsNan v) => v.offset;
  static const Field<IntIsNan, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntIsNan v) => v.label;
  static const Field<IntIsNan, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntIsNan v) => v.expanded;
  static const Field<IntIsNan, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntIsNan v) => v.getNode;
  static const Field<IntIsNan, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntIsNan> fields = const {
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
  final dynamic discriminatorValue = 'int_is_nan';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntIsNan _instantiate(DecodingData data) {
    return IntIsNan(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntIsNan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntIsNan>(map);
  }

  static IntIsNan fromJson(String json) {
    return ensureInitialized().decodeJson<IntIsNan>(json);
  }
}

mixin IntIsNanMappable {
  String toJson() {
    return IntIsNanMapper.ensureInitialized()
        .encodeJson<IntIsNan>(this as IntIsNan);
  }

  Map<String, dynamic> toMap() {
    return IntIsNanMapper.ensureInitialized()
        .encodeMap<IntIsNan>(this as IntIsNan);
  }

  IntIsNanCopyWith<IntIsNan, IntIsNan, IntIsNan> get copyWith =>
      _IntIsNanCopyWithImpl(this as IntIsNan, $identity, $identity);
  @override
  String toString() {
    return IntIsNanMapper.ensureInitialized().stringifyValue(this as IntIsNan);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntIsNanMapper.ensureInitialized()
                .isValueEqual(this as IntIsNan, other));
  }

  @override
  int get hashCode {
    return IntIsNanMapper.ensureInitialized().hashValue(this as IntIsNan);
  }
}

extension IntIsNanValueCopy<$R, $Out> on ObjectCopyWith<$R, IntIsNan, $Out> {
  IntIsNanCopyWith<$R, IntIsNan, $Out> get $asIntIsNan =>
      $base.as((v, t, t2) => _IntIsNanCopyWithImpl(v, t, t2));
}

abstract class IntIsNanCopyWith<$R, $In extends IntIsNan, $Out>
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
  IntIsNanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntIsNanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntIsNan, $Out>
    implements IntIsNanCopyWith<$R, IntIsNan, $Out> {
  _IntIsNanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntIsNan> $mapper =
      IntIsNanMapper.ensureInitialized();
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
  IntIsNan $make(CopyWithData data) => IntIsNan(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntIsNanCopyWith<$R2, IntIsNan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntIsNanCopyWithImpl($value, $cast, t);
}
