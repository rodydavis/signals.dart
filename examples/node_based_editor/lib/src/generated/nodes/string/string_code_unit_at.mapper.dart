// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_code_unit_at.dart';

class StringCodeUnitAtMapper extends SubClassMapperBase<StringCodeUnitAt> {
  StringCodeUnitAtMapper._();

  static StringCodeUnitAtMapper? _instance;
  static StringCodeUnitAtMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringCodeUnitAtMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringCodeUnitAt';

  static int _$id(StringCodeUnitAt v) => v.id;
  static const Field<StringCodeUnitAt, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringCodeUnitAt v) =>
      v.inputs;
  static const Field<StringCodeUnitAt, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringCodeUnitAt v) => v.offset;
  static const Field<StringCodeUnitAt, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringCodeUnitAt v) => v.label;
  static const Field<StringCodeUnitAt, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringCodeUnitAt v) => v.expanded;
  static const Field<StringCodeUnitAt, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringCodeUnitAt v) => v.getNode;
  static const Field<StringCodeUnitAt, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringCodeUnitAt> fields = const {
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
  final dynamic discriminatorValue = 'string_code_unit_at';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringCodeUnitAt _instantiate(DecodingData data) {
    return StringCodeUnitAt(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringCodeUnitAt fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringCodeUnitAt>(map);
  }

  static StringCodeUnitAt fromJson(String json) {
    return ensureInitialized().decodeJson<StringCodeUnitAt>(json);
  }
}

mixin StringCodeUnitAtMappable {
  String toJson() {
    return StringCodeUnitAtMapper.ensureInitialized()
        .encodeJson<StringCodeUnitAt>(this as StringCodeUnitAt);
  }

  Map<String, dynamic> toMap() {
    return StringCodeUnitAtMapper.ensureInitialized()
        .encodeMap<StringCodeUnitAt>(this as StringCodeUnitAt);
  }

  StringCodeUnitAtCopyWith<StringCodeUnitAt, StringCodeUnitAt, StringCodeUnitAt>
      get copyWith => _StringCodeUnitAtCopyWithImpl(
          this as StringCodeUnitAt, $identity, $identity);
  @override
  String toString() {
    return StringCodeUnitAtMapper.ensureInitialized()
        .stringifyValue(this as StringCodeUnitAt);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringCodeUnitAtMapper.ensureInitialized()
                .isValueEqual(this as StringCodeUnitAt, other));
  }

  @override
  int get hashCode {
    return StringCodeUnitAtMapper.ensureInitialized()
        .hashValue(this as StringCodeUnitAt);
  }
}

extension StringCodeUnitAtValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringCodeUnitAt, $Out> {
  StringCodeUnitAtCopyWith<$R, StringCodeUnitAt, $Out>
      get $asStringCodeUnitAt =>
          $base.as((v, t, t2) => _StringCodeUnitAtCopyWithImpl(v, t, t2));
}

abstract class StringCodeUnitAtCopyWith<$R, $In extends StringCodeUnitAt, $Out>
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
  StringCodeUnitAtCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringCodeUnitAtCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringCodeUnitAt, $Out>
    implements StringCodeUnitAtCopyWith<$R, StringCodeUnitAt, $Out> {
  _StringCodeUnitAtCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringCodeUnitAt> $mapper =
      StringCodeUnitAtMapper.ensureInitialized();
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
  StringCodeUnitAt $make(CopyWithData data) => StringCodeUnitAt(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringCodeUnitAtCopyWith<$R2, StringCodeUnitAt, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringCodeUnitAtCopyWithImpl($value, $cast, t);
}
