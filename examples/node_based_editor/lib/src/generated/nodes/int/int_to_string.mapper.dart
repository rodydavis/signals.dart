// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_to_string.dart';

class IntToStringMapper extends SubClassMapperBase<IntToString> {
  IntToStringMapper._();

  static IntToStringMapper? _instance;
  static IntToStringMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntToStringMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntToString';

  static int _$id(IntToString v) => v.id;
  static const Field<IntToString, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntToString v) => v.inputs;
  static const Field<IntToString, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntToString v) => v.offset;
  static const Field<IntToString, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntToString v) => v.label;
  static const Field<IntToString, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntToString v) => v.expanded;
  static const Field<IntToString, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntToString v) => v.getNode;
  static const Field<IntToString, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntToString> fields = const {
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
  final dynamic discriminatorValue = 'int_to_string';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntToString _instantiate(DecodingData data) {
    return IntToString(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntToString fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntToString>(map);
  }

  static IntToString fromJson(String json) {
    return ensureInitialized().decodeJson<IntToString>(json);
  }
}

mixin IntToStringMappable {
  String toJson() {
    return IntToStringMapper.ensureInitialized()
        .encodeJson<IntToString>(this as IntToString);
  }

  Map<String, dynamic> toMap() {
    return IntToStringMapper.ensureInitialized()
        .encodeMap<IntToString>(this as IntToString);
  }

  IntToStringCopyWith<IntToString, IntToString, IntToString> get copyWith =>
      _IntToStringCopyWithImpl(this as IntToString, $identity, $identity);
  @override
  String toString() {
    return IntToStringMapper.ensureInitialized()
        .stringifyValue(this as IntToString);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntToStringMapper.ensureInitialized()
                .isValueEqual(this as IntToString, other));
  }

  @override
  int get hashCode {
    return IntToStringMapper.ensureInitialized().hashValue(this as IntToString);
  }
}

extension IntToStringValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntToString, $Out> {
  IntToStringCopyWith<$R, IntToString, $Out> get $asIntToString =>
      $base.as((v, t, t2) => _IntToStringCopyWithImpl(v, t, t2));
}

abstract class IntToStringCopyWith<$R, $In extends IntToString, $Out>
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
  IntToStringCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntToStringCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntToString, $Out>
    implements IntToStringCopyWith<$R, IntToString, $Out> {
  _IntToStringCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntToString> $mapper =
      IntToStringMapper.ensureInitialized();
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
  IntToString $make(CopyWithData data) => IntToString(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntToStringCopyWith<$R2, IntToString, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntToStringCopyWithImpl($value, $cast, t);
}
