// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_try_parse.dart';

class NumTryParseMapper extends SubClassMapperBase<NumTryParse> {
  NumTryParseMapper._();

  static NumTryParseMapper? _instance;
  static NumTryParseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumTryParseMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumTryParse';

  static int _$id(NumTryParse v) => v.id;
  static const Field<NumTryParse, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumTryParse v) => v.inputs;
  static const Field<NumTryParse, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumTryParse v) => v.offset;
  static const Field<NumTryParse, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumTryParse v) => v.label;
  static const Field<NumTryParse, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumTryParse v) => v.expanded;
  static const Field<NumTryParse, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumTryParse v) => v.getNode;
  static const Field<NumTryParse, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumTryParse> fields = const {
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
  final dynamic discriminatorValue = 'num_try_parse';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumTryParse _instantiate(DecodingData data) {
    return NumTryParse(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumTryParse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumTryParse>(map);
  }

  static NumTryParse fromJson(String json) {
    return ensureInitialized().decodeJson<NumTryParse>(json);
  }
}

mixin NumTryParseMappable {
  String toJson() {
    return NumTryParseMapper.ensureInitialized()
        .encodeJson<NumTryParse>(this as NumTryParse);
  }

  Map<String, dynamic> toMap() {
    return NumTryParseMapper.ensureInitialized()
        .encodeMap<NumTryParse>(this as NumTryParse);
  }

  NumTryParseCopyWith<NumTryParse, NumTryParse, NumTryParse> get copyWith =>
      _NumTryParseCopyWithImpl(this as NumTryParse, $identity, $identity);
  @override
  String toString() {
    return NumTryParseMapper.ensureInitialized()
        .stringifyValue(this as NumTryParse);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumTryParseMapper.ensureInitialized()
                .isValueEqual(this as NumTryParse, other));
  }

  @override
  int get hashCode {
    return NumTryParseMapper.ensureInitialized().hashValue(this as NumTryParse);
  }
}

extension NumTryParseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumTryParse, $Out> {
  NumTryParseCopyWith<$R, NumTryParse, $Out> get $asNumTryParse =>
      $base.as((v, t, t2) => _NumTryParseCopyWithImpl(v, t, t2));
}

abstract class NumTryParseCopyWith<$R, $In extends NumTryParse, $Out>
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
  NumTryParseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumTryParseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumTryParse, $Out>
    implements NumTryParseCopyWith<$R, NumTryParse, $Out> {
  _NumTryParseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumTryParse> $mapper =
      NumTryParseMapper.ensureInitialized();
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
  NumTryParse $make(CopyWithData data) => NumTryParse(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumTryParseCopyWith<$R2, NumTryParse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumTryParseCopyWithImpl($value, $cast, t);
}
