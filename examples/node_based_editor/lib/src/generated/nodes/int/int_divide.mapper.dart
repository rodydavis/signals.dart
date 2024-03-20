// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_divide.dart';

class IntDivideMapper extends SubClassMapperBase<IntDivide> {
  IntDivideMapper._();

  static IntDivideMapper? _instance;
  static IntDivideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntDivideMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntDivide';

  static int _$id(IntDivide v) => v.id;
  static const Field<IntDivide, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntDivide v) => v.inputs;
  static const Field<IntDivide, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntDivide v) => v.offset;
  static const Field<IntDivide, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntDivide v) => v.label;
  static const Field<IntDivide, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntDivide v) => v.expanded;
  static const Field<IntDivide, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntDivide v) => v.getNode;
  static const Field<IntDivide, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntDivide> fields = const {
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
  final dynamic discriminatorValue = 'int_divide';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntDivide _instantiate(DecodingData data) {
    return IntDivide(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntDivide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntDivide>(map);
  }

  static IntDivide fromJson(String json) {
    return ensureInitialized().decodeJson<IntDivide>(json);
  }
}

mixin IntDivideMappable {
  String toJson() {
    return IntDivideMapper.ensureInitialized()
        .encodeJson<IntDivide>(this as IntDivide);
  }

  Map<String, dynamic> toMap() {
    return IntDivideMapper.ensureInitialized()
        .encodeMap<IntDivide>(this as IntDivide);
  }

  IntDivideCopyWith<IntDivide, IntDivide, IntDivide> get copyWith =>
      _IntDivideCopyWithImpl(this as IntDivide, $identity, $identity);
  @override
  String toString() {
    return IntDivideMapper.ensureInitialized()
        .stringifyValue(this as IntDivide);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntDivideMapper.ensureInitialized()
                .isValueEqual(this as IntDivide, other));
  }

  @override
  int get hashCode {
    return IntDivideMapper.ensureInitialized().hashValue(this as IntDivide);
  }
}

extension IntDivideValueCopy<$R, $Out> on ObjectCopyWith<$R, IntDivide, $Out> {
  IntDivideCopyWith<$R, IntDivide, $Out> get $asIntDivide =>
      $base.as((v, t, t2) => _IntDivideCopyWithImpl(v, t, t2));
}

abstract class IntDivideCopyWith<$R, $In extends IntDivide, $Out>
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
  IntDivideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntDivideCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntDivide, $Out>
    implements IntDivideCopyWith<$R, IntDivide, $Out> {
  _IntDivideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntDivide> $mapper =
      IntDivideMapper.ensureInitialized();
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
  IntDivide $make(CopyWithData data) => IntDivide(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntDivideCopyWith<$R2, IntDivide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntDivideCopyWithImpl($value, $cast, t);
}
