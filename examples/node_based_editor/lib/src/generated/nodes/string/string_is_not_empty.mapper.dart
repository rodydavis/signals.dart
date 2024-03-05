// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_is_not_empty.dart';

class StringIsNotEmptyMapper extends SubClassMapperBase<StringIsNotEmpty> {
  StringIsNotEmptyMapper._();

  static StringIsNotEmptyMapper? _instance;
  static StringIsNotEmptyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringIsNotEmptyMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringIsNotEmpty';

  static int _$id(StringIsNotEmpty v) => v.id;
  static const Field<StringIsNotEmpty, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringIsNotEmpty v) =>
      v.inputs;
  static const Field<StringIsNotEmpty, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringIsNotEmpty v) => v.offset;
  static const Field<StringIsNotEmpty, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringIsNotEmpty v) => v.label;
  static const Field<StringIsNotEmpty, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringIsNotEmpty v) => v.expanded;
  static const Field<StringIsNotEmpty, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringIsNotEmpty v) => v.getNode;
  static const Field<StringIsNotEmpty, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringIsNotEmpty> fields = const {
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
  final dynamic discriminatorValue = 'string_is_not_empty';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringIsNotEmpty _instantiate(DecodingData data) {
    return StringIsNotEmpty(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringIsNotEmpty fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringIsNotEmpty>(map);
  }

  static StringIsNotEmpty fromJson(String json) {
    return ensureInitialized().decodeJson<StringIsNotEmpty>(json);
  }
}

mixin StringIsNotEmptyMappable {
  String toJson() {
    return StringIsNotEmptyMapper.ensureInitialized()
        .encodeJson<StringIsNotEmpty>(this as StringIsNotEmpty);
  }

  Map<String, dynamic> toMap() {
    return StringIsNotEmptyMapper.ensureInitialized()
        .encodeMap<StringIsNotEmpty>(this as StringIsNotEmpty);
  }

  StringIsNotEmptyCopyWith<StringIsNotEmpty, StringIsNotEmpty, StringIsNotEmpty>
      get copyWith => _StringIsNotEmptyCopyWithImpl(
          this as StringIsNotEmpty, $identity, $identity);
  @override
  String toString() {
    return StringIsNotEmptyMapper.ensureInitialized()
        .stringifyValue(this as StringIsNotEmpty);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringIsNotEmptyMapper.ensureInitialized()
                .isValueEqual(this as StringIsNotEmpty, other));
  }

  @override
  int get hashCode {
    return StringIsNotEmptyMapper.ensureInitialized()
        .hashValue(this as StringIsNotEmpty);
  }
}

extension StringIsNotEmptyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringIsNotEmpty, $Out> {
  StringIsNotEmptyCopyWith<$R, StringIsNotEmpty, $Out>
      get $asStringIsNotEmpty =>
          $base.as((v, t, t2) => _StringIsNotEmptyCopyWithImpl(v, t, t2));
}

abstract class StringIsNotEmptyCopyWith<$R, $In extends StringIsNotEmpty, $Out>
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
  StringIsNotEmptyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringIsNotEmptyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringIsNotEmpty, $Out>
    implements StringIsNotEmptyCopyWith<$R, StringIsNotEmpty, $Out> {
  _StringIsNotEmptyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringIsNotEmpty> $mapper =
      StringIsNotEmptyMapper.ensureInitialized();
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
  StringIsNotEmpty $make(CopyWithData data) => StringIsNotEmpty(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringIsNotEmptyCopyWith<$R2, StringIsNotEmpty, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringIsNotEmptyCopyWithImpl($value, $cast, t);
}
