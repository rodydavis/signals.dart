// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_add.dart';

class IntAddMapper extends SubClassMapperBase<IntAdd> {
  IntAddMapper._();

  static IntAddMapper? _instance;
  static IntAddMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntAddMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntAdd';

  static int _$id(IntAdd v) => v.id;
  static const Field<IntAdd, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntAdd v) => v.inputs;
  static const Field<IntAdd, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntAdd v) => v.offset;
  static const Field<IntAdd, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntAdd v) => v.label;
  static const Field<IntAdd, Signal<String>> _f$label = Field('label', _$label);
  static Signal<bool> _$expanded(IntAdd v) => v.expanded;
  static const Field<IntAdd, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntAdd v) => v.getNode;
  static const Field<IntAdd, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntAdd> fields = const {
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
  final dynamic discriminatorValue = 'int_add';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntAdd _instantiate(DecodingData data) {
    return IntAdd(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntAdd fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntAdd>(map);
  }

  static IntAdd fromJson(String json) {
    return ensureInitialized().decodeJson<IntAdd>(json);
  }
}

mixin IntAddMappable {
  String toJson() {
    return IntAddMapper.ensureInitialized().encodeJson<IntAdd>(this as IntAdd);
  }

  Map<String, dynamic> toMap() {
    return IntAddMapper.ensureInitialized().encodeMap<IntAdd>(this as IntAdd);
  }

  IntAddCopyWith<IntAdd, IntAdd, IntAdd> get copyWith =>
      _IntAddCopyWithImpl(this as IntAdd, $identity, $identity);
  @override
  String toString() {
    return IntAddMapper.ensureInitialized().stringifyValue(this as IntAdd);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntAddMapper.ensureInitialized()
                .isValueEqual(this as IntAdd, other));
  }

  @override
  int get hashCode {
    return IntAddMapper.ensureInitialized().hashValue(this as IntAdd);
  }
}

extension IntAddValueCopy<$R, $Out> on ObjectCopyWith<$R, IntAdd, $Out> {
  IntAddCopyWith<$R, IntAdd, $Out> get $asIntAdd =>
      $base.as((v, t, t2) => _IntAddCopyWithImpl(v, t, t2));
}

abstract class IntAddCopyWith<$R, $In extends IntAdd, $Out>
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
  IntAddCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntAddCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, IntAdd, $Out>
    implements IntAddCopyWith<$R, IntAdd, $Out> {
  _IntAddCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntAdd> $mapper = IntAddMapper.ensureInitialized();
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
  IntAdd $make(CopyWithData data) => IntAdd(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntAddCopyWith<$R2, IntAdd, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _IntAddCopyWithImpl($value, $cast, t);
}
