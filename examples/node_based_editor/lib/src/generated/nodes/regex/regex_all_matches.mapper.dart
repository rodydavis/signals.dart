// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'regex_all_matches.dart';

class RegexAllMatchesMapper extends SubClassMapperBase<RegexAllMatches> {
  RegexAllMatchesMapper._();

  static RegexAllMatchesMapper? _instance;
  static RegexAllMatchesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegexAllMatchesMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'RegexAllMatches';

  static int _$id(RegexAllMatches v) => v.id;
  static const Field<RegexAllMatches, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(RegexAllMatches v) =>
      v.inputs;
  static const Field<RegexAllMatches, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(RegexAllMatches v) => v.offset;
  static const Field<RegexAllMatches, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(RegexAllMatches v) => v.label;
  static const Field<RegexAllMatches, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(RegexAllMatches v) => v.expanded;
  static const Field<RegexAllMatches, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(RegexAllMatches v) => v.getNode;
  static const Field<RegexAllMatches, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<RegexAllMatches> fields = const {
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
  final dynamic discriminatorValue = 'regex_all_matches';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static RegexAllMatches _instantiate(DecodingData data) {
    return RegexAllMatches(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static RegexAllMatches fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegexAllMatches>(map);
  }

  static RegexAllMatches fromJson(String json) {
    return ensureInitialized().decodeJson<RegexAllMatches>(json);
  }
}

mixin RegexAllMatchesMappable {
  String toJson() {
    return RegexAllMatchesMapper.ensureInitialized()
        .encodeJson<RegexAllMatches>(this as RegexAllMatches);
  }

  Map<String, dynamic> toMap() {
    return RegexAllMatchesMapper.ensureInitialized()
        .encodeMap<RegexAllMatches>(this as RegexAllMatches);
  }

  RegexAllMatchesCopyWith<RegexAllMatches, RegexAllMatches, RegexAllMatches>
      get copyWith => _RegexAllMatchesCopyWithImpl(
          this as RegexAllMatches, $identity, $identity);
  @override
  String toString() {
    return RegexAllMatchesMapper.ensureInitialized()
        .stringifyValue(this as RegexAllMatches);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RegexAllMatchesMapper.ensureInitialized()
                .isValueEqual(this as RegexAllMatches, other));
  }

  @override
  int get hashCode {
    return RegexAllMatchesMapper.ensureInitialized()
        .hashValue(this as RegexAllMatches);
  }
}

extension RegexAllMatchesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegexAllMatches, $Out> {
  RegexAllMatchesCopyWith<$R, RegexAllMatches, $Out> get $asRegexAllMatches =>
      $base.as((v, t, t2) => _RegexAllMatchesCopyWithImpl(v, t, t2));
}

abstract class RegexAllMatchesCopyWith<$R, $In extends RegexAllMatches, $Out>
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
  RegexAllMatchesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RegexAllMatchesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegexAllMatches, $Out>
    implements RegexAllMatchesCopyWith<$R, RegexAllMatches, $Out> {
  _RegexAllMatchesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegexAllMatches> $mapper =
      RegexAllMatchesMapper.ensureInitialized();
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
  RegexAllMatches $make(CopyWithData data) => RegexAllMatches(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  RegexAllMatchesCopyWith<$R2, RegexAllMatches, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RegexAllMatchesCopyWithImpl($value, $cast, t);
}
