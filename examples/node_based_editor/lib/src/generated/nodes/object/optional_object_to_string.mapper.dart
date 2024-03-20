// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'optional_object_to_string.dart';

class OptionalObjectToStringMapper
    extends SubClassMapperBase<OptionalObjectToString> {
  OptionalObjectToStringMapper._();

  static OptionalObjectToStringMapper? _instance;
  static OptionalObjectToStringMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OptionalObjectToStringMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'OptionalObjectToString';

  static int _$id(OptionalObjectToString v) => v.id;
  static const Field<OptionalObjectToString, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(OptionalObjectToString v) =>
      v.inputs;
  static const Field<OptionalObjectToString, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(OptionalObjectToString v) => v.offset;
  static const Field<OptionalObjectToString, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(OptionalObjectToString v) => v.label;
  static const Field<OptionalObjectToString, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(OptionalObjectToString v) => v.expanded;
  static const Field<OptionalObjectToString, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(OptionalObjectToString v) =>
      v.getNode;
  static const Field<OptionalObjectToString, BaseNode Function(int)>
      _f$getNode = Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<OptionalObjectToString> fields = const {
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
  final dynamic discriminatorValue = 'optional_object_to_string';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static OptionalObjectToString _instantiate(DecodingData data) {
    return OptionalObjectToString(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static OptionalObjectToString fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OptionalObjectToString>(map);
  }

  static OptionalObjectToString fromJson(String json) {
    return ensureInitialized().decodeJson<OptionalObjectToString>(json);
  }
}

mixin OptionalObjectToStringMappable {
  String toJson() {
    return OptionalObjectToStringMapper.ensureInitialized()
        .encodeJson<OptionalObjectToString>(this as OptionalObjectToString);
  }

  Map<String, dynamic> toMap() {
    return OptionalObjectToStringMapper.ensureInitialized()
        .encodeMap<OptionalObjectToString>(this as OptionalObjectToString);
  }

  OptionalObjectToStringCopyWith<OptionalObjectToString, OptionalObjectToString,
          OptionalObjectToString>
      get copyWith => _OptionalObjectToStringCopyWithImpl(
          this as OptionalObjectToString, $identity, $identity);
  @override
  String toString() {
    return OptionalObjectToStringMapper.ensureInitialized()
        .stringifyValue(this as OptionalObjectToString);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            OptionalObjectToStringMapper.ensureInitialized()
                .isValueEqual(this as OptionalObjectToString, other));
  }

  @override
  int get hashCode {
    return OptionalObjectToStringMapper.ensureInitialized()
        .hashValue(this as OptionalObjectToString);
  }
}

extension OptionalObjectToStringValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OptionalObjectToString, $Out> {
  OptionalObjectToStringCopyWith<$R, OptionalObjectToString, $Out>
      get $asOptionalObjectToString =>
          $base.as((v, t, t2) => _OptionalObjectToStringCopyWithImpl(v, t, t2));
}

abstract class OptionalObjectToStringCopyWith<
    $R,
    $In extends OptionalObjectToString,
    $Out> implements BaseNodeCopyWith<$R, $In, $Out> {
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
  OptionalObjectToStringCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _OptionalObjectToStringCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OptionalObjectToString, $Out>
    implements
        OptionalObjectToStringCopyWith<$R, OptionalObjectToString, $Out> {
  _OptionalObjectToStringCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OptionalObjectToString> $mapper =
      OptionalObjectToStringMapper.ensureInitialized();
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
  OptionalObjectToString $make(CopyWithData data) => OptionalObjectToString(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  OptionalObjectToStringCopyWith<$R2, OptionalObjectToString, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _OptionalObjectToStringCopyWithImpl($value, $cast, t);
}
