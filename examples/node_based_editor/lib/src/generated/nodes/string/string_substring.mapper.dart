// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_substring.dart';

class StringSubstringMapper extends SubClassMapperBase<StringSubstring> {
  StringSubstringMapper._();

  static StringSubstringMapper? _instance;
  static StringSubstringMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringSubstringMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringSubstring';

  static int _$id(StringSubstring v) => v.id;
  static const Field<StringSubstring, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringSubstring v) =>
      v.inputs;
  static const Field<StringSubstring, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringSubstring v) => v.offset;
  static const Field<StringSubstring, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringSubstring v) => v.label;
  static const Field<StringSubstring, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringSubstring v) => v.expanded;
  static const Field<StringSubstring, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringSubstring v) => v.getNode;
  static const Field<StringSubstring, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringSubstring> fields = const {
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
  final dynamic discriminatorValue = 'string_substring';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringSubstring _instantiate(DecodingData data) {
    return StringSubstring(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringSubstring fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringSubstring>(map);
  }

  static StringSubstring fromJson(String json) {
    return ensureInitialized().decodeJson<StringSubstring>(json);
  }
}

mixin StringSubstringMappable {
  String toJson() {
    return StringSubstringMapper.ensureInitialized()
        .encodeJson<StringSubstring>(this as StringSubstring);
  }

  Map<String, dynamic> toMap() {
    return StringSubstringMapper.ensureInitialized()
        .encodeMap<StringSubstring>(this as StringSubstring);
  }

  StringSubstringCopyWith<StringSubstring, StringSubstring, StringSubstring>
      get copyWith => _StringSubstringCopyWithImpl(
          this as StringSubstring, $identity, $identity);
  @override
  String toString() {
    return StringSubstringMapper.ensureInitialized()
        .stringifyValue(this as StringSubstring);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringSubstringMapper.ensureInitialized()
                .isValueEqual(this as StringSubstring, other));
  }

  @override
  int get hashCode {
    return StringSubstringMapper.ensureInitialized()
        .hashValue(this as StringSubstring);
  }
}

extension StringSubstringValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringSubstring, $Out> {
  StringSubstringCopyWith<$R, StringSubstring, $Out> get $asStringSubstring =>
      $base.as((v, t, t2) => _StringSubstringCopyWithImpl(v, t, t2));
}

abstract class StringSubstringCopyWith<$R, $In extends StringSubstring, $Out>
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
  StringSubstringCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringSubstringCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringSubstring, $Out>
    implements StringSubstringCopyWith<$R, StringSubstring, $Out> {
  _StringSubstringCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringSubstring> $mapper =
      StringSubstringMapper.ensureInitialized();
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
  StringSubstring $make(CopyWithData data) => StringSubstring(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringSubstringCopyWith<$R2, StringSubstring, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringSubstringCopyWithImpl($value, $cast, t);
}
