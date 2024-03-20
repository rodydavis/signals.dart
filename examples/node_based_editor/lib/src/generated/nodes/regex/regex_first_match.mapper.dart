// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'regex_first_match.dart';

class RegexFirstMatchMapper extends SubClassMapperBase<RegexFirstMatch> {
  RegexFirstMatchMapper._();

  static RegexFirstMatchMapper? _instance;
  static RegexFirstMatchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegexFirstMatchMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'RegexFirstMatch';

  static int _$id(RegexFirstMatch v) => v.id;
  static const Field<RegexFirstMatch, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(RegexFirstMatch v) =>
      v.inputs;
  static const Field<RegexFirstMatch, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(RegexFirstMatch v) => v.offset;
  static const Field<RegexFirstMatch, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(RegexFirstMatch v) => v.label;
  static const Field<RegexFirstMatch, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(RegexFirstMatch v) => v.expanded;
  static const Field<RegexFirstMatch, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(RegexFirstMatch v) => v.getNode;
  static const Field<RegexFirstMatch, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<RegexFirstMatch> fields = const {
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
  final dynamic discriminatorValue = 'regex_first_match';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static RegexFirstMatch _instantiate(DecodingData data) {
    return RegexFirstMatch(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static RegexFirstMatch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegexFirstMatch>(map);
  }

  static RegexFirstMatch fromJson(String json) {
    return ensureInitialized().decodeJson<RegexFirstMatch>(json);
  }
}

mixin RegexFirstMatchMappable {
  String toJson() {
    return RegexFirstMatchMapper.ensureInitialized()
        .encodeJson<RegexFirstMatch>(this as RegexFirstMatch);
  }

  Map<String, dynamic> toMap() {
    return RegexFirstMatchMapper.ensureInitialized()
        .encodeMap<RegexFirstMatch>(this as RegexFirstMatch);
  }

  RegexFirstMatchCopyWith<RegexFirstMatch, RegexFirstMatch, RegexFirstMatch>
      get copyWith => _RegexFirstMatchCopyWithImpl(
          this as RegexFirstMatch, $identity, $identity);
  @override
  String toString() {
    return RegexFirstMatchMapper.ensureInitialized()
        .stringifyValue(this as RegexFirstMatch);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RegexFirstMatchMapper.ensureInitialized()
                .isValueEqual(this as RegexFirstMatch, other));
  }

  @override
  int get hashCode {
    return RegexFirstMatchMapper.ensureInitialized()
        .hashValue(this as RegexFirstMatch);
  }
}

extension RegexFirstMatchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegexFirstMatch, $Out> {
  RegexFirstMatchCopyWith<$R, RegexFirstMatch, $Out> get $asRegexFirstMatch =>
      $base.as((v, t, t2) => _RegexFirstMatchCopyWithImpl(v, t, t2));
}

abstract class RegexFirstMatchCopyWith<$R, $In extends RegexFirstMatch, $Out>
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
  RegexFirstMatchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RegexFirstMatchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegexFirstMatch, $Out>
    implements RegexFirstMatchCopyWith<$R, RegexFirstMatch, $Out> {
  _RegexFirstMatchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegexFirstMatch> $mapper =
      RegexFirstMatchMapper.ensureInitialized();
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
  RegexFirstMatch $make(CopyWithData data) => RegexFirstMatch(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  RegexFirstMatchCopyWith<$R2, RegexFirstMatch, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RegexFirstMatchCopyWithImpl($value, $cast, t);
}
