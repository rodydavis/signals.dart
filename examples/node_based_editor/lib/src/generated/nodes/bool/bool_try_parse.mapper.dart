// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bool_try_parse.dart';

class BoolTryParseMapper extends SubClassMapperBase<BoolTryParse> {
  BoolTryParseMapper._();

  static BoolTryParseMapper? _instance;
  static BoolTryParseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoolTryParseMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'BoolTryParse';

  static int _$id(BoolTryParse v) => v.id;
  static const Field<BoolTryParse, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(BoolTryParse v) => v.inputs;
  static const Field<BoolTryParse, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(BoolTryParse v) => v.offset;
  static const Field<BoolTryParse, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(BoolTryParse v) => v.label;
  static const Field<BoolTryParse, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(BoolTryParse v) => v.expanded;
  static const Field<BoolTryParse, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(BoolTryParse v) => v.getNode;
  static const Field<BoolTryParse, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<BoolTryParse> fields = const {
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
  final dynamic discriminatorValue = 'bool_try_parse';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static BoolTryParse _instantiate(DecodingData data) {
    return BoolTryParse(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static BoolTryParse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoolTryParse>(map);
  }

  static BoolTryParse fromJson(String json) {
    return ensureInitialized().decodeJson<BoolTryParse>(json);
  }
}

mixin BoolTryParseMappable {
  String toJson() {
    return BoolTryParseMapper.ensureInitialized()
        .encodeJson<BoolTryParse>(this as BoolTryParse);
  }

  Map<String, dynamic> toMap() {
    return BoolTryParseMapper.ensureInitialized()
        .encodeMap<BoolTryParse>(this as BoolTryParse);
  }

  BoolTryParseCopyWith<BoolTryParse, BoolTryParse, BoolTryParse> get copyWith =>
      _BoolTryParseCopyWithImpl(this as BoolTryParse, $identity, $identity);
  @override
  String toString() {
    return BoolTryParseMapper.ensureInitialized()
        .stringifyValue(this as BoolTryParse);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BoolTryParseMapper.ensureInitialized()
                .isValueEqual(this as BoolTryParse, other));
  }

  @override
  int get hashCode {
    return BoolTryParseMapper.ensureInitialized()
        .hashValue(this as BoolTryParse);
  }
}

extension BoolTryParseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoolTryParse, $Out> {
  BoolTryParseCopyWith<$R, BoolTryParse, $Out> get $asBoolTryParse =>
      $base.as((v, t, t2) => _BoolTryParseCopyWithImpl(v, t, t2));
}

abstract class BoolTryParseCopyWith<$R, $In extends BoolTryParse, $Out>
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
  BoolTryParseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BoolTryParseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoolTryParse, $Out>
    implements BoolTryParseCopyWith<$R, BoolTryParse, $Out> {
  _BoolTryParseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoolTryParse> $mapper =
      BoolTryParseMapper.ensureInitialized();
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
  BoolTryParse $make(CopyWithData data) => BoolTryParse(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  BoolTryParseCopyWith<$R2, BoolTryParse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoolTryParseCopyWithImpl($value, $cast, t);
}
