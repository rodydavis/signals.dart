// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_is_empty.dart';

class StringIsEmptyMapper extends SubClassMapperBase<StringIsEmpty> {
  StringIsEmptyMapper._();

  static StringIsEmptyMapper? _instance;
  static StringIsEmptyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringIsEmptyMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringIsEmpty';

  static int _$id(StringIsEmpty v) => v.id;
  static const Field<StringIsEmpty, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringIsEmpty v) => v.inputs;
  static const Field<StringIsEmpty, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringIsEmpty v) => v.offset;
  static const Field<StringIsEmpty, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringIsEmpty v) => v.label;
  static const Field<StringIsEmpty, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringIsEmpty v) => v.expanded;
  static const Field<StringIsEmpty, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringIsEmpty v) => v.getNode;
  static const Field<StringIsEmpty, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringIsEmpty> fields = const {
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
  final dynamic discriminatorValue = 'string_is_empty';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringIsEmpty _instantiate(DecodingData data) {
    return StringIsEmpty(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringIsEmpty fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringIsEmpty>(map);
  }

  static StringIsEmpty fromJson(String json) {
    return ensureInitialized().decodeJson<StringIsEmpty>(json);
  }
}

mixin StringIsEmptyMappable {
  String toJson() {
    return StringIsEmptyMapper.ensureInitialized()
        .encodeJson<StringIsEmpty>(this as StringIsEmpty);
  }

  Map<String, dynamic> toMap() {
    return StringIsEmptyMapper.ensureInitialized()
        .encodeMap<StringIsEmpty>(this as StringIsEmpty);
  }

  StringIsEmptyCopyWith<StringIsEmpty, StringIsEmpty, StringIsEmpty>
      get copyWith => _StringIsEmptyCopyWithImpl(
          this as StringIsEmpty, $identity, $identity);
  @override
  String toString() {
    return StringIsEmptyMapper.ensureInitialized()
        .stringifyValue(this as StringIsEmpty);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringIsEmptyMapper.ensureInitialized()
                .isValueEqual(this as StringIsEmpty, other));
  }

  @override
  int get hashCode {
    return StringIsEmptyMapper.ensureInitialized()
        .hashValue(this as StringIsEmpty);
  }
}

extension StringIsEmptyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringIsEmpty, $Out> {
  StringIsEmptyCopyWith<$R, StringIsEmpty, $Out> get $asStringIsEmpty =>
      $base.as((v, t, t2) => _StringIsEmptyCopyWithImpl(v, t, t2));
}

abstract class StringIsEmptyCopyWith<$R, $In extends StringIsEmpty, $Out>
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
  StringIsEmptyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StringIsEmptyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringIsEmpty, $Out>
    implements StringIsEmptyCopyWith<$R, StringIsEmpty, $Out> {
  _StringIsEmptyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringIsEmpty> $mapper =
      StringIsEmptyMapper.ensureInitialized();
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
  StringIsEmpty $make(CopyWithData data) => StringIsEmpty(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringIsEmptyCopyWith<$R2, StringIsEmpty, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringIsEmptyCopyWithImpl($value, $cast, t);
}
