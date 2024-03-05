// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_compare_to.dart';

class IntCompareToMapper extends SubClassMapperBase<IntCompareTo> {
  IntCompareToMapper._();

  static IntCompareToMapper? _instance;
  static IntCompareToMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntCompareToMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntCompareTo';

  static int _$id(IntCompareTo v) => v.id;
  static const Field<IntCompareTo, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntCompareTo v) => v.inputs;
  static const Field<IntCompareTo, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntCompareTo v) => v.offset;
  static const Field<IntCompareTo, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntCompareTo v) => v.label;
  static const Field<IntCompareTo, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntCompareTo v) => v.expanded;
  static const Field<IntCompareTo, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntCompareTo v) => v.getNode;
  static const Field<IntCompareTo, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntCompareTo> fields = const {
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
  final dynamic discriminatorValue = 'int_compare_to';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntCompareTo _instantiate(DecodingData data) {
    return IntCompareTo(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntCompareTo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntCompareTo>(map);
  }

  static IntCompareTo fromJson(String json) {
    return ensureInitialized().decodeJson<IntCompareTo>(json);
  }
}

mixin IntCompareToMappable {
  String toJson() {
    return IntCompareToMapper.ensureInitialized()
        .encodeJson<IntCompareTo>(this as IntCompareTo);
  }

  Map<String, dynamic> toMap() {
    return IntCompareToMapper.ensureInitialized()
        .encodeMap<IntCompareTo>(this as IntCompareTo);
  }

  IntCompareToCopyWith<IntCompareTo, IntCompareTo, IntCompareTo> get copyWith =>
      _IntCompareToCopyWithImpl(this as IntCompareTo, $identity, $identity);
  @override
  String toString() {
    return IntCompareToMapper.ensureInitialized()
        .stringifyValue(this as IntCompareTo);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntCompareToMapper.ensureInitialized()
                .isValueEqual(this as IntCompareTo, other));
  }

  @override
  int get hashCode {
    return IntCompareToMapper.ensureInitialized()
        .hashValue(this as IntCompareTo);
  }
}

extension IntCompareToValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntCompareTo, $Out> {
  IntCompareToCopyWith<$R, IntCompareTo, $Out> get $asIntCompareTo =>
      $base.as((v, t, t2) => _IntCompareToCopyWithImpl(v, t, t2));
}

abstract class IntCompareToCopyWith<$R, $In extends IntCompareTo, $Out>
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
  IntCompareToCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntCompareToCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntCompareTo, $Out>
    implements IntCompareToCopyWith<$R, IntCompareTo, $Out> {
  _IntCompareToCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntCompareTo> $mapper =
      IntCompareToMapper.ensureInitialized();
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
  IntCompareTo $make(CopyWithData data) => IntCompareTo(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntCompareToCopyWith<$R2, IntCompareTo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntCompareToCopyWithImpl($value, $cast, t);
}
