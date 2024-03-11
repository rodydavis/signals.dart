// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_last_index_of.dart';

class StringLastIndexOfMapper extends SubClassMapperBase<StringLastIndexOf> {
  StringLastIndexOfMapper._();

  static StringLastIndexOfMapper? _instance;
  static StringLastIndexOfMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringLastIndexOfMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringLastIndexOf';

  static int _$id(StringLastIndexOf v) => v.id;
  static const Field<StringLastIndexOf, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringLastIndexOf v) =>
      v.inputs;
  static const Field<StringLastIndexOf, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringLastIndexOf v) => v.offset;
  static const Field<StringLastIndexOf, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringLastIndexOf v) => v.label;
  static const Field<StringLastIndexOf, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringLastIndexOf v) => v.expanded;
  static const Field<StringLastIndexOf, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringLastIndexOf v) => v.getNode;
  static const Field<StringLastIndexOf, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringLastIndexOf> fields = const {
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
  final dynamic discriminatorValue = 'string_last_index_of';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringLastIndexOf _instantiate(DecodingData data) {
    return StringLastIndexOf(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringLastIndexOf fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringLastIndexOf>(map);
  }

  static StringLastIndexOf fromJson(String json) {
    return ensureInitialized().decodeJson<StringLastIndexOf>(json);
  }
}

mixin StringLastIndexOfMappable {
  String toJson() {
    return StringLastIndexOfMapper.ensureInitialized()
        .encodeJson<StringLastIndexOf>(this as StringLastIndexOf);
  }

  Map<String, dynamic> toMap() {
    return StringLastIndexOfMapper.ensureInitialized()
        .encodeMap<StringLastIndexOf>(this as StringLastIndexOf);
  }

  StringLastIndexOfCopyWith<StringLastIndexOf, StringLastIndexOf,
          StringLastIndexOf>
      get copyWith => _StringLastIndexOfCopyWithImpl(
          this as StringLastIndexOf, $identity, $identity);
  @override
  String toString() {
    return StringLastIndexOfMapper.ensureInitialized()
        .stringifyValue(this as StringLastIndexOf);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringLastIndexOfMapper.ensureInitialized()
                .isValueEqual(this as StringLastIndexOf, other));
  }

  @override
  int get hashCode {
    return StringLastIndexOfMapper.ensureInitialized()
        .hashValue(this as StringLastIndexOf);
  }
}

extension StringLastIndexOfValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringLastIndexOf, $Out> {
  StringLastIndexOfCopyWith<$R, StringLastIndexOf, $Out>
      get $asStringLastIndexOf =>
          $base.as((v, t, t2) => _StringLastIndexOfCopyWithImpl(v, t, t2));
}

abstract class StringLastIndexOfCopyWith<$R, $In extends StringLastIndexOf,
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
  StringLastIndexOfCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringLastIndexOfCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringLastIndexOf, $Out>
    implements StringLastIndexOfCopyWith<$R, StringLastIndexOf, $Out> {
  _StringLastIndexOfCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringLastIndexOf> $mapper =
      StringLastIndexOfMapper.ensureInitialized();
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
  StringLastIndexOf $make(CopyWithData data) => StringLastIndexOf(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringLastIndexOfCopyWith<$R2, StringLastIndexOf, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringLastIndexOfCopyWithImpl($value, $cast, t);
}
