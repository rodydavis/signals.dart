// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_to_double.dart';

class IntToDoubleMapper extends SubClassMapperBase<IntToDouble> {
  IntToDoubleMapper._();

  static IntToDoubleMapper? _instance;
  static IntToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntToDouble';

  static int _$id(IntToDouble v) => v.id;
  static const Field<IntToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntToDouble v) => v.inputs;
  static const Field<IntToDouble, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntToDouble v) => v.offset;
  static const Field<IntToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntToDouble v) => v.label;
  static const Field<IntToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntToDouble v) => v.expanded;
  static const Field<IntToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntToDouble v) => v.getNode;
  static const Field<IntToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntToDouble> fields = const {
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
  final dynamic discriminatorValue = 'int_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntToDouble _instantiate(DecodingData data) {
    return IntToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntToDouble>(map);
  }

  static IntToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<IntToDouble>(json);
  }
}

mixin IntToDoubleMappable {
  String toJson() {
    return IntToDoubleMapper.ensureInitialized()
        .encodeJson<IntToDouble>(this as IntToDouble);
  }

  Map<String, dynamic> toMap() {
    return IntToDoubleMapper.ensureInitialized()
        .encodeMap<IntToDouble>(this as IntToDouble);
  }

  IntToDoubleCopyWith<IntToDouble, IntToDouble, IntToDouble> get copyWith =>
      _IntToDoubleCopyWithImpl(this as IntToDouble, $identity, $identity);
  @override
  String toString() {
    return IntToDoubleMapper.ensureInitialized()
        .stringifyValue(this as IntToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntToDoubleMapper.ensureInitialized()
                .isValueEqual(this as IntToDouble, other));
  }

  @override
  int get hashCode {
    return IntToDoubleMapper.ensureInitialized().hashValue(this as IntToDouble);
  }
}

extension IntToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntToDouble, $Out> {
  IntToDoubleCopyWith<$R, IntToDouble, $Out> get $asIntToDouble =>
      $base.as((v, t, t2) => _IntToDoubleCopyWithImpl(v, t, t2));
}

abstract class IntToDoubleCopyWith<$R, $In extends IntToDouble, $Out>
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
  IntToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntToDouble, $Out>
    implements IntToDoubleCopyWith<$R, IntToDouble, $Out> {
  _IntToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntToDouble> $mapper =
      IntToDoubleMapper.ensureInitialized();
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
  IntToDouble $make(CopyWithData data) => IntToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntToDoubleCopyWith<$R2, IntToDouble, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntToDoubleCopyWithImpl($value, $cast, t);
}
