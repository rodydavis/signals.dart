// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_pad_right.dart';

class StringPadRightMapper extends SubClassMapperBase<StringPadRight> {
  StringPadRightMapper._();

  static StringPadRightMapper? _instance;
  static StringPadRightMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringPadRightMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringPadRight';

  static int _$id(StringPadRight v) => v.id;
  static const Field<StringPadRight, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringPadRight v) => v.inputs;
  static const Field<StringPadRight, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringPadRight v) => v.offset;
  static const Field<StringPadRight, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringPadRight v) => v.label;
  static const Field<StringPadRight, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringPadRight v) => v.expanded;
  static const Field<StringPadRight, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringPadRight v) => v.getNode;
  static const Field<StringPadRight, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringPadRight> fields = const {
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
  final dynamic discriminatorValue = 'string_pad_right';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringPadRight _instantiate(DecodingData data) {
    return StringPadRight(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringPadRight fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringPadRight>(map);
  }

  static StringPadRight fromJson(String json) {
    return ensureInitialized().decodeJson<StringPadRight>(json);
  }
}

mixin StringPadRightMappable {
  String toJson() {
    return StringPadRightMapper.ensureInitialized()
        .encodeJson<StringPadRight>(this as StringPadRight);
  }

  Map<String, dynamic> toMap() {
    return StringPadRightMapper.ensureInitialized()
        .encodeMap<StringPadRight>(this as StringPadRight);
  }

  StringPadRightCopyWith<StringPadRight, StringPadRight, StringPadRight>
      get copyWith => _StringPadRightCopyWithImpl(
          this as StringPadRight, $identity, $identity);
  @override
  String toString() {
    return StringPadRightMapper.ensureInitialized()
        .stringifyValue(this as StringPadRight);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringPadRightMapper.ensureInitialized()
                .isValueEqual(this as StringPadRight, other));
  }

  @override
  int get hashCode {
    return StringPadRightMapper.ensureInitialized()
        .hashValue(this as StringPadRight);
  }
}

extension StringPadRightValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringPadRight, $Out> {
  StringPadRightCopyWith<$R, StringPadRight, $Out> get $asStringPadRight =>
      $base.as((v, t, t2) => _StringPadRightCopyWithImpl(v, t, t2));
}

abstract class StringPadRightCopyWith<$R, $In extends StringPadRight, $Out>
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
  StringPadRightCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringPadRightCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringPadRight, $Out>
    implements StringPadRightCopyWith<$R, StringPadRight, $Out> {
  _StringPadRightCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringPadRight> $mapper =
      StringPadRightMapper.ensureInitialized();
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
  StringPadRight $make(CopyWithData data) => StringPadRight(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringPadRightCopyWith<$R2, StringPadRight, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringPadRightCopyWithImpl($value, $cast, t);
}
