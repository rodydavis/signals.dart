// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_ceil_to_double.dart';

class IntCeilToDoubleMapper extends SubClassMapperBase<IntCeilToDouble> {
  IntCeilToDoubleMapper._();

  static IntCeilToDoubleMapper? _instance;
  static IntCeilToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntCeilToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntCeilToDouble';

  static int _$id(IntCeilToDouble v) => v.id;
  static const Field<IntCeilToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntCeilToDouble v) =>
      v.inputs;
  static const Field<IntCeilToDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntCeilToDouble v) => v.offset;
  static const Field<IntCeilToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntCeilToDouble v) => v.label;
  static const Field<IntCeilToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntCeilToDouble v) => v.expanded;
  static const Field<IntCeilToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntCeilToDouble v) => v.getNode;
  static const Field<IntCeilToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntCeilToDouble> fields = const {
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
  final dynamic discriminatorValue = 'int_ceil_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntCeilToDouble _instantiate(DecodingData data) {
    return IntCeilToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntCeilToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntCeilToDouble>(map);
  }

  static IntCeilToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<IntCeilToDouble>(json);
  }
}

mixin IntCeilToDoubleMappable {
  String toJson() {
    return IntCeilToDoubleMapper.ensureInitialized()
        .encodeJson<IntCeilToDouble>(this as IntCeilToDouble);
  }

  Map<String, dynamic> toMap() {
    return IntCeilToDoubleMapper.ensureInitialized()
        .encodeMap<IntCeilToDouble>(this as IntCeilToDouble);
  }

  IntCeilToDoubleCopyWith<IntCeilToDouble, IntCeilToDouble, IntCeilToDouble>
      get copyWith => _IntCeilToDoubleCopyWithImpl(
          this as IntCeilToDouble, $identity, $identity);
  @override
  String toString() {
    return IntCeilToDoubleMapper.ensureInitialized()
        .stringifyValue(this as IntCeilToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntCeilToDoubleMapper.ensureInitialized()
                .isValueEqual(this as IntCeilToDouble, other));
  }

  @override
  int get hashCode {
    return IntCeilToDoubleMapper.ensureInitialized()
        .hashValue(this as IntCeilToDouble);
  }
}

extension IntCeilToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntCeilToDouble, $Out> {
  IntCeilToDoubleCopyWith<$R, IntCeilToDouble, $Out> get $asIntCeilToDouble =>
      $base.as((v, t, t2) => _IntCeilToDoubleCopyWithImpl(v, t, t2));
}

abstract class IntCeilToDoubleCopyWith<$R, $In extends IntCeilToDouble, $Out>
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
  IntCeilToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntCeilToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntCeilToDouble, $Out>
    implements IntCeilToDoubleCopyWith<$R, IntCeilToDouble, $Out> {
  _IntCeilToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntCeilToDouble> $mapper =
      IntCeilToDoubleMapper.ensureInitialized();
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
  IntCeilToDouble $make(CopyWithData data) => IntCeilToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntCeilToDoubleCopyWith<$R2, IntCeilToDouble, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntCeilToDoubleCopyWithImpl($value, $cast, t);
}
