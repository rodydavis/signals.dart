// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_try_parse.dart';

class DoubleTryParseMapper extends SubClassMapperBase<DoubleTryParse> {
  DoubleTryParseMapper._();

  static DoubleTryParseMapper? _instance;
  static DoubleTryParseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleTryParseMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleTryParse';

  static int _$id(DoubleTryParse v) => v.id;
  static const Field<DoubleTryParse, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleTryParse v) => v.inputs;
  static const Field<DoubleTryParse, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleTryParse v) => v.offset;
  static const Field<DoubleTryParse, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleTryParse v) => v.label;
  static const Field<DoubleTryParse, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleTryParse v) => v.expanded;
  static const Field<DoubleTryParse, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleTryParse v) => v.getNode;
  static const Field<DoubleTryParse, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleTryParse> fields = const {
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
  final dynamic discriminatorValue = 'double_try_parse';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleTryParse _instantiate(DecodingData data) {
    return DoubleTryParse(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleTryParse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleTryParse>(map);
  }

  static DoubleTryParse fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleTryParse>(json);
  }
}

mixin DoubleTryParseMappable {
  String toJson() {
    return DoubleTryParseMapper.ensureInitialized()
        .encodeJson<DoubleTryParse>(this as DoubleTryParse);
  }

  Map<String, dynamic> toMap() {
    return DoubleTryParseMapper.ensureInitialized()
        .encodeMap<DoubleTryParse>(this as DoubleTryParse);
  }

  DoubleTryParseCopyWith<DoubleTryParse, DoubleTryParse, DoubleTryParse>
      get copyWith => _DoubleTryParseCopyWithImpl(
          this as DoubleTryParse, $identity, $identity);
  @override
  String toString() {
    return DoubleTryParseMapper.ensureInitialized()
        .stringifyValue(this as DoubleTryParse);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleTryParseMapper.ensureInitialized()
                .isValueEqual(this as DoubleTryParse, other));
  }

  @override
  int get hashCode {
    return DoubleTryParseMapper.ensureInitialized()
        .hashValue(this as DoubleTryParse);
  }
}

extension DoubleTryParseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleTryParse, $Out> {
  DoubleTryParseCopyWith<$R, DoubleTryParse, $Out> get $asDoubleTryParse =>
      $base.as((v, t, t2) => _DoubleTryParseCopyWithImpl(v, t, t2));
}

abstract class DoubleTryParseCopyWith<$R, $In extends DoubleTryParse, $Out>
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
  DoubleTryParseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleTryParseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleTryParse, $Out>
    implements DoubleTryParseCopyWith<$R, DoubleTryParse, $Out> {
  _DoubleTryParseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleTryParse> $mapper =
      DoubleTryParseMapper.ensureInitialized();
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
  DoubleTryParse $make(CopyWithData data) => DoubleTryParse(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleTryParseCopyWith<$R2, DoubleTryParse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleTryParseCopyWithImpl($value, $cast, t);
}
