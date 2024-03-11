// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_replace_first.dart';

class StringReplaceFirstMapper extends SubClassMapperBase<StringReplaceFirst> {
  StringReplaceFirstMapper._();

  static StringReplaceFirstMapper? _instance;
  static StringReplaceFirstMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringReplaceFirstMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringReplaceFirst';

  static int _$id(StringReplaceFirst v) => v.id;
  static const Field<StringReplaceFirst, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringReplaceFirst v) =>
      v.inputs;
  static const Field<StringReplaceFirst, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringReplaceFirst v) => v.offset;
  static const Field<StringReplaceFirst, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringReplaceFirst v) => v.label;
  static const Field<StringReplaceFirst, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringReplaceFirst v) => v.expanded;
  static const Field<StringReplaceFirst, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringReplaceFirst v) => v.getNode;
  static const Field<StringReplaceFirst, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringReplaceFirst> fields = const {
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
  final dynamic discriminatorValue = 'string_replace_first';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringReplaceFirst _instantiate(DecodingData data) {
    return StringReplaceFirst(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringReplaceFirst fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringReplaceFirst>(map);
  }

  static StringReplaceFirst fromJson(String json) {
    return ensureInitialized().decodeJson<StringReplaceFirst>(json);
  }
}

mixin StringReplaceFirstMappable {
  String toJson() {
    return StringReplaceFirstMapper.ensureInitialized()
        .encodeJson<StringReplaceFirst>(this as StringReplaceFirst);
  }

  Map<String, dynamic> toMap() {
    return StringReplaceFirstMapper.ensureInitialized()
        .encodeMap<StringReplaceFirst>(this as StringReplaceFirst);
  }

  StringReplaceFirstCopyWith<StringReplaceFirst, StringReplaceFirst,
          StringReplaceFirst>
      get copyWith => _StringReplaceFirstCopyWithImpl(
          this as StringReplaceFirst, $identity, $identity);
  @override
  String toString() {
    return StringReplaceFirstMapper.ensureInitialized()
        .stringifyValue(this as StringReplaceFirst);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringReplaceFirstMapper.ensureInitialized()
                .isValueEqual(this as StringReplaceFirst, other));
  }

  @override
  int get hashCode {
    return StringReplaceFirstMapper.ensureInitialized()
        .hashValue(this as StringReplaceFirst);
  }
}

extension StringReplaceFirstValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringReplaceFirst, $Out> {
  StringReplaceFirstCopyWith<$R, StringReplaceFirst, $Out>
      get $asStringReplaceFirst =>
          $base.as((v, t, t2) => _StringReplaceFirstCopyWithImpl(v, t, t2));
}

abstract class StringReplaceFirstCopyWith<$R, $In extends StringReplaceFirst,
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
  StringReplaceFirstCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringReplaceFirstCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringReplaceFirst, $Out>
    implements StringReplaceFirstCopyWith<$R, StringReplaceFirst, $Out> {
  _StringReplaceFirstCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringReplaceFirst> $mapper =
      StringReplaceFirstMapper.ensureInitialized();
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
  StringReplaceFirst $make(CopyWithData data) => StringReplaceFirst(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringReplaceFirstCopyWith<$R2, StringReplaceFirst, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringReplaceFirstCopyWithImpl($value, $cast, t);
}
