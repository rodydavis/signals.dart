// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_ceil.dart';

class IntCeilMapper extends SubClassMapperBase<IntCeil> {
  IntCeilMapper._();

  static IntCeilMapper? _instance;
  static IntCeilMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntCeilMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntCeil';

  static int _$id(IntCeil v) => v.id;
  static const Field<IntCeil, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntCeil v) => v.inputs;
  static const Field<IntCeil, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntCeil v) => v.offset;
  static const Field<IntCeil, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntCeil v) => v.label;
  static const Field<IntCeil, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntCeil v) => v.expanded;
  static const Field<IntCeil, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntCeil v) => v.getNode;
  static const Field<IntCeil, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntCeil> fields = const {
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
  final dynamic discriminatorValue = 'int_ceil';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntCeil _instantiate(DecodingData data) {
    return IntCeil(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntCeil fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntCeil>(map);
  }

  static IntCeil fromJson(String json) {
    return ensureInitialized().decodeJson<IntCeil>(json);
  }
}

mixin IntCeilMappable {
  String toJson() {
    return IntCeilMapper.ensureInitialized()
        .encodeJson<IntCeil>(this as IntCeil);
  }

  Map<String, dynamic> toMap() {
    return IntCeilMapper.ensureInitialized()
        .encodeMap<IntCeil>(this as IntCeil);
  }

  IntCeilCopyWith<IntCeil, IntCeil, IntCeil> get copyWith =>
      _IntCeilCopyWithImpl(this as IntCeil, $identity, $identity);
  @override
  String toString() {
    return IntCeilMapper.ensureInitialized().stringifyValue(this as IntCeil);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntCeilMapper.ensureInitialized()
                .isValueEqual(this as IntCeil, other));
  }

  @override
  int get hashCode {
    return IntCeilMapper.ensureInitialized().hashValue(this as IntCeil);
  }
}

extension IntCeilValueCopy<$R, $Out> on ObjectCopyWith<$R, IntCeil, $Out> {
  IntCeilCopyWith<$R, IntCeil, $Out> get $asIntCeil =>
      $base.as((v, t, t2) => _IntCeilCopyWithImpl(v, t, t2));
}

abstract class IntCeilCopyWith<$R, $In extends IntCeil, $Out>
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
  IntCeilCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntCeilCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntCeil, $Out>
    implements IntCeilCopyWith<$R, IntCeil, $Out> {
  _IntCeilCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntCeil> $mapper =
      IntCeilMapper.ensureInitialized();
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
  IntCeil $make(CopyWithData data) => IntCeil(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntCeilCopyWith<$R2, IntCeil, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _IntCeilCopyWithImpl($value, $cast, t);
}
