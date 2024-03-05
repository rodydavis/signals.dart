// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_to_upper_case.dart';

class StringToUpperCaseMapper extends SubClassMapperBase<StringToUpperCase> {
  StringToUpperCaseMapper._();

  static StringToUpperCaseMapper? _instance;
  static StringToUpperCaseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringToUpperCaseMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringToUpperCase';

  static int _$id(StringToUpperCase v) => v.id;
  static const Field<StringToUpperCase, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringToUpperCase v) =>
      v.inputs;
  static const Field<StringToUpperCase, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringToUpperCase v) => v.offset;
  static const Field<StringToUpperCase, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringToUpperCase v) => v.label;
  static const Field<StringToUpperCase, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringToUpperCase v) => v.expanded;
  static const Field<StringToUpperCase, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringToUpperCase v) => v.getNode;
  static const Field<StringToUpperCase, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringToUpperCase> fields = const {
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
  final dynamic discriminatorValue = 'string_to_upper_case';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringToUpperCase _instantiate(DecodingData data) {
    return StringToUpperCase(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringToUpperCase fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringToUpperCase>(map);
  }

  static StringToUpperCase fromJson(String json) {
    return ensureInitialized().decodeJson<StringToUpperCase>(json);
  }
}

mixin StringToUpperCaseMappable {
  String toJson() {
    return StringToUpperCaseMapper.ensureInitialized()
        .encodeJson<StringToUpperCase>(this as StringToUpperCase);
  }

  Map<String, dynamic> toMap() {
    return StringToUpperCaseMapper.ensureInitialized()
        .encodeMap<StringToUpperCase>(this as StringToUpperCase);
  }

  StringToUpperCaseCopyWith<StringToUpperCase, StringToUpperCase,
          StringToUpperCase>
      get copyWith => _StringToUpperCaseCopyWithImpl(
          this as StringToUpperCase, $identity, $identity);
  @override
  String toString() {
    return StringToUpperCaseMapper.ensureInitialized()
        .stringifyValue(this as StringToUpperCase);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringToUpperCaseMapper.ensureInitialized()
                .isValueEqual(this as StringToUpperCase, other));
  }

  @override
  int get hashCode {
    return StringToUpperCaseMapper.ensureInitialized()
        .hashValue(this as StringToUpperCase);
  }
}

extension StringToUpperCaseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringToUpperCase, $Out> {
  StringToUpperCaseCopyWith<$R, StringToUpperCase, $Out>
      get $asStringToUpperCase =>
          $base.as((v, t, t2) => _StringToUpperCaseCopyWithImpl(v, t, t2));
}

abstract class StringToUpperCaseCopyWith<$R, $In extends StringToUpperCase,
    $Out> implements BaseNodeCopyWith<$R, $In, $Out> {
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
  StringToUpperCaseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringToUpperCaseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringToUpperCase, $Out>
    implements StringToUpperCaseCopyWith<$R, StringToUpperCase, $Out> {
  _StringToUpperCaseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringToUpperCase> $mapper =
      StringToUpperCaseMapper.ensureInitialized();
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
  StringToUpperCase $make(CopyWithData data) => StringToUpperCase(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringToUpperCaseCopyWith<$R2, StringToUpperCase, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringToUpperCaseCopyWithImpl($value, $cast, t);
}
