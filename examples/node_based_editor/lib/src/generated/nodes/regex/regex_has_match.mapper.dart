// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'regex_has_match.dart';

class RegexHasMatchMapper extends SubClassMapperBase<RegexHasMatch> {
  RegexHasMatchMapper._();

  static RegexHasMatchMapper? _instance;
  static RegexHasMatchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegexHasMatchMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'RegexHasMatch';

  static int _$id(RegexHasMatch v) => v.id;
  static const Field<RegexHasMatch, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(RegexHasMatch v) => v.inputs;
  static const Field<RegexHasMatch, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(RegexHasMatch v) => v.offset;
  static const Field<RegexHasMatch, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(RegexHasMatch v) => v.label;
  static const Field<RegexHasMatch, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(RegexHasMatch v) => v.expanded;
  static const Field<RegexHasMatch, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(RegexHasMatch v) => v.getNode;
  static const Field<RegexHasMatch, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<RegexHasMatch> fields = const {
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
  final dynamic discriminatorValue = 'regex_has_match';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static RegexHasMatch _instantiate(DecodingData data) {
    return RegexHasMatch(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static RegexHasMatch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegexHasMatch>(map);
  }

  static RegexHasMatch fromJson(String json) {
    return ensureInitialized().decodeJson<RegexHasMatch>(json);
  }
}

mixin RegexHasMatchMappable {
  String toJson() {
    return RegexHasMatchMapper.ensureInitialized()
        .encodeJson<RegexHasMatch>(this as RegexHasMatch);
  }

  Map<String, dynamic> toMap() {
    return RegexHasMatchMapper.ensureInitialized()
        .encodeMap<RegexHasMatch>(this as RegexHasMatch);
  }

  RegexHasMatchCopyWith<RegexHasMatch, RegexHasMatch, RegexHasMatch>
      get copyWith => _RegexHasMatchCopyWithImpl(
          this as RegexHasMatch, $identity, $identity);
  @override
  String toString() {
    return RegexHasMatchMapper.ensureInitialized()
        .stringifyValue(this as RegexHasMatch);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RegexHasMatchMapper.ensureInitialized()
                .isValueEqual(this as RegexHasMatch, other));
  }

  @override
  int get hashCode {
    return RegexHasMatchMapper.ensureInitialized()
        .hashValue(this as RegexHasMatch);
  }
}

extension RegexHasMatchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegexHasMatch, $Out> {
  RegexHasMatchCopyWith<$R, RegexHasMatch, $Out> get $asRegexHasMatch =>
      $base.as((v, t, t2) => _RegexHasMatchCopyWithImpl(v, t, t2));
}

abstract class RegexHasMatchCopyWith<$R, $In extends RegexHasMatch, $Out>
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
  RegexHasMatchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RegexHasMatchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegexHasMatch, $Out>
    implements RegexHasMatchCopyWith<$R, RegexHasMatch, $Out> {
  _RegexHasMatchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegexHasMatch> $mapper =
      RegexHasMatchMapper.ensureInitialized();
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
  RegexHasMatch $make(CopyWithData data) => RegexHasMatch(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  RegexHasMatchCopyWith<$R2, RegexHasMatch, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RegexHasMatchCopyWithImpl($value, $cast, t);
}
