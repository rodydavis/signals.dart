// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_split.dart';

class StringSplitMapper extends SubClassMapperBase<StringSplit> {
  StringSplitMapper._();

  static StringSplitMapper? _instance;
  static StringSplitMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringSplitMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringSplit';

  static int _$id(StringSplit v) => v.id;
  static const Field<StringSplit, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringSplit v) => v.inputs;
  static const Field<StringSplit, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringSplit v) => v.offset;
  static const Field<StringSplit, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringSplit v) => v.label;
  static const Field<StringSplit, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringSplit v) => v.expanded;
  static const Field<StringSplit, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringSplit v) => v.getNode;
  static const Field<StringSplit, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringSplit> fields = const {
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
  final dynamic discriminatorValue = 'string_split';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringSplit _instantiate(DecodingData data) {
    return StringSplit(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringSplit fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringSplit>(map);
  }

  static StringSplit fromJson(String json) {
    return ensureInitialized().decodeJson<StringSplit>(json);
  }
}

mixin StringSplitMappable {
  String toJson() {
    return StringSplitMapper.ensureInitialized()
        .encodeJson<StringSplit>(this as StringSplit);
  }

  Map<String, dynamic> toMap() {
    return StringSplitMapper.ensureInitialized()
        .encodeMap<StringSplit>(this as StringSplit);
  }

  StringSplitCopyWith<StringSplit, StringSplit, StringSplit> get copyWith =>
      _StringSplitCopyWithImpl(this as StringSplit, $identity, $identity);
  @override
  String toString() {
    return StringSplitMapper.ensureInitialized()
        .stringifyValue(this as StringSplit);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringSplitMapper.ensureInitialized()
                .isValueEqual(this as StringSplit, other));
  }

  @override
  int get hashCode {
    return StringSplitMapper.ensureInitialized().hashValue(this as StringSplit);
  }
}

extension StringSplitValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringSplit, $Out> {
  StringSplitCopyWith<$R, StringSplit, $Out> get $asStringSplit =>
      $base.as((v, t, t2) => _StringSplitCopyWithImpl(v, t, t2));
}

abstract class StringSplitCopyWith<$R, $In extends StringSplit, $Out>
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
  StringSplitCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StringSplitCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringSplit, $Out>
    implements StringSplitCopyWith<$R, StringSplit, $Out> {
  _StringSplitCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringSplit> $mapper =
      StringSplitMapper.ensureInitialized();
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
  StringSplit $make(CopyWithData data) => StringSplit(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringSplitCopyWith<$R2, StringSplit, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringSplitCopyWithImpl($value, $cast, t);
}
