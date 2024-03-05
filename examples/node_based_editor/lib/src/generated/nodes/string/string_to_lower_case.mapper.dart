// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_to_lower_case.dart';

class StringToLowerCaseMapper extends SubClassMapperBase<StringToLowerCase> {
  StringToLowerCaseMapper._();

  static StringToLowerCaseMapper? _instance;
  static StringToLowerCaseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringToLowerCaseMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringToLowerCase';

  static int _$id(StringToLowerCase v) => v.id;
  static const Field<StringToLowerCase, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringToLowerCase v) =>
      v.inputs;
  static const Field<StringToLowerCase, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringToLowerCase v) => v.offset;
  static const Field<StringToLowerCase, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringToLowerCase v) => v.label;
  static const Field<StringToLowerCase, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringToLowerCase v) => v.expanded;
  static const Field<StringToLowerCase, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringToLowerCase v) => v.getNode;
  static const Field<StringToLowerCase, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringToLowerCase> fields = const {
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
  final dynamic discriminatorValue = 'string_to_lower_case';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringToLowerCase _instantiate(DecodingData data) {
    return StringToLowerCase(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringToLowerCase fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringToLowerCase>(map);
  }

  static StringToLowerCase fromJson(String json) {
    return ensureInitialized().decodeJson<StringToLowerCase>(json);
  }
}

mixin StringToLowerCaseMappable {
  String toJson() {
    return StringToLowerCaseMapper.ensureInitialized()
        .encodeJson<StringToLowerCase>(this as StringToLowerCase);
  }

  Map<String, dynamic> toMap() {
    return StringToLowerCaseMapper.ensureInitialized()
        .encodeMap<StringToLowerCase>(this as StringToLowerCase);
  }

  StringToLowerCaseCopyWith<StringToLowerCase, StringToLowerCase,
          StringToLowerCase>
      get copyWith => _StringToLowerCaseCopyWithImpl(
          this as StringToLowerCase, $identity, $identity);
  @override
  String toString() {
    return StringToLowerCaseMapper.ensureInitialized()
        .stringifyValue(this as StringToLowerCase);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringToLowerCaseMapper.ensureInitialized()
                .isValueEqual(this as StringToLowerCase, other));
  }

  @override
  int get hashCode {
    return StringToLowerCaseMapper.ensureInitialized()
        .hashValue(this as StringToLowerCase);
  }
}

extension StringToLowerCaseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringToLowerCase, $Out> {
  StringToLowerCaseCopyWith<$R, StringToLowerCase, $Out>
      get $asStringToLowerCase =>
          $base.as((v, t, t2) => _StringToLowerCaseCopyWithImpl(v, t, t2));
}

abstract class StringToLowerCaseCopyWith<$R, $In extends StringToLowerCase,
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
  StringToLowerCaseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringToLowerCaseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringToLowerCase, $Out>
    implements StringToLowerCaseCopyWith<$R, StringToLowerCase, $Out> {
  _StringToLowerCaseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringToLowerCase> $mapper =
      StringToLowerCaseMapper.ensureInitialized();
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
  StringToLowerCase $make(CopyWithData data) => StringToLowerCase(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringToLowerCaseCopyWith<$R2, StringToLowerCase, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringToLowerCaseCopyWithImpl($value, $cast, t);
}
