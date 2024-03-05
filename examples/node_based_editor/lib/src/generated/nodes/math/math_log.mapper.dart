// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_log.dart';

class MathLogMapper extends SubClassMapperBase<MathLog> {
  MathLogMapper._();

  static MathLogMapper? _instance;
  static MathLogMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathLogMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathLog';

  static int _$id(MathLog v) => v.id;
  static const Field<MathLog, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathLog v) => v.inputs;
  static const Field<MathLog, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathLog v) => v.offset;
  static const Field<MathLog, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathLog v) => v.label;
  static const Field<MathLog, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathLog v) => v.expanded;
  static const Field<MathLog, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathLog v) => v.getNode;
  static const Field<MathLog, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathLog> fields = const {
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
  final dynamic discriminatorValue = 'math_log';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathLog _instantiate(DecodingData data) {
    return MathLog(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathLog fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathLog>(map);
  }

  static MathLog fromJson(String json) {
    return ensureInitialized().decodeJson<MathLog>(json);
  }
}

mixin MathLogMappable {
  String toJson() {
    return MathLogMapper.ensureInitialized()
        .encodeJson<MathLog>(this as MathLog);
  }

  Map<String, dynamic> toMap() {
    return MathLogMapper.ensureInitialized()
        .encodeMap<MathLog>(this as MathLog);
  }

  MathLogCopyWith<MathLog, MathLog, MathLog> get copyWith =>
      _MathLogCopyWithImpl(this as MathLog, $identity, $identity);
  @override
  String toString() {
    return MathLogMapper.ensureInitialized().stringifyValue(this as MathLog);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathLogMapper.ensureInitialized()
                .isValueEqual(this as MathLog, other));
  }

  @override
  int get hashCode {
    return MathLogMapper.ensureInitialized().hashValue(this as MathLog);
  }
}

extension MathLogValueCopy<$R, $Out> on ObjectCopyWith<$R, MathLog, $Out> {
  MathLogCopyWith<$R, MathLog, $Out> get $asMathLog =>
      $base.as((v, t, t2) => _MathLogCopyWithImpl(v, t, t2));
}

abstract class MathLogCopyWith<$R, $In extends MathLog, $Out>
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
  MathLogCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathLogCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathLog, $Out>
    implements MathLogCopyWith<$R, MathLog, $Out> {
  _MathLogCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathLog> $mapper =
      MathLogMapper.ensureInitialized();
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
  MathLog $make(CopyWithData data) => MathLog(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathLogCopyWith<$R2, MathLog, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MathLogCopyWithImpl($value, $cast, t);
}
