// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bool_parse.dart';

class BoolParseMapper extends SubClassMapperBase<BoolParse> {
  BoolParseMapper._();

  static BoolParseMapper? _instance;
  static BoolParseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoolParseMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'BoolParse';

  static int _$id(BoolParse v) => v.id;
  static const Field<BoolParse, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(BoolParse v) => v.inputs;
  static const Field<BoolParse, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(BoolParse v) => v.offset;
  static const Field<BoolParse, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(BoolParse v) => v.label;
  static const Field<BoolParse, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(BoolParse v) => v.expanded;
  static const Field<BoolParse, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(BoolParse v) => v.getNode;
  static const Field<BoolParse, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<BoolParse> fields = const {
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
  final dynamic discriminatorValue = 'bool_parse';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static BoolParse _instantiate(DecodingData data) {
    return BoolParse(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static BoolParse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoolParse>(map);
  }

  static BoolParse fromJson(String json) {
    return ensureInitialized().decodeJson<BoolParse>(json);
  }
}

mixin BoolParseMappable {
  String toJson() {
    return BoolParseMapper.ensureInitialized()
        .encodeJson<BoolParse>(this as BoolParse);
  }

  Map<String, dynamic> toMap() {
    return BoolParseMapper.ensureInitialized()
        .encodeMap<BoolParse>(this as BoolParse);
  }

  BoolParseCopyWith<BoolParse, BoolParse, BoolParse> get copyWith =>
      _BoolParseCopyWithImpl(this as BoolParse, $identity, $identity);
  @override
  String toString() {
    return BoolParseMapper.ensureInitialized()
        .stringifyValue(this as BoolParse);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BoolParseMapper.ensureInitialized()
                .isValueEqual(this as BoolParse, other));
  }

  @override
  int get hashCode {
    return BoolParseMapper.ensureInitialized().hashValue(this as BoolParse);
  }
}

extension BoolParseValueCopy<$R, $Out> on ObjectCopyWith<$R, BoolParse, $Out> {
  BoolParseCopyWith<$R, BoolParse, $Out> get $asBoolParse =>
      $base.as((v, t, t2) => _BoolParseCopyWithImpl(v, t, t2));
}

abstract class BoolParseCopyWith<$R, $In extends BoolParse, $Out>
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
  BoolParseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BoolParseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoolParse, $Out>
    implements BoolParseCopyWith<$R, BoolParse, $Out> {
  _BoolParseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoolParse> $mapper =
      BoolParseMapper.ensureInitialized();
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
  BoolParse $make(CopyWithData data) => BoolParse(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  BoolParseCopyWith<$R2, BoolParse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoolParseCopyWithImpl($value, $cast, t);
}
