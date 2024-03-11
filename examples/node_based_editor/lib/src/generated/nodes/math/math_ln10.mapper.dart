// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_ln10.dart';

class MathLn10Mapper extends SubClassMapperBase<MathLn10> {
  MathLn10Mapper._();

  static MathLn10Mapper? _instance;
  static MathLn10Mapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathLn10Mapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathLn10';

  static int _$id(MathLn10 v) => v.id;
  static const Field<MathLn10, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathLn10 v) => v.inputs;
  static const Field<MathLn10, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathLn10 v) => v.offset;
  static const Field<MathLn10, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathLn10 v) => v.label;
  static const Field<MathLn10, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathLn10 v) => v.expanded;
  static const Field<MathLn10, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathLn10 v) => v.getNode;
  static const Field<MathLn10, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathLn10> fields = const {
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
  final dynamic discriminatorValue = 'math_ln10';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathLn10 _instantiate(DecodingData data) {
    return MathLn10(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathLn10 fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathLn10>(map);
  }

  static MathLn10 fromJson(String json) {
    return ensureInitialized().decodeJson<MathLn10>(json);
  }
}

mixin MathLn10Mappable {
  String toJson() {
    return MathLn10Mapper.ensureInitialized()
        .encodeJson<MathLn10>(this as MathLn10);
  }

  Map<String, dynamic> toMap() {
    return MathLn10Mapper.ensureInitialized()
        .encodeMap<MathLn10>(this as MathLn10);
  }

  MathLn10CopyWith<MathLn10, MathLn10, MathLn10> get copyWith =>
      _MathLn10CopyWithImpl(this as MathLn10, $identity, $identity);
  @override
  String toString() {
    return MathLn10Mapper.ensureInitialized().stringifyValue(this as MathLn10);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathLn10Mapper.ensureInitialized()
                .isValueEqual(this as MathLn10, other));
  }

  @override
  int get hashCode {
    return MathLn10Mapper.ensureInitialized().hashValue(this as MathLn10);
  }
}

extension MathLn10ValueCopy<$R, $Out> on ObjectCopyWith<$R, MathLn10, $Out> {
  MathLn10CopyWith<$R, MathLn10, $Out> get $asMathLn10 =>
      $base.as((v, t, t2) => _MathLn10CopyWithImpl(v, t, t2));
}

abstract class MathLn10CopyWith<$R, $In extends MathLn10, $Out>
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
  MathLn10CopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathLn10CopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathLn10, $Out>
    implements MathLn10CopyWith<$R, MathLn10, $Out> {
  _MathLn10CopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathLn10> $mapper =
      MathLn10Mapper.ensureInitialized();
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
  MathLn10 $make(CopyWithData data) => MathLn10(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathLn10CopyWith<$R2, MathLn10, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MathLn10CopyWithImpl($value, $cast, t);
}
