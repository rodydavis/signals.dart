// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_index_of.dart';

class StringIndexOfMapper extends SubClassMapperBase<StringIndexOf> {
  StringIndexOfMapper._();

  static StringIndexOfMapper? _instance;
  static StringIndexOfMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringIndexOfMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringIndexOf';

  static int _$id(StringIndexOf v) => v.id;
  static const Field<StringIndexOf, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringIndexOf v) => v.inputs;
  static const Field<StringIndexOf, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringIndexOf v) => v.offset;
  static const Field<StringIndexOf, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringIndexOf v) => v.label;
  static const Field<StringIndexOf, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringIndexOf v) => v.expanded;
  static const Field<StringIndexOf, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringIndexOf v) => v.getNode;
  static const Field<StringIndexOf, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringIndexOf> fields = const {
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
  final dynamic discriminatorValue = 'string_index_of';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringIndexOf _instantiate(DecodingData data) {
    return StringIndexOf(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringIndexOf fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringIndexOf>(map);
  }

  static StringIndexOf fromJson(String json) {
    return ensureInitialized().decodeJson<StringIndexOf>(json);
  }
}

mixin StringIndexOfMappable {
  String toJson() {
    return StringIndexOfMapper.ensureInitialized()
        .encodeJson<StringIndexOf>(this as StringIndexOf);
  }

  Map<String, dynamic> toMap() {
    return StringIndexOfMapper.ensureInitialized()
        .encodeMap<StringIndexOf>(this as StringIndexOf);
  }

  StringIndexOfCopyWith<StringIndexOf, StringIndexOf, StringIndexOf>
      get copyWith => _StringIndexOfCopyWithImpl(
          this as StringIndexOf, $identity, $identity);
  @override
  String toString() {
    return StringIndexOfMapper.ensureInitialized()
        .stringifyValue(this as StringIndexOf);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringIndexOfMapper.ensureInitialized()
                .isValueEqual(this as StringIndexOf, other));
  }

  @override
  int get hashCode {
    return StringIndexOfMapper.ensureInitialized()
        .hashValue(this as StringIndexOf);
  }
}

extension StringIndexOfValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringIndexOf, $Out> {
  StringIndexOfCopyWith<$R, StringIndexOf, $Out> get $asStringIndexOf =>
      $base.as((v, t, t2) => _StringIndexOfCopyWithImpl(v, t, t2));
}

abstract class StringIndexOfCopyWith<$R, $In extends StringIndexOf, $Out>
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
  StringIndexOfCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StringIndexOfCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringIndexOf, $Out>
    implements StringIndexOfCopyWith<$R, StringIndexOf, $Out> {
  _StringIndexOfCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringIndexOf> $mapper =
      StringIndexOfMapper.ensureInitialized();
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
  StringIndexOf $make(CopyWithData data) => StringIndexOf(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringIndexOfCopyWith<$R2, StringIndexOf, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringIndexOfCopyWithImpl($value, $cast, t);
}