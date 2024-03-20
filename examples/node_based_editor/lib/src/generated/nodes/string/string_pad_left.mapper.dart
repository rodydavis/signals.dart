// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_pad_left.dart';

class StringPadLeftMapper extends SubClassMapperBase<StringPadLeft> {
  StringPadLeftMapper._();

  static StringPadLeftMapper? _instance;
  static StringPadLeftMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringPadLeftMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringPadLeft';

  static int _$id(StringPadLeft v) => v.id;
  static const Field<StringPadLeft, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringPadLeft v) => v.inputs;
  static const Field<StringPadLeft, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringPadLeft v) => v.offset;
  static const Field<StringPadLeft, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringPadLeft v) => v.label;
  static const Field<StringPadLeft, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringPadLeft v) => v.expanded;
  static const Field<StringPadLeft, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringPadLeft v) => v.getNode;
  static const Field<StringPadLeft, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringPadLeft> fields = const {
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
  final dynamic discriminatorValue = 'string_pad_left';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringPadLeft _instantiate(DecodingData data) {
    return StringPadLeft(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringPadLeft fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringPadLeft>(map);
  }

  static StringPadLeft fromJson(String json) {
    return ensureInitialized().decodeJson<StringPadLeft>(json);
  }
}

mixin StringPadLeftMappable {
  String toJson() {
    return StringPadLeftMapper.ensureInitialized()
        .encodeJson<StringPadLeft>(this as StringPadLeft);
  }

  Map<String, dynamic> toMap() {
    return StringPadLeftMapper.ensureInitialized()
        .encodeMap<StringPadLeft>(this as StringPadLeft);
  }

  StringPadLeftCopyWith<StringPadLeft, StringPadLeft, StringPadLeft>
      get copyWith => _StringPadLeftCopyWithImpl(
          this as StringPadLeft, $identity, $identity);
  @override
  String toString() {
    return StringPadLeftMapper.ensureInitialized()
        .stringifyValue(this as StringPadLeft);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringPadLeftMapper.ensureInitialized()
                .isValueEqual(this as StringPadLeft, other));
  }

  @override
  int get hashCode {
    return StringPadLeftMapper.ensureInitialized()
        .hashValue(this as StringPadLeft);
  }
}

extension StringPadLeftValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringPadLeft, $Out> {
  StringPadLeftCopyWith<$R, StringPadLeft, $Out> get $asStringPadLeft =>
      $base.as((v, t, t2) => _StringPadLeftCopyWithImpl(v, t, t2));
}

abstract class StringPadLeftCopyWith<$R, $In extends StringPadLeft, $Out>
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
  StringPadLeftCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StringPadLeftCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringPadLeft, $Out>
    implements StringPadLeftCopyWith<$R, StringPadLeft, $Out> {
  _StringPadLeftCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringPadLeft> $mapper =
      StringPadLeftMapper.ensureInitialized();
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
  StringPadLeft $make(CopyWithData data) => StringPadLeft(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringPadLeftCopyWith<$R2, StringPadLeft, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringPadLeftCopyWithImpl($value, $cast, t);
}
