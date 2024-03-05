// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_is_even.dart';

class IntIsEvenMapper extends SubClassMapperBase<IntIsEven> {
  IntIsEvenMapper._();

  static IntIsEvenMapper? _instance;
  static IntIsEvenMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntIsEvenMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntIsEven';

  static int _$id(IntIsEven v) => v.id;
  static const Field<IntIsEven, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntIsEven v) => v.inputs;
  static const Field<IntIsEven, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntIsEven v) => v.offset;
  static const Field<IntIsEven, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntIsEven v) => v.label;
  static const Field<IntIsEven, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntIsEven v) => v.expanded;
  static const Field<IntIsEven, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntIsEven v) => v.getNode;
  static const Field<IntIsEven, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntIsEven> fields = const {
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
  final dynamic discriminatorValue = 'int_is_even';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntIsEven _instantiate(DecodingData data) {
    return IntIsEven(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntIsEven fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntIsEven>(map);
  }

  static IntIsEven fromJson(String json) {
    return ensureInitialized().decodeJson<IntIsEven>(json);
  }
}

mixin IntIsEvenMappable {
  String toJson() {
    return IntIsEvenMapper.ensureInitialized()
        .encodeJson<IntIsEven>(this as IntIsEven);
  }

  Map<String, dynamic> toMap() {
    return IntIsEvenMapper.ensureInitialized()
        .encodeMap<IntIsEven>(this as IntIsEven);
  }

  IntIsEvenCopyWith<IntIsEven, IntIsEven, IntIsEven> get copyWith =>
      _IntIsEvenCopyWithImpl(this as IntIsEven, $identity, $identity);
  @override
  String toString() {
    return IntIsEvenMapper.ensureInitialized()
        .stringifyValue(this as IntIsEven);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntIsEvenMapper.ensureInitialized()
                .isValueEqual(this as IntIsEven, other));
  }

  @override
  int get hashCode {
    return IntIsEvenMapper.ensureInitialized().hashValue(this as IntIsEven);
  }
}

extension IntIsEvenValueCopy<$R, $Out> on ObjectCopyWith<$R, IntIsEven, $Out> {
  IntIsEvenCopyWith<$R, IntIsEven, $Out> get $asIntIsEven =>
      $base.as((v, t, t2) => _IntIsEvenCopyWithImpl(v, t, t2));
}

abstract class IntIsEvenCopyWith<$R, $In extends IntIsEven, $Out>
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
  IntIsEvenCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntIsEvenCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntIsEven, $Out>
    implements IntIsEvenCopyWith<$R, IntIsEven, $Out> {
  _IntIsEvenCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntIsEven> $mapper =
      IntIsEvenMapper.ensureInitialized();
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
  IntIsEven $make(CopyWithData data) => IntIsEven(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntIsEvenCopyWith<$R2, IntIsEven, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntIsEvenCopyWithImpl($value, $cast, t);
}
