// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_trim.dart';

class StringTrimMapper extends SubClassMapperBase<StringTrim> {
  StringTrimMapper._();

  static StringTrimMapper? _instance;
  static StringTrimMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringTrimMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringTrim';

  static int _$id(StringTrim v) => v.id;
  static const Field<StringTrim, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringTrim v) => v.inputs;
  static const Field<StringTrim, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringTrim v) => v.offset;
  static const Field<StringTrim, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringTrim v) => v.label;
  static const Field<StringTrim, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringTrim v) => v.expanded;
  static const Field<StringTrim, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringTrim v) => v.getNode;
  static const Field<StringTrim, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringTrim> fields = const {
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
  final dynamic discriminatorValue = 'string_trim';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringTrim _instantiate(DecodingData data) {
    return StringTrim(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringTrim fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringTrim>(map);
  }

  static StringTrim fromJson(String json) {
    return ensureInitialized().decodeJson<StringTrim>(json);
  }
}

mixin StringTrimMappable {
  String toJson() {
    return StringTrimMapper.ensureInitialized()
        .encodeJson<StringTrim>(this as StringTrim);
  }

  Map<String, dynamic> toMap() {
    return StringTrimMapper.ensureInitialized()
        .encodeMap<StringTrim>(this as StringTrim);
  }

  StringTrimCopyWith<StringTrim, StringTrim, StringTrim> get copyWith =>
      _StringTrimCopyWithImpl(this as StringTrim, $identity, $identity);
  @override
  String toString() {
    return StringTrimMapper.ensureInitialized()
        .stringifyValue(this as StringTrim);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringTrimMapper.ensureInitialized()
                .isValueEqual(this as StringTrim, other));
  }

  @override
  int get hashCode {
    return StringTrimMapper.ensureInitialized().hashValue(this as StringTrim);
  }
}

extension StringTrimValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringTrim, $Out> {
  StringTrimCopyWith<$R, StringTrim, $Out> get $asStringTrim =>
      $base.as((v, t, t2) => _StringTrimCopyWithImpl(v, t, t2));
}

abstract class StringTrimCopyWith<$R, $In extends StringTrim, $Out>
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
  StringTrimCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StringTrimCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringTrim, $Out>
    implements StringTrimCopyWith<$R, StringTrim, $Out> {
  _StringTrimCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringTrim> $mapper =
      StringTrimMapper.ensureInitialized();
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
  StringTrim $make(CopyWithData data) => StringTrim(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringTrimCopyWith<$R2, StringTrim, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringTrimCopyWithImpl($value, $cast, t);
}
