// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_replace_all.dart';

class StringReplaceAllMapper extends SubClassMapperBase<StringReplaceAll> {
  StringReplaceAllMapper._();

  static StringReplaceAllMapper? _instance;
  static StringReplaceAllMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringReplaceAllMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringReplaceAll';

  static int _$id(StringReplaceAll v) => v.id;
  static const Field<StringReplaceAll, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringReplaceAll v) =>
      v.inputs;
  static const Field<StringReplaceAll, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringReplaceAll v) => v.offset;
  static const Field<StringReplaceAll, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringReplaceAll v) => v.label;
  static const Field<StringReplaceAll, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringReplaceAll v) => v.expanded;
  static const Field<StringReplaceAll, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringReplaceAll v) => v.getNode;
  static const Field<StringReplaceAll, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringReplaceAll> fields = const {
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
  final dynamic discriminatorValue = 'string_replace_all';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringReplaceAll _instantiate(DecodingData data) {
    return StringReplaceAll(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringReplaceAll fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringReplaceAll>(map);
  }

  static StringReplaceAll fromJson(String json) {
    return ensureInitialized().decodeJson<StringReplaceAll>(json);
  }
}

mixin StringReplaceAllMappable {
  String toJson() {
    return StringReplaceAllMapper.ensureInitialized()
        .encodeJson<StringReplaceAll>(this as StringReplaceAll);
  }

  Map<String, dynamic> toMap() {
    return StringReplaceAllMapper.ensureInitialized()
        .encodeMap<StringReplaceAll>(this as StringReplaceAll);
  }

  StringReplaceAllCopyWith<StringReplaceAll, StringReplaceAll, StringReplaceAll>
      get copyWith => _StringReplaceAllCopyWithImpl(
          this as StringReplaceAll, $identity, $identity);
  @override
  String toString() {
    return StringReplaceAllMapper.ensureInitialized()
        .stringifyValue(this as StringReplaceAll);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringReplaceAllMapper.ensureInitialized()
                .isValueEqual(this as StringReplaceAll, other));
  }

  @override
  int get hashCode {
    return StringReplaceAllMapper.ensureInitialized()
        .hashValue(this as StringReplaceAll);
  }
}

extension StringReplaceAllValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringReplaceAll, $Out> {
  StringReplaceAllCopyWith<$R, StringReplaceAll, $Out>
      get $asStringReplaceAll =>
          $base.as((v, t, t2) => _StringReplaceAllCopyWithImpl(v, t, t2));
}

abstract class StringReplaceAllCopyWith<$R, $In extends StringReplaceAll, $Out>
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
  StringReplaceAllCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringReplaceAllCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringReplaceAll, $Out>
    implements StringReplaceAllCopyWith<$R, StringReplaceAll, $Out> {
  _StringReplaceAllCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringReplaceAll> $mapper =
      StringReplaceAllMapper.ensureInitialized();
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
  StringReplaceAll $make(CopyWithData data) => StringReplaceAll(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringReplaceAllCopyWith<$R2, StringReplaceAll, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringReplaceAllCopyWithImpl($value, $cast, t);
}
