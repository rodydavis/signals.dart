// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_mod_pow.dart';

class IntModPowMapper extends SubClassMapperBase<IntModPow> {
  IntModPowMapper._();

  static IntModPowMapper? _instance;
  static IntModPowMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntModPowMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntModPow';

  static int _$id(IntModPow v) => v.id;
  static const Field<IntModPow, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntModPow v) => v.inputs;
  static const Field<IntModPow, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntModPow v) => v.offset;
  static const Field<IntModPow, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntModPow v) => v.label;
  static const Field<IntModPow, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntModPow v) => v.expanded;
  static const Field<IntModPow, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntModPow v) => v.getNode;
  static const Field<IntModPow, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntModPow> fields = const {
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
  final dynamic discriminatorValue = 'int_mod_pow';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntModPow _instantiate(DecodingData data) {
    return IntModPow(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntModPow fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntModPow>(map);
  }

  static IntModPow fromJson(String json) {
    return ensureInitialized().decodeJson<IntModPow>(json);
  }
}

mixin IntModPowMappable {
  String toJson() {
    return IntModPowMapper.ensureInitialized()
        .encodeJson<IntModPow>(this as IntModPow);
  }

  Map<String, dynamic> toMap() {
    return IntModPowMapper.ensureInitialized()
        .encodeMap<IntModPow>(this as IntModPow);
  }

  IntModPowCopyWith<IntModPow, IntModPow, IntModPow> get copyWith =>
      _IntModPowCopyWithImpl(this as IntModPow, $identity, $identity);
  @override
  String toString() {
    return IntModPowMapper.ensureInitialized()
        .stringifyValue(this as IntModPow);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntModPowMapper.ensureInitialized()
                .isValueEqual(this as IntModPow, other));
  }

  @override
  int get hashCode {
    return IntModPowMapper.ensureInitialized().hashValue(this as IntModPow);
  }
}

extension IntModPowValueCopy<$R, $Out> on ObjectCopyWith<$R, IntModPow, $Out> {
  IntModPowCopyWith<$R, IntModPow, $Out> get $asIntModPow =>
      $base.as((v, t, t2) => _IntModPowCopyWithImpl(v, t, t2));
}

abstract class IntModPowCopyWith<$R, $In extends IntModPow, $Out>
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
  IntModPowCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntModPowCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntModPow, $Out>
    implements IntModPowCopyWith<$R, IntModPow, $Out> {
  _IntModPowCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntModPow> $mapper =
      IntModPowMapper.ensureInitialized();
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
  IntModPow $make(CopyWithData data) => IntModPow(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntModPowCopyWith<$R2, IntModPow, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntModPowCopyWithImpl($value, $cast, t);
}
