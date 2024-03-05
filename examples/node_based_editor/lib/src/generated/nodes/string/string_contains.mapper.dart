// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_contains.dart';

class StringContainsMapper extends SubClassMapperBase<StringContains> {
  StringContainsMapper._();

  static StringContainsMapper? _instance;
  static StringContainsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringContainsMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringContains';

  static int _$id(StringContains v) => v.id;
  static const Field<StringContains, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringContains v) => v.inputs;
  static const Field<StringContains, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringContains v) => v.offset;
  static const Field<StringContains, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringContains v) => v.label;
  static const Field<StringContains, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringContains v) => v.expanded;
  static const Field<StringContains, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringContains v) => v.getNode;
  static const Field<StringContains, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringContains> fields = const {
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
  final dynamic discriminatorValue = 'string_contains';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringContains _instantiate(DecodingData data) {
    return StringContains(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringContains fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringContains>(map);
  }

  static StringContains fromJson(String json) {
    return ensureInitialized().decodeJson<StringContains>(json);
  }
}

mixin StringContainsMappable {
  String toJson() {
    return StringContainsMapper.ensureInitialized()
        .encodeJson<StringContains>(this as StringContains);
  }

  Map<String, dynamic> toMap() {
    return StringContainsMapper.ensureInitialized()
        .encodeMap<StringContains>(this as StringContains);
  }

  StringContainsCopyWith<StringContains, StringContains, StringContains>
      get copyWith => _StringContainsCopyWithImpl(
          this as StringContains, $identity, $identity);
  @override
  String toString() {
    return StringContainsMapper.ensureInitialized()
        .stringifyValue(this as StringContains);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringContainsMapper.ensureInitialized()
                .isValueEqual(this as StringContains, other));
  }

  @override
  int get hashCode {
    return StringContainsMapper.ensureInitialized()
        .hashValue(this as StringContains);
  }
}

extension StringContainsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringContains, $Out> {
  StringContainsCopyWith<$R, StringContains, $Out> get $asStringContains =>
      $base.as((v, t, t2) => _StringContainsCopyWithImpl(v, t, t2));
}

abstract class StringContainsCopyWith<$R, $In extends StringContains, $Out>
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
  StringContainsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringContainsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringContains, $Out>
    implements StringContainsCopyWith<$R, StringContains, $Out> {
  _StringContainsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringContains> $mapper =
      StringContainsMapper.ensureInitialized();
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
  StringContains $make(CopyWithData data) => StringContains(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringContainsCopyWith<$R2, StringContains, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringContainsCopyWithImpl($value, $cast, t);
}
