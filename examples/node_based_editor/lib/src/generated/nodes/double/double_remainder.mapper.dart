// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_remainder.dart';

class DoubleRemainderMapper extends SubClassMapperBase<DoubleRemainder> {
  DoubleRemainderMapper._();

  static DoubleRemainderMapper? _instance;
  static DoubleRemainderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleRemainderMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleRemainder';

  static int _$id(DoubleRemainder v) => v.id;
  static const Field<DoubleRemainder, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleRemainder v) =>
      v.inputs;
  static const Field<DoubleRemainder, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleRemainder v) => v.offset;
  static const Field<DoubleRemainder, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleRemainder v) => v.label;
  static const Field<DoubleRemainder, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleRemainder v) => v.expanded;
  static const Field<DoubleRemainder, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleRemainder v) => v.getNode;
  static const Field<DoubleRemainder, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleRemainder> fields = const {
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
  final dynamic discriminatorValue = 'double_remainder';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleRemainder _instantiate(DecodingData data) {
    return DoubleRemainder(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleRemainder fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleRemainder>(map);
  }

  static DoubleRemainder fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleRemainder>(json);
  }
}

mixin DoubleRemainderMappable {
  String toJson() {
    return DoubleRemainderMapper.ensureInitialized()
        .encodeJson<DoubleRemainder>(this as DoubleRemainder);
  }

  Map<String, dynamic> toMap() {
    return DoubleRemainderMapper.ensureInitialized()
        .encodeMap<DoubleRemainder>(this as DoubleRemainder);
  }

  DoubleRemainderCopyWith<DoubleRemainder, DoubleRemainder, DoubleRemainder>
      get copyWith => _DoubleRemainderCopyWithImpl(
          this as DoubleRemainder, $identity, $identity);
  @override
  String toString() {
    return DoubleRemainderMapper.ensureInitialized()
        .stringifyValue(this as DoubleRemainder);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleRemainderMapper.ensureInitialized()
                .isValueEqual(this as DoubleRemainder, other));
  }

  @override
  int get hashCode {
    return DoubleRemainderMapper.ensureInitialized()
        .hashValue(this as DoubleRemainder);
  }
}

extension DoubleRemainderValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleRemainder, $Out> {
  DoubleRemainderCopyWith<$R, DoubleRemainder, $Out> get $asDoubleRemainder =>
      $base.as((v, t, t2) => _DoubleRemainderCopyWithImpl(v, t, t2));
}

abstract class DoubleRemainderCopyWith<$R, $In extends DoubleRemainder, $Out>
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
  DoubleRemainderCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleRemainderCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleRemainder, $Out>
    implements DoubleRemainderCopyWith<$R, DoubleRemainder, $Out> {
  _DoubleRemainderCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleRemainder> $mapper =
      DoubleRemainderMapper.ensureInitialized();
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
  DoubleRemainder $make(CopyWithData data) => DoubleRemainder(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleRemainderCopyWith<$R2, DoubleRemainder, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleRemainderCopyWithImpl($value, $cast, t);
}
