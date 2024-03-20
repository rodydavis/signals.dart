// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_remainder.dart';

class IntRemainderMapper extends SubClassMapperBase<IntRemainder> {
  IntRemainderMapper._();

  static IntRemainderMapper? _instance;
  static IntRemainderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntRemainderMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntRemainder';

  static int _$id(IntRemainder v) => v.id;
  static const Field<IntRemainder, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntRemainder v) => v.inputs;
  static const Field<IntRemainder, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntRemainder v) => v.offset;
  static const Field<IntRemainder, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntRemainder v) => v.label;
  static const Field<IntRemainder, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntRemainder v) => v.expanded;
  static const Field<IntRemainder, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntRemainder v) => v.getNode;
  static const Field<IntRemainder, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntRemainder> fields = const {
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
  final dynamic discriminatorValue = 'int_remainder';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntRemainder _instantiate(DecodingData data) {
    return IntRemainder(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntRemainder fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntRemainder>(map);
  }

  static IntRemainder fromJson(String json) {
    return ensureInitialized().decodeJson<IntRemainder>(json);
  }
}

mixin IntRemainderMappable {
  String toJson() {
    return IntRemainderMapper.ensureInitialized()
        .encodeJson<IntRemainder>(this as IntRemainder);
  }

  Map<String, dynamic> toMap() {
    return IntRemainderMapper.ensureInitialized()
        .encodeMap<IntRemainder>(this as IntRemainder);
  }

  IntRemainderCopyWith<IntRemainder, IntRemainder, IntRemainder> get copyWith =>
      _IntRemainderCopyWithImpl(this as IntRemainder, $identity, $identity);
  @override
  String toString() {
    return IntRemainderMapper.ensureInitialized()
        .stringifyValue(this as IntRemainder);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntRemainderMapper.ensureInitialized()
                .isValueEqual(this as IntRemainder, other));
  }

  @override
  int get hashCode {
    return IntRemainderMapper.ensureInitialized()
        .hashValue(this as IntRemainder);
  }
}

extension IntRemainderValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntRemainder, $Out> {
  IntRemainderCopyWith<$R, IntRemainder, $Out> get $asIntRemainder =>
      $base.as((v, t, t2) => _IntRemainderCopyWithImpl(v, t, t2));
}

abstract class IntRemainderCopyWith<$R, $In extends IntRemainder, $Out>
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
  IntRemainderCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntRemainderCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntRemainder, $Out>
    implements IntRemainderCopyWith<$R, IntRemainder, $Out> {
  _IntRemainderCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntRemainder> $mapper =
      IntRemainderMapper.ensureInitialized();
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
  IntRemainder $make(CopyWithData data) => IntRemainder(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntRemainderCopyWith<$R2, IntRemainder, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntRemainderCopyWithImpl($value, $cast, t);
}
