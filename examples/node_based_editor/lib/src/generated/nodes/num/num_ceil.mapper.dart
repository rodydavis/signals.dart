// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_ceil.dart';

class NumCeilMapper extends SubClassMapperBase<NumCeil> {
  NumCeilMapper._();

  static NumCeilMapper? _instance;
  static NumCeilMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumCeilMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumCeil';

  static int _$id(NumCeil v) => v.id;
  static const Field<NumCeil, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumCeil v) => v.inputs;
  static const Field<NumCeil, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumCeil v) => v.offset;
  static const Field<NumCeil, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumCeil v) => v.label;
  static const Field<NumCeil, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumCeil v) => v.expanded;
  static const Field<NumCeil, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumCeil v) => v.getNode;
  static const Field<NumCeil, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumCeil> fields = const {
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
  final dynamic discriminatorValue = 'num_ceil';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumCeil _instantiate(DecodingData data) {
    return NumCeil(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumCeil fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumCeil>(map);
  }

  static NumCeil fromJson(String json) {
    return ensureInitialized().decodeJson<NumCeil>(json);
  }
}

mixin NumCeilMappable {
  String toJson() {
    return NumCeilMapper.ensureInitialized()
        .encodeJson<NumCeil>(this as NumCeil);
  }

  Map<String, dynamic> toMap() {
    return NumCeilMapper.ensureInitialized()
        .encodeMap<NumCeil>(this as NumCeil);
  }

  NumCeilCopyWith<NumCeil, NumCeil, NumCeil> get copyWith =>
      _NumCeilCopyWithImpl(this as NumCeil, $identity, $identity);
  @override
  String toString() {
    return NumCeilMapper.ensureInitialized().stringifyValue(this as NumCeil);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumCeilMapper.ensureInitialized()
                .isValueEqual(this as NumCeil, other));
  }

  @override
  int get hashCode {
    return NumCeilMapper.ensureInitialized().hashValue(this as NumCeil);
  }
}

extension NumCeilValueCopy<$R, $Out> on ObjectCopyWith<$R, NumCeil, $Out> {
  NumCeilCopyWith<$R, NumCeil, $Out> get $asNumCeil =>
      $base.as((v, t, t2) => _NumCeilCopyWithImpl(v, t, t2));
}

abstract class NumCeilCopyWith<$R, $In extends NumCeil, $Out>
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
  NumCeilCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumCeilCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumCeil, $Out>
    implements NumCeilCopyWith<$R, NumCeil, $Out> {
  _NumCeilCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumCeil> $mapper =
      NumCeilMapper.ensureInitialized();
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
  NumCeil $make(CopyWithData data) => NumCeil(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumCeilCopyWith<$R2, NumCeil, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NumCeilCopyWithImpl($value, $cast, t);
}
