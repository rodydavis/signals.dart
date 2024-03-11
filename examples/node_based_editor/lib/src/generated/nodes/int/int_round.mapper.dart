// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_round.dart';

class IntRoundMapper extends SubClassMapperBase<IntRound> {
  IntRoundMapper._();

  static IntRoundMapper? _instance;
  static IntRoundMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntRoundMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntRound';

  static int _$id(IntRound v) => v.id;
  static const Field<IntRound, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntRound v) => v.inputs;
  static const Field<IntRound, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntRound v) => v.offset;
  static const Field<IntRound, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntRound v) => v.label;
  static const Field<IntRound, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntRound v) => v.expanded;
  static const Field<IntRound, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntRound v) => v.getNode;
  static const Field<IntRound, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntRound> fields = const {
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
  final dynamic discriminatorValue = 'int_round';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntRound _instantiate(DecodingData data) {
    return IntRound(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntRound fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntRound>(map);
  }

  static IntRound fromJson(String json) {
    return ensureInitialized().decodeJson<IntRound>(json);
  }
}

mixin IntRoundMappable {
  String toJson() {
    return IntRoundMapper.ensureInitialized()
        .encodeJson<IntRound>(this as IntRound);
  }

  Map<String, dynamic> toMap() {
    return IntRoundMapper.ensureInitialized()
        .encodeMap<IntRound>(this as IntRound);
  }

  IntRoundCopyWith<IntRound, IntRound, IntRound> get copyWith =>
      _IntRoundCopyWithImpl(this as IntRound, $identity, $identity);
  @override
  String toString() {
    return IntRoundMapper.ensureInitialized().stringifyValue(this as IntRound);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntRoundMapper.ensureInitialized()
                .isValueEqual(this as IntRound, other));
  }

  @override
  int get hashCode {
    return IntRoundMapper.ensureInitialized().hashValue(this as IntRound);
  }
}

extension IntRoundValueCopy<$R, $Out> on ObjectCopyWith<$R, IntRound, $Out> {
  IntRoundCopyWith<$R, IntRound, $Out> get $asIntRound =>
      $base.as((v, t, t2) => _IntRoundCopyWithImpl(v, t, t2));
}

abstract class IntRoundCopyWith<$R, $In extends IntRound, $Out>
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
  IntRoundCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntRoundCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntRound, $Out>
    implements IntRoundCopyWith<$R, IntRound, $Out> {
  _IntRoundCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntRound> $mapper =
      IntRoundMapper.ensureInitialized();
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
  IntRound $make(CopyWithData data) => IntRound(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntRoundCopyWith<$R2, IntRound, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntRoundCopyWithImpl($value, $cast, t);
}
