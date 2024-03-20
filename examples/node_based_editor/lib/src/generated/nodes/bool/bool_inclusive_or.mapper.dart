// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bool_inclusive_or.dart';

class BoolInclusiveOrMapper extends SubClassMapperBase<BoolInclusiveOr> {
  BoolInclusiveOrMapper._();

  static BoolInclusiveOrMapper? _instance;
  static BoolInclusiveOrMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoolInclusiveOrMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'BoolInclusiveOr';

  static int _$id(BoolInclusiveOr v) => v.id;
  static const Field<BoolInclusiveOr, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(BoolInclusiveOr v) =>
      v.inputs;
  static const Field<BoolInclusiveOr, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(BoolInclusiveOr v) => v.offset;
  static const Field<BoolInclusiveOr, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(BoolInclusiveOr v) => v.label;
  static const Field<BoolInclusiveOr, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(BoolInclusiveOr v) => v.expanded;
  static const Field<BoolInclusiveOr, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(BoolInclusiveOr v) => v.getNode;
  static const Field<BoolInclusiveOr, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<BoolInclusiveOr> fields = const {
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
  final dynamic discriminatorValue = 'bool_inclusive_or';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static BoolInclusiveOr _instantiate(DecodingData data) {
    return BoolInclusiveOr(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static BoolInclusiveOr fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoolInclusiveOr>(map);
  }

  static BoolInclusiveOr fromJson(String json) {
    return ensureInitialized().decodeJson<BoolInclusiveOr>(json);
  }
}

mixin BoolInclusiveOrMappable {
  String toJson() {
    return BoolInclusiveOrMapper.ensureInitialized()
        .encodeJson<BoolInclusiveOr>(this as BoolInclusiveOr);
  }

  Map<String, dynamic> toMap() {
    return BoolInclusiveOrMapper.ensureInitialized()
        .encodeMap<BoolInclusiveOr>(this as BoolInclusiveOr);
  }

  BoolInclusiveOrCopyWith<BoolInclusiveOr, BoolInclusiveOr, BoolInclusiveOr>
      get copyWith => _BoolInclusiveOrCopyWithImpl(
          this as BoolInclusiveOr, $identity, $identity);
  @override
  String toString() {
    return BoolInclusiveOrMapper.ensureInitialized()
        .stringifyValue(this as BoolInclusiveOr);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BoolInclusiveOrMapper.ensureInitialized()
                .isValueEqual(this as BoolInclusiveOr, other));
  }

  @override
  int get hashCode {
    return BoolInclusiveOrMapper.ensureInitialized()
        .hashValue(this as BoolInclusiveOr);
  }
}

extension BoolInclusiveOrValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoolInclusiveOr, $Out> {
  BoolInclusiveOrCopyWith<$R, BoolInclusiveOr, $Out> get $asBoolInclusiveOr =>
      $base.as((v, t, t2) => _BoolInclusiveOrCopyWithImpl(v, t, t2));
}

abstract class BoolInclusiveOrCopyWith<$R, $In extends BoolInclusiveOr, $Out>
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
  BoolInclusiveOrCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BoolInclusiveOrCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoolInclusiveOr, $Out>
    implements BoolInclusiveOrCopyWith<$R, BoolInclusiveOr, $Out> {
  _BoolInclusiveOrCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoolInclusiveOr> $mapper =
      BoolInclusiveOrMapper.ensureInitialized();
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
  BoolInclusiveOr $make(CopyWithData data) => BoolInclusiveOr(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  BoolInclusiveOrCopyWith<$R2, BoolInclusiveOr, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoolInclusiveOrCopyWithImpl($value, $cast, t);
}
