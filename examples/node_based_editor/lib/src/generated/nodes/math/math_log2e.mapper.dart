// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_log2e.dart';

class MathLog2eMapper extends SubClassMapperBase<MathLog2e> {
  MathLog2eMapper._();

  static MathLog2eMapper? _instance;
  static MathLog2eMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathLog2eMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathLog2e';

  static int _$id(MathLog2e v) => v.id;
  static const Field<MathLog2e, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathLog2e v) => v.inputs;
  static const Field<MathLog2e, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathLog2e v) => v.offset;
  static const Field<MathLog2e, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathLog2e v) => v.label;
  static const Field<MathLog2e, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathLog2e v) => v.expanded;
  static const Field<MathLog2e, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathLog2e v) => v.getNode;
  static const Field<MathLog2e, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathLog2e> fields = const {
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
  final dynamic discriminatorValue = 'math_log2e';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathLog2e _instantiate(DecodingData data) {
    return MathLog2e(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathLog2e fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathLog2e>(map);
  }

  static MathLog2e fromJson(String json) {
    return ensureInitialized().decodeJson<MathLog2e>(json);
  }
}

mixin MathLog2eMappable {
  String toJson() {
    return MathLog2eMapper.ensureInitialized()
        .encodeJson<MathLog2e>(this as MathLog2e);
  }

  Map<String, dynamic> toMap() {
    return MathLog2eMapper.ensureInitialized()
        .encodeMap<MathLog2e>(this as MathLog2e);
  }

  MathLog2eCopyWith<MathLog2e, MathLog2e, MathLog2e> get copyWith =>
      _MathLog2eCopyWithImpl(this as MathLog2e, $identity, $identity);
  @override
  String toString() {
    return MathLog2eMapper.ensureInitialized()
        .stringifyValue(this as MathLog2e);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathLog2eMapper.ensureInitialized()
                .isValueEqual(this as MathLog2e, other));
  }

  @override
  int get hashCode {
    return MathLog2eMapper.ensureInitialized().hashValue(this as MathLog2e);
  }
}

extension MathLog2eValueCopy<$R, $Out> on ObjectCopyWith<$R, MathLog2e, $Out> {
  MathLog2eCopyWith<$R, MathLog2e, $Out> get $asMathLog2e =>
      $base.as((v, t, t2) => _MathLog2eCopyWithImpl(v, t, t2));
}

abstract class MathLog2eCopyWith<$R, $In extends MathLog2e, $Out>
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
  MathLog2eCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathLog2eCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathLog2e, $Out>
    implements MathLog2eCopyWith<$R, MathLog2e, $Out> {
  _MathLog2eCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathLog2e> $mapper =
      MathLog2eMapper.ensureInitialized();
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
  MathLog2e $make(CopyWithData data) => MathLog2e(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathLog2eCopyWith<$R2, MathLog2e, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MathLog2eCopyWithImpl($value, $cast, t);
}
