// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_round_to_double.dart';

class IntRoundToDoubleMapper extends SubClassMapperBase<IntRoundToDouble> {
  IntRoundToDoubleMapper._();

  static IntRoundToDoubleMapper? _instance;
  static IntRoundToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntRoundToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntRoundToDouble';

  static int _$id(IntRoundToDouble v) => v.id;
  static const Field<IntRoundToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntRoundToDouble v) =>
      v.inputs;
  static const Field<IntRoundToDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntRoundToDouble v) => v.offset;
  static const Field<IntRoundToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntRoundToDouble v) => v.label;
  static const Field<IntRoundToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntRoundToDouble v) => v.expanded;
  static const Field<IntRoundToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntRoundToDouble v) => v.getNode;
  static const Field<IntRoundToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntRoundToDouble> fields = const {
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
  final dynamic discriminatorValue = 'int_round_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntRoundToDouble _instantiate(DecodingData data) {
    return IntRoundToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntRoundToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntRoundToDouble>(map);
  }

  static IntRoundToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<IntRoundToDouble>(json);
  }
}

mixin IntRoundToDoubleMappable {
  String toJson() {
    return IntRoundToDoubleMapper.ensureInitialized()
        .encodeJson<IntRoundToDouble>(this as IntRoundToDouble);
  }

  Map<String, dynamic> toMap() {
    return IntRoundToDoubleMapper.ensureInitialized()
        .encodeMap<IntRoundToDouble>(this as IntRoundToDouble);
  }

  IntRoundToDoubleCopyWith<IntRoundToDouble, IntRoundToDouble, IntRoundToDouble>
      get copyWith => _IntRoundToDoubleCopyWithImpl(
          this as IntRoundToDouble, $identity, $identity);
  @override
  String toString() {
    return IntRoundToDoubleMapper.ensureInitialized()
        .stringifyValue(this as IntRoundToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntRoundToDoubleMapper.ensureInitialized()
                .isValueEqual(this as IntRoundToDouble, other));
  }

  @override
  int get hashCode {
    return IntRoundToDoubleMapper.ensureInitialized()
        .hashValue(this as IntRoundToDouble);
  }
}

extension IntRoundToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntRoundToDouble, $Out> {
  IntRoundToDoubleCopyWith<$R, IntRoundToDouble, $Out>
      get $asIntRoundToDouble =>
          $base.as((v, t, t2) => _IntRoundToDoubleCopyWithImpl(v, t, t2));
}

abstract class IntRoundToDoubleCopyWith<$R, $In extends IntRoundToDouble, $Out>
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
  IntRoundToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntRoundToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntRoundToDouble, $Out>
    implements IntRoundToDoubleCopyWith<$R, IntRoundToDouble, $Out> {
  _IntRoundToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntRoundToDouble> $mapper =
      IntRoundToDoubleMapper.ensureInitialized();
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
  IntRoundToDouble $make(CopyWithData data) => IntRoundToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntRoundToDoubleCopyWith<$R2, IntRoundToDouble, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntRoundToDoubleCopyWithImpl($value, $cast, t);
}
