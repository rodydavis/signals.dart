// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_to_radix_string.dart';

class IntToRadixStringMapper extends SubClassMapperBase<IntToRadixString> {
  IntToRadixStringMapper._();

  static IntToRadixStringMapper? _instance;
  static IntToRadixStringMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntToRadixStringMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntToRadixString';

  static int _$id(IntToRadixString v) => v.id;
  static const Field<IntToRadixString, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntToRadixString v) =>
      v.inputs;
  static const Field<IntToRadixString, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntToRadixString v) => v.offset;
  static const Field<IntToRadixString, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntToRadixString v) => v.label;
  static const Field<IntToRadixString, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntToRadixString v) => v.expanded;
  static const Field<IntToRadixString, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntToRadixString v) => v.getNode;
  static const Field<IntToRadixString, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntToRadixString> fields = const {
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
  final dynamic discriminatorValue = 'int_to_radix_string';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntToRadixString _instantiate(DecodingData data) {
    return IntToRadixString(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntToRadixString fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntToRadixString>(map);
  }

  static IntToRadixString fromJson(String json) {
    return ensureInitialized().decodeJson<IntToRadixString>(json);
  }
}

mixin IntToRadixStringMappable {
  String toJson() {
    return IntToRadixStringMapper.ensureInitialized()
        .encodeJson<IntToRadixString>(this as IntToRadixString);
  }

  Map<String, dynamic> toMap() {
    return IntToRadixStringMapper.ensureInitialized()
        .encodeMap<IntToRadixString>(this as IntToRadixString);
  }

  IntToRadixStringCopyWith<IntToRadixString, IntToRadixString, IntToRadixString>
      get copyWith => _IntToRadixStringCopyWithImpl(
          this as IntToRadixString, $identity, $identity);
  @override
  String toString() {
    return IntToRadixStringMapper.ensureInitialized()
        .stringifyValue(this as IntToRadixString);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntToRadixStringMapper.ensureInitialized()
                .isValueEqual(this as IntToRadixString, other));
  }

  @override
  int get hashCode {
    return IntToRadixStringMapper.ensureInitialized()
        .hashValue(this as IntToRadixString);
  }
}

extension IntToRadixStringValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntToRadixString, $Out> {
  IntToRadixStringCopyWith<$R, IntToRadixString, $Out>
      get $asIntToRadixString =>
          $base.as((v, t, t2) => _IntToRadixStringCopyWithImpl(v, t, t2));
}

abstract class IntToRadixStringCopyWith<$R, $In extends IntToRadixString, $Out>
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
  IntToRadixStringCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntToRadixStringCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntToRadixString, $Out>
    implements IntToRadixStringCopyWith<$R, IntToRadixString, $Out> {
  _IntToRadixStringCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntToRadixString> $mapper =
      IntToRadixStringMapper.ensureInitialized();
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
  IntToRadixString $make(CopyWithData data) => IntToRadixString(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntToRadixStringCopyWith<$R2, IntToRadixString, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntToRadixStringCopyWithImpl($value, $cast, t);
}
