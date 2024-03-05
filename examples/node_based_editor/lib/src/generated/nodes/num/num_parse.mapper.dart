// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_parse.dart';

class NumParseMapper extends SubClassMapperBase<NumParse> {
  NumParseMapper._();

  static NumParseMapper? _instance;
  static NumParseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumParseMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumParse';

  static int _$id(NumParse v) => v.id;
  static const Field<NumParse, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumParse v) => v.inputs;
  static const Field<NumParse, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumParse v) => v.offset;
  static const Field<NumParse, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumParse v) => v.label;
  static const Field<NumParse, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumParse v) => v.expanded;
  static const Field<NumParse, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumParse v) => v.getNode;
  static const Field<NumParse, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumParse> fields = const {
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
  final dynamic discriminatorValue = 'num_parse';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumParse _instantiate(DecodingData data) {
    return NumParse(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumParse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumParse>(map);
  }

  static NumParse fromJson(String json) {
    return ensureInitialized().decodeJson<NumParse>(json);
  }
}

mixin NumParseMappable {
  String toJson() {
    return NumParseMapper.ensureInitialized()
        .encodeJson<NumParse>(this as NumParse);
  }

  Map<String, dynamic> toMap() {
    return NumParseMapper.ensureInitialized()
        .encodeMap<NumParse>(this as NumParse);
  }

  NumParseCopyWith<NumParse, NumParse, NumParse> get copyWith =>
      _NumParseCopyWithImpl(this as NumParse, $identity, $identity);
  @override
  String toString() {
    return NumParseMapper.ensureInitialized().stringifyValue(this as NumParse);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumParseMapper.ensureInitialized()
                .isValueEqual(this as NumParse, other));
  }

  @override
  int get hashCode {
    return NumParseMapper.ensureInitialized().hashValue(this as NumParse);
  }
}

extension NumParseValueCopy<$R, $Out> on ObjectCopyWith<$R, NumParse, $Out> {
  NumParseCopyWith<$R, NumParse, $Out> get $asNumParse =>
      $base.as((v, t, t2) => _NumParseCopyWithImpl(v, t, t2));
}

abstract class NumParseCopyWith<$R, $In extends NumParse, $Out>
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
  NumParseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumParseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumParse, $Out>
    implements NumParseCopyWith<$R, NumParse, $Out> {
  _NumParseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumParse> $mapper =
      NumParseMapper.ensureInitialized();
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
  NumParse $make(CopyWithData data) => NumParse(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumParseCopyWith<$R2, NumParse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumParseCopyWithImpl($value, $cast, t);
}
