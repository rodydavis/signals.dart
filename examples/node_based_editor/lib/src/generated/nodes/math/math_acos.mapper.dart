// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_acos.dart';

class MathAcosMapper extends SubClassMapperBase<MathAcos> {
  MathAcosMapper._();

  static MathAcosMapper? _instance;
  static MathAcosMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathAcosMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathAcos';

  static int _$id(MathAcos v) => v.id;
  static const Field<MathAcos, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathAcos v) => v.inputs;
  static const Field<MathAcos, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathAcos v) => v.offset;
  static const Field<MathAcos, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathAcos v) => v.label;
  static const Field<MathAcos, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathAcos v) => v.expanded;
  static const Field<MathAcos, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathAcos v) => v.getNode;
  static const Field<MathAcos, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathAcos> fields = const {
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
  final dynamic discriminatorValue = 'math_acos';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathAcos _instantiate(DecodingData data) {
    return MathAcos(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathAcos fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathAcos>(map);
  }

  static MathAcos fromJson(String json) {
    return ensureInitialized().decodeJson<MathAcos>(json);
  }
}

mixin MathAcosMappable {
  String toJson() {
    return MathAcosMapper.ensureInitialized()
        .encodeJson<MathAcos>(this as MathAcos);
  }

  Map<String, dynamic> toMap() {
    return MathAcosMapper.ensureInitialized()
        .encodeMap<MathAcos>(this as MathAcos);
  }

  MathAcosCopyWith<MathAcos, MathAcos, MathAcos> get copyWith =>
      _MathAcosCopyWithImpl(this as MathAcos, $identity, $identity);
  @override
  String toString() {
    return MathAcosMapper.ensureInitialized().stringifyValue(this as MathAcos);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathAcosMapper.ensureInitialized()
                .isValueEqual(this as MathAcos, other));
  }

  @override
  int get hashCode {
    return MathAcosMapper.ensureInitialized().hashValue(this as MathAcos);
  }
}

extension MathAcosValueCopy<$R, $Out> on ObjectCopyWith<$R, MathAcos, $Out> {
  MathAcosCopyWith<$R, MathAcos, $Out> get $asMathAcos =>
      $base.as((v, t, t2) => _MathAcosCopyWithImpl(v, t, t2));
}

abstract class MathAcosCopyWith<$R, $In extends MathAcos, $Out>
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
  MathAcosCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathAcosCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathAcos, $Out>
    implements MathAcosCopyWith<$R, MathAcos, $Out> {
  _MathAcosCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathAcos> $mapper =
      MathAcosMapper.ensureInitialized();
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
  MathAcos $make(CopyWithData data) => MathAcos(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathAcosCopyWith<$R2, MathAcos, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MathAcosCopyWithImpl($value, $cast, t);
}
