// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_index.dart';

class StringIndexMapper extends SubClassMapperBase<StringIndex> {
  StringIndexMapper._();

  static StringIndexMapper? _instance;
  static StringIndexMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringIndexMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringIndex';

  static int _$id(StringIndex v) => v.id;
  static const Field<StringIndex, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringIndex v) => v.inputs;
  static const Field<StringIndex, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringIndex v) => v.offset;
  static const Field<StringIndex, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringIndex v) => v.label;
  static const Field<StringIndex, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringIndex v) => v.expanded;
  static const Field<StringIndex, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringIndex v) => v.getNode;
  static const Field<StringIndex, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringIndex> fields = const {
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
  final dynamic discriminatorValue = 'string_index';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringIndex _instantiate(DecodingData data) {
    return StringIndex(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringIndex fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringIndex>(map);
  }

  static StringIndex fromJson(String json) {
    return ensureInitialized().decodeJson<StringIndex>(json);
  }
}

mixin StringIndexMappable {
  String toJson() {
    return StringIndexMapper.ensureInitialized()
        .encodeJson<StringIndex>(this as StringIndex);
  }

  Map<String, dynamic> toMap() {
    return StringIndexMapper.ensureInitialized()
        .encodeMap<StringIndex>(this as StringIndex);
  }

  StringIndexCopyWith<StringIndex, StringIndex, StringIndex> get copyWith =>
      _StringIndexCopyWithImpl(this as StringIndex, $identity, $identity);
  @override
  String toString() {
    return StringIndexMapper.ensureInitialized()
        .stringifyValue(this as StringIndex);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringIndexMapper.ensureInitialized()
                .isValueEqual(this as StringIndex, other));
  }

  @override
  int get hashCode {
    return StringIndexMapper.ensureInitialized().hashValue(this as StringIndex);
  }
}

extension StringIndexValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringIndex, $Out> {
  StringIndexCopyWith<$R, StringIndex, $Out> get $asStringIndex =>
      $base.as((v, t, t2) => _StringIndexCopyWithImpl(v, t, t2));
}

abstract class StringIndexCopyWith<$R, $In extends StringIndex, $Out>
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
  StringIndexCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StringIndexCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringIndex, $Out>
    implements StringIndexCopyWith<$R, StringIndex, $Out> {
  _StringIndexCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringIndex> $mapper =
      StringIndexMapper.ensureInitialized();
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
  StringIndex $make(CopyWithData data) => StringIndex(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringIndexCopyWith<$R2, StringIndex, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringIndexCopyWithImpl($value, $cast, t);
}
