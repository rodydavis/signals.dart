// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_parse.dart';

class IntParseMapper extends SubClassMapperBase<IntParse> {
  IntParseMapper._();

  static IntParseMapper? _instance;
  static IntParseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntParseMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntParse';

  static int _$id(IntParse v) => v.id;
  static const Field<IntParse, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntParse v) => v.inputs;
  static const Field<IntParse, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntParse v) => v.offset;
  static const Field<IntParse, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntParse v) => v.label;
  static const Field<IntParse, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntParse v) => v.expanded;
  static const Field<IntParse, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntParse v) => v.getNode;
  static const Field<IntParse, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntParse> fields = const {
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
  final dynamic discriminatorValue = 'int_parse';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntParse _instantiate(DecodingData data) {
    return IntParse(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntParse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntParse>(map);
  }

  static IntParse fromJson(String json) {
    return ensureInitialized().decodeJson<IntParse>(json);
  }
}

mixin IntParseMappable {
  String toJson() {
    return IntParseMapper.ensureInitialized()
        .encodeJson<IntParse>(this as IntParse);
  }

  Map<String, dynamic> toMap() {
    return IntParseMapper.ensureInitialized()
        .encodeMap<IntParse>(this as IntParse);
  }

  IntParseCopyWith<IntParse, IntParse, IntParse> get copyWith =>
      _IntParseCopyWithImpl(this as IntParse, $identity, $identity);
  @override
  String toString() {
    return IntParseMapper.ensureInitialized().stringifyValue(this as IntParse);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntParseMapper.ensureInitialized()
                .isValueEqual(this as IntParse, other));
  }

  @override
  int get hashCode {
    return IntParseMapper.ensureInitialized().hashValue(this as IntParse);
  }
}

extension IntParseValueCopy<$R, $Out> on ObjectCopyWith<$R, IntParse, $Out> {
  IntParseCopyWith<$R, IntParse, $Out> get $asIntParse =>
      $base.as((v, t, t2) => _IntParseCopyWithImpl(v, t, t2));
}

abstract class IntParseCopyWith<$R, $In extends IntParse, $Out>
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
  IntParseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntParseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntParse, $Out>
    implements IntParseCopyWith<$R, IntParse, $Out> {
  _IntParseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntParse> $mapper =
      IntParseMapper.ensureInitialized();
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
  IntParse $make(CopyWithData data) => IntParse(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntParseCopyWith<$R2, IntParse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntParseCopyWithImpl($value, $cast, t);
}
