// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_gcd.dart';

class IntGcdMapper extends SubClassMapperBase<IntGcd> {
  IntGcdMapper._();

  static IntGcdMapper? _instance;
  static IntGcdMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntGcdMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntGcd';

  static int _$id(IntGcd v) => v.id;
  static const Field<IntGcd, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntGcd v) => v.inputs;
  static const Field<IntGcd, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntGcd v) => v.offset;
  static const Field<IntGcd, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntGcd v) => v.label;
  static const Field<IntGcd, Signal<String>> _f$label = Field('label', _$label);
  static Signal<bool> _$expanded(IntGcd v) => v.expanded;
  static const Field<IntGcd, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntGcd v) => v.getNode;
  static const Field<IntGcd, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntGcd> fields = const {
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
  final dynamic discriminatorValue = 'int_gcd';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntGcd _instantiate(DecodingData data) {
    return IntGcd(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntGcd fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntGcd>(map);
  }

  static IntGcd fromJson(String json) {
    return ensureInitialized().decodeJson<IntGcd>(json);
  }
}

mixin IntGcdMappable {
  String toJson() {
    return IntGcdMapper.ensureInitialized().encodeJson<IntGcd>(this as IntGcd);
  }

  Map<String, dynamic> toMap() {
    return IntGcdMapper.ensureInitialized().encodeMap<IntGcd>(this as IntGcd);
  }

  IntGcdCopyWith<IntGcd, IntGcd, IntGcd> get copyWith =>
      _IntGcdCopyWithImpl(this as IntGcd, $identity, $identity);
  @override
  String toString() {
    return IntGcdMapper.ensureInitialized().stringifyValue(this as IntGcd);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntGcdMapper.ensureInitialized()
                .isValueEqual(this as IntGcd, other));
  }

  @override
  int get hashCode {
    return IntGcdMapper.ensureInitialized().hashValue(this as IntGcd);
  }
}

extension IntGcdValueCopy<$R, $Out> on ObjectCopyWith<$R, IntGcd, $Out> {
  IntGcdCopyWith<$R, IntGcd, $Out> get $asIntGcd =>
      $base.as((v, t, t2) => _IntGcdCopyWithImpl(v, t, t2));
}

abstract class IntGcdCopyWith<$R, $In extends IntGcd, $Out>
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
  IntGcdCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntGcdCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, IntGcd, $Out>
    implements IntGcdCopyWith<$R, IntGcd, $Out> {
  _IntGcdCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntGcd> $mapper = IntGcdMapper.ensureInitialized();
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
  IntGcd $make(CopyWithData data) => IntGcd(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntGcdCopyWith<$R2, IntGcd, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _IntGcdCopyWithImpl($value, $cast, t);
}
