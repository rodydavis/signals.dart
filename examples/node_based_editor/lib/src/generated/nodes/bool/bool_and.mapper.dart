// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bool_and.dart';

class BoolAndMapper extends SubClassMapperBase<BoolAnd> {
  BoolAndMapper._();

  static BoolAndMapper? _instance;
  static BoolAndMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoolAndMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'BoolAnd';

  static int _$id(BoolAnd v) => v.id;
  static const Field<BoolAnd, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(BoolAnd v) => v.inputs;
  static const Field<BoolAnd, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(BoolAnd v) => v.offset;
  static const Field<BoolAnd, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(BoolAnd v) => v.label;
  static const Field<BoolAnd, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(BoolAnd v) => v.expanded;
  static const Field<BoolAnd, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(BoolAnd v) => v.getNode;
  static const Field<BoolAnd, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<BoolAnd> fields = const {
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
  final dynamic discriminatorValue = 'bool_and';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static BoolAnd _instantiate(DecodingData data) {
    return BoolAnd(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static BoolAnd fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoolAnd>(map);
  }

  static BoolAnd fromJson(String json) {
    return ensureInitialized().decodeJson<BoolAnd>(json);
  }
}

mixin BoolAndMappable {
  String toJson() {
    return BoolAndMapper.ensureInitialized()
        .encodeJson<BoolAnd>(this as BoolAnd);
  }

  Map<String, dynamic> toMap() {
    return BoolAndMapper.ensureInitialized()
        .encodeMap<BoolAnd>(this as BoolAnd);
  }

  BoolAndCopyWith<BoolAnd, BoolAnd, BoolAnd> get copyWith =>
      _BoolAndCopyWithImpl(this as BoolAnd, $identity, $identity);
  @override
  String toString() {
    return BoolAndMapper.ensureInitialized().stringifyValue(this as BoolAnd);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BoolAndMapper.ensureInitialized()
                .isValueEqual(this as BoolAnd, other));
  }

  @override
  int get hashCode {
    return BoolAndMapper.ensureInitialized().hashValue(this as BoolAnd);
  }
}

extension BoolAndValueCopy<$R, $Out> on ObjectCopyWith<$R, BoolAnd, $Out> {
  BoolAndCopyWith<$R, BoolAnd, $Out> get $asBoolAnd =>
      $base.as((v, t, t2) => _BoolAndCopyWithImpl(v, t, t2));
}

abstract class BoolAndCopyWith<$R, $In extends BoolAnd, $Out>
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
  BoolAndCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BoolAndCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoolAnd, $Out>
    implements BoolAndCopyWith<$R, BoolAnd, $Out> {
  _BoolAndCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoolAnd> $mapper =
      BoolAndMapper.ensureInitialized();
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
  BoolAnd $make(CopyWithData data) => BoolAnd(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  BoolAndCopyWith<$R2, BoolAnd, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BoolAndCopyWithImpl($value, $cast, t);
}
