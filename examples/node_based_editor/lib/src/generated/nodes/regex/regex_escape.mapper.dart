// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'regex_escape.dart';

class RegexEscapeMapper extends SubClassMapperBase<RegexEscape> {
  RegexEscapeMapper._();

  static RegexEscapeMapper? _instance;
  static RegexEscapeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegexEscapeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'RegexEscape';

  static int _$id(RegexEscape v) => v.id;
  static const Field<RegexEscape, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(RegexEscape v) => v.inputs;
  static const Field<RegexEscape, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(RegexEscape v) => v.offset;
  static const Field<RegexEscape, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(RegexEscape v) => v.label;
  static const Field<RegexEscape, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(RegexEscape v) => v.expanded;
  static const Field<RegexEscape, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(RegexEscape v) => v.getNode;
  static const Field<RegexEscape, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<RegexEscape> fields = const {
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
  final dynamic discriminatorValue = 'regex_escape';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static RegexEscape _instantiate(DecodingData data) {
    return RegexEscape(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static RegexEscape fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegexEscape>(map);
  }

  static RegexEscape fromJson(String json) {
    return ensureInitialized().decodeJson<RegexEscape>(json);
  }
}

mixin RegexEscapeMappable {
  String toJson() {
    return RegexEscapeMapper.ensureInitialized()
        .encodeJson<RegexEscape>(this as RegexEscape);
  }

  Map<String, dynamic> toMap() {
    return RegexEscapeMapper.ensureInitialized()
        .encodeMap<RegexEscape>(this as RegexEscape);
  }

  RegexEscapeCopyWith<RegexEscape, RegexEscape, RegexEscape> get copyWith =>
      _RegexEscapeCopyWithImpl(this as RegexEscape, $identity, $identity);
  @override
  String toString() {
    return RegexEscapeMapper.ensureInitialized()
        .stringifyValue(this as RegexEscape);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RegexEscapeMapper.ensureInitialized()
                .isValueEqual(this as RegexEscape, other));
  }

  @override
  int get hashCode {
    return RegexEscapeMapper.ensureInitialized().hashValue(this as RegexEscape);
  }
}

extension RegexEscapeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegexEscape, $Out> {
  RegexEscapeCopyWith<$R, RegexEscape, $Out> get $asRegexEscape =>
      $base.as((v, t, t2) => _RegexEscapeCopyWithImpl(v, t, t2));
}

abstract class RegexEscapeCopyWith<$R, $In extends RegexEscape, $Out>
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
  RegexEscapeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RegexEscapeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegexEscape, $Out>
    implements RegexEscapeCopyWith<$R, RegexEscape, $Out> {
  _RegexEscapeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegexEscape> $mapper =
      RegexEscapeMapper.ensureInitialized();
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
  RegexEscape $make(CopyWithData data) => RegexEscape(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  RegexEscapeCopyWith<$R2, RegexEscape, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RegexEscapeCopyWithImpl($value, $cast, t);
}
