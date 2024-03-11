// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_log10e.dart';

class MathLog10eMapper extends SubClassMapperBase<MathLog10e> {
  MathLog10eMapper._();

  static MathLog10eMapper? _instance;
  static MathLog10eMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathLog10eMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathLog10e';

  static int _$id(MathLog10e v) => v.id;
  static const Field<MathLog10e, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathLog10e v) => v.inputs;
  static const Field<MathLog10e, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathLog10e v) => v.offset;
  static const Field<MathLog10e, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathLog10e v) => v.label;
  static const Field<MathLog10e, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathLog10e v) => v.expanded;
  static const Field<MathLog10e, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathLog10e v) => v.getNode;
  static const Field<MathLog10e, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathLog10e> fields = const {
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
  final dynamic discriminatorValue = 'math_log10e';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathLog10e _instantiate(DecodingData data) {
    return MathLog10e(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathLog10e fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathLog10e>(map);
  }

  static MathLog10e fromJson(String json) {
    return ensureInitialized().decodeJson<MathLog10e>(json);
  }
}

mixin MathLog10eMappable {
  String toJson() {
    return MathLog10eMapper.ensureInitialized()
        .encodeJson<MathLog10e>(this as MathLog10e);
  }

  Map<String, dynamic> toMap() {
    return MathLog10eMapper.ensureInitialized()
        .encodeMap<MathLog10e>(this as MathLog10e);
  }

  MathLog10eCopyWith<MathLog10e, MathLog10e, MathLog10e> get copyWith =>
      _MathLog10eCopyWithImpl(this as MathLog10e, $identity, $identity);
  @override
  String toString() {
    return MathLog10eMapper.ensureInitialized()
        .stringifyValue(this as MathLog10e);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathLog10eMapper.ensureInitialized()
                .isValueEqual(this as MathLog10e, other));
  }

  @override
  int get hashCode {
    return MathLog10eMapper.ensureInitialized().hashValue(this as MathLog10e);
  }
}

extension MathLog10eValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MathLog10e, $Out> {
  MathLog10eCopyWith<$R, MathLog10e, $Out> get $asMathLog10e =>
      $base.as((v, t, t2) => _MathLog10eCopyWithImpl(v, t, t2));
}

abstract class MathLog10eCopyWith<$R, $In extends MathLog10e, $Out>
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
  MathLog10eCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathLog10eCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathLog10e, $Out>
    implements MathLog10eCopyWith<$R, MathLog10e, $Out> {
  _MathLog10eCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathLog10e> $mapper =
      MathLog10eMapper.ensureInitialized();
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
  MathLog10e $make(CopyWithData data) => MathLog10e(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathLog10eCopyWith<$R2, MathLog10e, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MathLog10eCopyWithImpl($value, $cast, t);
}
