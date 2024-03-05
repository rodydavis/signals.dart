// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_parse.dart';

class DoubleParseMapper extends SubClassMapperBase<DoubleParse> {
  DoubleParseMapper._();

  static DoubleParseMapper? _instance;
  static DoubleParseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleParseMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleParse';

  static int _$id(DoubleParse v) => v.id;
  static const Field<DoubleParse, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleParse v) => v.inputs;
  static const Field<DoubleParse, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleParse v) => v.offset;
  static const Field<DoubleParse, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleParse v) => v.label;
  static const Field<DoubleParse, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleParse v) => v.expanded;
  static const Field<DoubleParse, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleParse v) => v.getNode;
  static const Field<DoubleParse, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleParse> fields = const {
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
  final dynamic discriminatorValue = 'double_parse';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleParse _instantiate(DecodingData data) {
    return DoubleParse(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleParse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleParse>(map);
  }

  static DoubleParse fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleParse>(json);
  }
}

mixin DoubleParseMappable {
  String toJson() {
    return DoubleParseMapper.ensureInitialized()
        .encodeJson<DoubleParse>(this as DoubleParse);
  }

  Map<String, dynamic> toMap() {
    return DoubleParseMapper.ensureInitialized()
        .encodeMap<DoubleParse>(this as DoubleParse);
  }

  DoubleParseCopyWith<DoubleParse, DoubleParse, DoubleParse> get copyWith =>
      _DoubleParseCopyWithImpl(this as DoubleParse, $identity, $identity);
  @override
  String toString() {
    return DoubleParseMapper.ensureInitialized()
        .stringifyValue(this as DoubleParse);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleParseMapper.ensureInitialized()
                .isValueEqual(this as DoubleParse, other));
  }

  @override
  int get hashCode {
    return DoubleParseMapper.ensureInitialized().hashValue(this as DoubleParse);
  }
}

extension DoubleParseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleParse, $Out> {
  DoubleParseCopyWith<$R, DoubleParse, $Out> get $asDoubleParse =>
      $base.as((v, t, t2) => _DoubleParseCopyWithImpl(v, t, t2));
}

abstract class DoubleParseCopyWith<$R, $In extends DoubleParse, $Out>
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
  DoubleParseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleParseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleParse, $Out>
    implements DoubleParseCopyWith<$R, DoubleParse, $Out> {
  _DoubleParseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleParse> $mapper =
      DoubleParseMapper.ensureInitialized();
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
  DoubleParse $make(CopyWithData data) => DoubleParse(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleParseCopyWith<$R2, DoubleParse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleParseCopyWithImpl($value, $cast, t);
}
