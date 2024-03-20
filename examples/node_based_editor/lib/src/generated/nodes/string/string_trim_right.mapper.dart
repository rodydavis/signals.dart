// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_trim_right.dart';

class StringTrimRightMapper extends SubClassMapperBase<StringTrimRight> {
  StringTrimRightMapper._();

  static StringTrimRightMapper? _instance;
  static StringTrimRightMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringTrimRightMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringTrimRight';

  static int _$id(StringTrimRight v) => v.id;
  static const Field<StringTrimRight, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringTrimRight v) =>
      v.inputs;
  static const Field<StringTrimRight, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringTrimRight v) => v.offset;
  static const Field<StringTrimRight, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringTrimRight v) => v.label;
  static const Field<StringTrimRight, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringTrimRight v) => v.expanded;
  static const Field<StringTrimRight, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringTrimRight v) => v.getNode;
  static const Field<StringTrimRight, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringTrimRight> fields = const {
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
  final dynamic discriminatorValue = 'string_trim_right';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringTrimRight _instantiate(DecodingData data) {
    return StringTrimRight(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringTrimRight fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringTrimRight>(map);
  }

  static StringTrimRight fromJson(String json) {
    return ensureInitialized().decodeJson<StringTrimRight>(json);
  }
}

mixin StringTrimRightMappable {
  String toJson() {
    return StringTrimRightMapper.ensureInitialized()
        .encodeJson<StringTrimRight>(this as StringTrimRight);
  }

  Map<String, dynamic> toMap() {
    return StringTrimRightMapper.ensureInitialized()
        .encodeMap<StringTrimRight>(this as StringTrimRight);
  }

  StringTrimRightCopyWith<StringTrimRight, StringTrimRight, StringTrimRight>
      get copyWith => _StringTrimRightCopyWithImpl(
          this as StringTrimRight, $identity, $identity);
  @override
  String toString() {
    return StringTrimRightMapper.ensureInitialized()
        .stringifyValue(this as StringTrimRight);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringTrimRightMapper.ensureInitialized()
                .isValueEqual(this as StringTrimRight, other));
  }

  @override
  int get hashCode {
    return StringTrimRightMapper.ensureInitialized()
        .hashValue(this as StringTrimRight);
  }
}

extension StringTrimRightValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringTrimRight, $Out> {
  StringTrimRightCopyWith<$R, StringTrimRight, $Out> get $asStringTrimRight =>
      $base.as((v, t, t2) => _StringTrimRightCopyWithImpl(v, t, t2));
}

abstract class StringTrimRightCopyWith<$R, $In extends StringTrimRight, $Out>
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
  StringTrimRightCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringTrimRightCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringTrimRight, $Out>
    implements StringTrimRightCopyWith<$R, StringTrimRight, $Out> {
  _StringTrimRightCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringTrimRight> $mapper =
      StringTrimRightMapper.ensureInitialized();
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
  StringTrimRight $make(CopyWithData data) => StringTrimRight(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringTrimRightCopyWith<$R2, StringTrimRight, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringTrimRightCopyWithImpl($value, $cast, t);
}
