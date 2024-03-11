// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_tan.dart';

class MathTanMapper extends SubClassMapperBase<MathTan> {
  MathTanMapper._();

  static MathTanMapper? _instance;
  static MathTanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathTanMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathTan';

  static int _$id(MathTan v) => v.id;
  static const Field<MathTan, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathTan v) => v.inputs;
  static const Field<MathTan, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathTan v) => v.offset;
  static const Field<MathTan, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathTan v) => v.label;
  static const Field<MathTan, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathTan v) => v.expanded;
  static const Field<MathTan, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathTan v) => v.getNode;
  static const Field<MathTan, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathTan> fields = const {
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
  final dynamic discriminatorValue = 'math_tan';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathTan _instantiate(DecodingData data) {
    return MathTan(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathTan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathTan>(map);
  }

  static MathTan fromJson(String json) {
    return ensureInitialized().decodeJson<MathTan>(json);
  }
}

mixin MathTanMappable {
  String toJson() {
    return MathTanMapper.ensureInitialized()
        .encodeJson<MathTan>(this as MathTan);
  }

  Map<String, dynamic> toMap() {
    return MathTanMapper.ensureInitialized()
        .encodeMap<MathTan>(this as MathTan);
  }

  MathTanCopyWith<MathTan, MathTan, MathTan> get copyWith =>
      _MathTanCopyWithImpl(this as MathTan, $identity, $identity);
  @override
  String toString() {
    return MathTanMapper.ensureInitialized().stringifyValue(this as MathTan);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathTanMapper.ensureInitialized()
                .isValueEqual(this as MathTan, other));
  }

  @override
  int get hashCode {
    return MathTanMapper.ensureInitialized().hashValue(this as MathTan);
  }
}

extension MathTanValueCopy<$R, $Out> on ObjectCopyWith<$R, MathTan, $Out> {
  MathTanCopyWith<$R, MathTan, $Out> get $asMathTan =>
      $base.as((v, t, t2) => _MathTanCopyWithImpl(v, t, t2));
}

abstract class MathTanCopyWith<$R, $In extends MathTan, $Out>
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
  MathTanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathTanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathTan, $Out>
    implements MathTanCopyWith<$R, MathTan, $Out> {
  _MathTanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathTan> $mapper =
      MathTanMapper.ensureInitialized();
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
  MathTan $make(CopyWithData data) => MathTan(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathTanCopyWith<$R2, MathTan, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MathTanCopyWithImpl($value, $cast, t);
}
