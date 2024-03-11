// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_round.dart';

class DoubleRoundMapper extends SubClassMapperBase<DoubleRound> {
  DoubleRoundMapper._();

  static DoubleRoundMapper? _instance;
  static DoubleRoundMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleRoundMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleRound';

  static int _$id(DoubleRound v) => v.id;
  static const Field<DoubleRound, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleRound v) => v.inputs;
  static const Field<DoubleRound, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleRound v) => v.offset;
  static const Field<DoubleRound, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleRound v) => v.label;
  static const Field<DoubleRound, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleRound v) => v.expanded;
  static const Field<DoubleRound, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleRound v) => v.getNode;
  static const Field<DoubleRound, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleRound> fields = const {
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
  final dynamic discriminatorValue = 'double_round';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleRound _instantiate(DecodingData data) {
    return DoubleRound(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleRound fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleRound>(map);
  }

  static DoubleRound fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleRound>(json);
  }
}

mixin DoubleRoundMappable {
  String toJson() {
    return DoubleRoundMapper.ensureInitialized()
        .encodeJson<DoubleRound>(this as DoubleRound);
  }

  Map<String, dynamic> toMap() {
    return DoubleRoundMapper.ensureInitialized()
        .encodeMap<DoubleRound>(this as DoubleRound);
  }

  DoubleRoundCopyWith<DoubleRound, DoubleRound, DoubleRound> get copyWith =>
      _DoubleRoundCopyWithImpl(this as DoubleRound, $identity, $identity);
  @override
  String toString() {
    return DoubleRoundMapper.ensureInitialized()
        .stringifyValue(this as DoubleRound);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleRoundMapper.ensureInitialized()
                .isValueEqual(this as DoubleRound, other));
  }

  @override
  int get hashCode {
    return DoubleRoundMapper.ensureInitialized().hashValue(this as DoubleRound);
  }
}

extension DoubleRoundValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleRound, $Out> {
  DoubleRoundCopyWith<$R, DoubleRound, $Out> get $asDoubleRound =>
      $base.as((v, t, t2) => _DoubleRoundCopyWithImpl(v, t, t2));
}

abstract class DoubleRoundCopyWith<$R, $In extends DoubleRound, $Out>
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
  DoubleRoundCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleRoundCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleRound, $Out>
    implements DoubleRoundCopyWith<$R, DoubleRound, $Out> {
  _DoubleRoundCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleRound> $mapper =
      DoubleRoundMapper.ensureInitialized();
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
  DoubleRound $make(CopyWithData data) => DoubleRound(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleRoundCopyWith<$R2, DoubleRound, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleRoundCopyWithImpl($value, $cast, t);
}
