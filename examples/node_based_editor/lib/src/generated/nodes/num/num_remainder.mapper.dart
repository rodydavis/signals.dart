// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_remainder.dart';

class NumRemainderMapper extends SubClassMapperBase<NumRemainder> {
  NumRemainderMapper._();

  static NumRemainderMapper? _instance;
  static NumRemainderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumRemainderMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumRemainder';

  static int _$id(NumRemainder v) => v.id;
  static const Field<NumRemainder, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumRemainder v) => v.inputs;
  static const Field<NumRemainder, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumRemainder v) => v.offset;
  static const Field<NumRemainder, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumRemainder v) => v.label;
  static const Field<NumRemainder, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumRemainder v) => v.expanded;
  static const Field<NumRemainder, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumRemainder v) => v.getNode;
  static const Field<NumRemainder, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumRemainder> fields = const {
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
  final dynamic discriminatorValue = 'num_remainder';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumRemainder _instantiate(DecodingData data) {
    return NumRemainder(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumRemainder fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumRemainder>(map);
  }

  static NumRemainder fromJson(String json) {
    return ensureInitialized().decodeJson<NumRemainder>(json);
  }
}

mixin NumRemainderMappable {
  String toJson() {
    return NumRemainderMapper.ensureInitialized()
        .encodeJson<NumRemainder>(this as NumRemainder);
  }

  Map<String, dynamic> toMap() {
    return NumRemainderMapper.ensureInitialized()
        .encodeMap<NumRemainder>(this as NumRemainder);
  }

  NumRemainderCopyWith<NumRemainder, NumRemainder, NumRemainder> get copyWith =>
      _NumRemainderCopyWithImpl(this as NumRemainder, $identity, $identity);
  @override
  String toString() {
    return NumRemainderMapper.ensureInitialized()
        .stringifyValue(this as NumRemainder);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumRemainderMapper.ensureInitialized()
                .isValueEqual(this as NumRemainder, other));
  }

  @override
  int get hashCode {
    return NumRemainderMapper.ensureInitialized()
        .hashValue(this as NumRemainder);
  }
}

extension NumRemainderValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumRemainder, $Out> {
  NumRemainderCopyWith<$R, NumRemainder, $Out> get $asNumRemainder =>
      $base.as((v, t, t2) => _NumRemainderCopyWithImpl(v, t, t2));
}

abstract class NumRemainderCopyWith<$R, $In extends NumRemainder, $Out>
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
  NumRemainderCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumRemainderCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumRemainder, $Out>
    implements NumRemainderCopyWith<$R, NumRemainder, $Out> {
  _NumRemainderCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumRemainder> $mapper =
      NumRemainderMapper.ensureInitialized();
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
  NumRemainder $make(CopyWithData data) => NumRemainder(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumRemainderCopyWith<$R2, NumRemainder, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumRemainderCopyWithImpl($value, $cast, t);
}
