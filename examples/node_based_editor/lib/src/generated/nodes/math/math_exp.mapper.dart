// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_exp.dart';

class MathExpMapper extends SubClassMapperBase<MathExp> {
  MathExpMapper._();

  static MathExpMapper? _instance;
  static MathExpMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathExpMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathExp';

  static int _$id(MathExp v) => v.id;
  static const Field<MathExp, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathExp v) => v.inputs;
  static const Field<MathExp, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathExp v) => v.offset;
  static const Field<MathExp, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathExp v) => v.label;
  static const Field<MathExp, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathExp v) => v.expanded;
  static const Field<MathExp, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathExp v) => v.getNode;
  static const Field<MathExp, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathExp> fields = const {
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
  final dynamic discriminatorValue = 'math_exp';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathExp _instantiate(DecodingData data) {
    return MathExp(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathExp fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathExp>(map);
  }

  static MathExp fromJson(String json) {
    return ensureInitialized().decodeJson<MathExp>(json);
  }
}

mixin MathExpMappable {
  String toJson() {
    return MathExpMapper.ensureInitialized()
        .encodeJson<MathExp>(this as MathExp);
  }

  Map<String, dynamic> toMap() {
    return MathExpMapper.ensureInitialized()
        .encodeMap<MathExp>(this as MathExp);
  }

  MathExpCopyWith<MathExp, MathExp, MathExp> get copyWith =>
      _MathExpCopyWithImpl(this as MathExp, $identity, $identity);
  @override
  String toString() {
    return MathExpMapper.ensureInitialized().stringifyValue(this as MathExp);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathExpMapper.ensureInitialized()
                .isValueEqual(this as MathExp, other));
  }

  @override
  int get hashCode {
    return MathExpMapper.ensureInitialized().hashValue(this as MathExp);
  }
}

extension MathExpValueCopy<$R, $Out> on ObjectCopyWith<$R, MathExp, $Out> {
  MathExpCopyWith<$R, MathExp, $Out> get $asMathExp =>
      $base.as((v, t, t2) => _MathExpCopyWithImpl(v, t, t2));
}

abstract class MathExpCopyWith<$R, $In extends MathExp, $Out>
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
  MathExpCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathExpCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathExp, $Out>
    implements MathExpCopyWith<$R, MathExp, $Out> {
  _MathExpCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathExp> $mapper =
      MathExpMapper.ensureInitialized();
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
  MathExp $make(CopyWithData data) => MathExp(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathExpCopyWith<$R2, MathExp, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MathExpCopyWithImpl($value, $cast, t);
}
