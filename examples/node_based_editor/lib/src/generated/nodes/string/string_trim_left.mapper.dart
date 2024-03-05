// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_trim_left.dart';

class StringTrimLeftMapper extends SubClassMapperBase<StringTrimLeft> {
  StringTrimLeftMapper._();

  static StringTrimLeftMapper? _instance;
  static StringTrimLeftMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringTrimLeftMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringTrimLeft';

  static int _$id(StringTrimLeft v) => v.id;
  static const Field<StringTrimLeft, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringTrimLeft v) => v.inputs;
  static const Field<StringTrimLeft, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringTrimLeft v) => v.offset;
  static const Field<StringTrimLeft, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringTrimLeft v) => v.label;
  static const Field<StringTrimLeft, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringTrimLeft v) => v.expanded;
  static const Field<StringTrimLeft, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringTrimLeft v) => v.getNode;
  static const Field<StringTrimLeft, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringTrimLeft> fields = const {
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
  final dynamic discriminatorValue = 'string_trim_left';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringTrimLeft _instantiate(DecodingData data) {
    return StringTrimLeft(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringTrimLeft fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringTrimLeft>(map);
  }

  static StringTrimLeft fromJson(String json) {
    return ensureInitialized().decodeJson<StringTrimLeft>(json);
  }
}

mixin StringTrimLeftMappable {
  String toJson() {
    return StringTrimLeftMapper.ensureInitialized()
        .encodeJson<StringTrimLeft>(this as StringTrimLeft);
  }

  Map<String, dynamic> toMap() {
    return StringTrimLeftMapper.ensureInitialized()
        .encodeMap<StringTrimLeft>(this as StringTrimLeft);
  }

  StringTrimLeftCopyWith<StringTrimLeft, StringTrimLeft, StringTrimLeft>
      get copyWith => _StringTrimLeftCopyWithImpl(
          this as StringTrimLeft, $identity, $identity);
  @override
  String toString() {
    return StringTrimLeftMapper.ensureInitialized()
        .stringifyValue(this as StringTrimLeft);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringTrimLeftMapper.ensureInitialized()
                .isValueEqual(this as StringTrimLeft, other));
  }

  @override
  int get hashCode {
    return StringTrimLeftMapper.ensureInitialized()
        .hashValue(this as StringTrimLeft);
  }
}

extension StringTrimLeftValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringTrimLeft, $Out> {
  StringTrimLeftCopyWith<$R, StringTrimLeft, $Out> get $asStringTrimLeft =>
      $base.as((v, t, t2) => _StringTrimLeftCopyWithImpl(v, t, t2));
}

abstract class StringTrimLeftCopyWith<$R, $In extends StringTrimLeft, $Out>
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
  StringTrimLeftCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringTrimLeftCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringTrimLeft, $Out>
    implements StringTrimLeftCopyWith<$R, StringTrimLeft, $Out> {
  _StringTrimLeftCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringTrimLeft> $mapper =
      StringTrimLeftMapper.ensureInitialized();
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
  StringTrimLeft $make(CopyWithData data) => StringTrimLeft(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringTrimLeftCopyWith<$R2, StringTrimLeft, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringTrimLeftCopyWithImpl($value, $cast, t);
}
