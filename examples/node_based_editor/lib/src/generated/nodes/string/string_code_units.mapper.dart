// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_code_units.dart';

class StringCodeUnitsMapper extends SubClassMapperBase<StringCodeUnits> {
  StringCodeUnitsMapper._();

  static StringCodeUnitsMapper? _instance;
  static StringCodeUnitsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringCodeUnitsMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringCodeUnits';

  static int _$id(StringCodeUnits v) => v.id;
  static const Field<StringCodeUnits, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringCodeUnits v) =>
      v.inputs;
  static const Field<StringCodeUnits, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringCodeUnits v) => v.offset;
  static const Field<StringCodeUnits, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringCodeUnits v) => v.label;
  static const Field<StringCodeUnits, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringCodeUnits v) => v.expanded;
  static const Field<StringCodeUnits, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringCodeUnits v) => v.getNode;
  static const Field<StringCodeUnits, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringCodeUnits> fields = const {
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
  final dynamic discriminatorValue = 'string_code_units';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringCodeUnits _instantiate(DecodingData data) {
    return StringCodeUnits(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringCodeUnits fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringCodeUnits>(map);
  }

  static StringCodeUnits fromJson(String json) {
    return ensureInitialized().decodeJson<StringCodeUnits>(json);
  }
}

mixin StringCodeUnitsMappable {
  String toJson() {
    return StringCodeUnitsMapper.ensureInitialized()
        .encodeJson<StringCodeUnits>(this as StringCodeUnits);
  }

  Map<String, dynamic> toMap() {
    return StringCodeUnitsMapper.ensureInitialized()
        .encodeMap<StringCodeUnits>(this as StringCodeUnits);
  }

  StringCodeUnitsCopyWith<StringCodeUnits, StringCodeUnits, StringCodeUnits>
      get copyWith => _StringCodeUnitsCopyWithImpl(
          this as StringCodeUnits, $identity, $identity);
  @override
  String toString() {
    return StringCodeUnitsMapper.ensureInitialized()
        .stringifyValue(this as StringCodeUnits);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringCodeUnitsMapper.ensureInitialized()
                .isValueEqual(this as StringCodeUnits, other));
  }

  @override
  int get hashCode {
    return StringCodeUnitsMapper.ensureInitialized()
        .hashValue(this as StringCodeUnits);
  }
}

extension StringCodeUnitsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringCodeUnits, $Out> {
  StringCodeUnitsCopyWith<$R, StringCodeUnits, $Out> get $asStringCodeUnits =>
      $base.as((v, t, t2) => _StringCodeUnitsCopyWithImpl(v, t, t2));
}

abstract class StringCodeUnitsCopyWith<$R, $In extends StringCodeUnits, $Out>
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
  StringCodeUnitsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringCodeUnitsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringCodeUnits, $Out>
    implements StringCodeUnitsCopyWith<$R, StringCodeUnits, $Out> {
  _StringCodeUnitsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringCodeUnits> $mapper =
      StringCodeUnitsMapper.ensureInitialized();
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
  StringCodeUnits $make(CopyWithData data) => StringCodeUnits(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringCodeUnitsCopyWith<$R2, StringCodeUnits, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringCodeUnitsCopyWithImpl($value, $cast, t);
}
