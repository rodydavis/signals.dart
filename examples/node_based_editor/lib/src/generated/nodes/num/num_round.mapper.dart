// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_round.dart';

class NumRoundMapper extends SubClassMapperBase<NumRound> {
  NumRoundMapper._();

  static NumRoundMapper? _instance;
  static NumRoundMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumRoundMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumRound';

  static int _$id(NumRound v) => v.id;
  static const Field<NumRound, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumRound v) => v.inputs;
  static const Field<NumRound, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumRound v) => v.offset;
  static const Field<NumRound, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumRound v) => v.label;
  static const Field<NumRound, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumRound v) => v.expanded;
  static const Field<NumRound, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumRound v) => v.getNode;
  static const Field<NumRound, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumRound> fields = const {
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
  final dynamic discriminatorValue = 'num_round';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumRound _instantiate(DecodingData data) {
    return NumRound(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumRound fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumRound>(map);
  }

  static NumRound fromJson(String json) {
    return ensureInitialized().decodeJson<NumRound>(json);
  }
}

mixin NumRoundMappable {
  String toJson() {
    return NumRoundMapper.ensureInitialized()
        .encodeJson<NumRound>(this as NumRound);
  }

  Map<String, dynamic> toMap() {
    return NumRoundMapper.ensureInitialized()
        .encodeMap<NumRound>(this as NumRound);
  }

  NumRoundCopyWith<NumRound, NumRound, NumRound> get copyWith =>
      _NumRoundCopyWithImpl(this as NumRound, $identity, $identity);
  @override
  String toString() {
    return NumRoundMapper.ensureInitialized().stringifyValue(this as NumRound);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumRoundMapper.ensureInitialized()
                .isValueEqual(this as NumRound, other));
  }

  @override
  int get hashCode {
    return NumRoundMapper.ensureInitialized().hashValue(this as NumRound);
  }
}

extension NumRoundValueCopy<$R, $Out> on ObjectCopyWith<$R, NumRound, $Out> {
  NumRoundCopyWith<$R, NumRound, $Out> get $asNumRound =>
      $base.as((v, t, t2) => _NumRoundCopyWithImpl(v, t, t2));
}

abstract class NumRoundCopyWith<$R, $In extends NumRound, $Out>
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
  NumRoundCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumRoundCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumRound, $Out>
    implements NumRoundCopyWith<$R, NumRound, $Out> {
  _NumRoundCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumRound> $mapper =
      NumRoundMapper.ensureInitialized();
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
  NumRound $make(CopyWithData data) => NumRound(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumRoundCopyWith<$R2, NumRound, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumRoundCopyWithImpl($value, $cast, t);
}
