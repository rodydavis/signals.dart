// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_abs.dart';

class IntAbsMapper extends SubClassMapperBase<IntAbs> {
  IntAbsMapper._();

  static IntAbsMapper? _instance;
  static IntAbsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntAbsMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntAbs';

  static int _$id(IntAbs v) => v.id;
  static const Field<IntAbs, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntAbs v) => v.inputs;
  static const Field<IntAbs, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntAbs v) => v.offset;
  static const Field<IntAbs, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntAbs v) => v.label;
  static const Field<IntAbs, Signal<String>> _f$label = Field('label', _$label);
  static Signal<bool> _$expanded(IntAbs v) => v.expanded;
  static const Field<IntAbs, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntAbs v) => v.getNode;
  static const Field<IntAbs, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntAbs> fields = const {
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
  final dynamic discriminatorValue = 'int_abs';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntAbs _instantiate(DecodingData data) {
    return IntAbs(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntAbs fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntAbs>(map);
  }

  static IntAbs fromJson(String json) {
    return ensureInitialized().decodeJson<IntAbs>(json);
  }
}

mixin IntAbsMappable {
  String toJson() {
    return IntAbsMapper.ensureInitialized().encodeJson<IntAbs>(this as IntAbs);
  }

  Map<String, dynamic> toMap() {
    return IntAbsMapper.ensureInitialized().encodeMap<IntAbs>(this as IntAbs);
  }

  IntAbsCopyWith<IntAbs, IntAbs, IntAbs> get copyWith =>
      _IntAbsCopyWithImpl(this as IntAbs, $identity, $identity);
  @override
  String toString() {
    return IntAbsMapper.ensureInitialized().stringifyValue(this as IntAbs);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntAbsMapper.ensureInitialized()
                .isValueEqual(this as IntAbs, other));
  }

  @override
  int get hashCode {
    return IntAbsMapper.ensureInitialized().hashValue(this as IntAbs);
  }
}

extension IntAbsValueCopy<$R, $Out> on ObjectCopyWith<$R, IntAbs, $Out> {
  IntAbsCopyWith<$R, IntAbs, $Out> get $asIntAbs =>
      $base.as((v, t, t2) => _IntAbsCopyWithImpl(v, t, t2));
}

abstract class IntAbsCopyWith<$R, $In extends IntAbs, $Out>
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
  IntAbsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntAbsCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, IntAbs, $Out>
    implements IntAbsCopyWith<$R, IntAbs, $Out> {
  _IntAbsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntAbs> $mapper = IntAbsMapper.ensureInitialized();
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
  IntAbs $make(CopyWithData data) => IntAbs(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntAbsCopyWith<$R2, IntAbs, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _IntAbsCopyWithImpl($value, $cast, t);
}
