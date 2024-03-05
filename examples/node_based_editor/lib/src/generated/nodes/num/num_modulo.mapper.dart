// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_modulo.dart';

class NumModuloMapper extends SubClassMapperBase<NumModulo> {
  NumModuloMapper._();

  static NumModuloMapper? _instance;
  static NumModuloMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumModuloMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumModulo';

  static int _$id(NumModulo v) => v.id;
  static const Field<NumModulo, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumModulo v) => v.inputs;
  static const Field<NumModulo, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumModulo v) => v.offset;
  static const Field<NumModulo, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumModulo v) => v.label;
  static const Field<NumModulo, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumModulo v) => v.expanded;
  static const Field<NumModulo, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumModulo v) => v.getNode;
  static const Field<NumModulo, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumModulo> fields = const {
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
  final dynamic discriminatorValue = 'num_modulo';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumModulo _instantiate(DecodingData data) {
    return NumModulo(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumModulo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumModulo>(map);
  }

  static NumModulo fromJson(String json) {
    return ensureInitialized().decodeJson<NumModulo>(json);
  }
}

mixin NumModuloMappable {
  String toJson() {
    return NumModuloMapper.ensureInitialized()
        .encodeJson<NumModulo>(this as NumModulo);
  }

  Map<String, dynamic> toMap() {
    return NumModuloMapper.ensureInitialized()
        .encodeMap<NumModulo>(this as NumModulo);
  }

  NumModuloCopyWith<NumModulo, NumModulo, NumModulo> get copyWith =>
      _NumModuloCopyWithImpl(this as NumModulo, $identity, $identity);
  @override
  String toString() {
    return NumModuloMapper.ensureInitialized()
        .stringifyValue(this as NumModulo);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumModuloMapper.ensureInitialized()
                .isValueEqual(this as NumModulo, other));
  }

  @override
  int get hashCode {
    return NumModuloMapper.ensureInitialized().hashValue(this as NumModulo);
  }
}

extension NumModuloValueCopy<$R, $Out> on ObjectCopyWith<$R, NumModulo, $Out> {
  NumModuloCopyWith<$R, NumModulo, $Out> get $asNumModulo =>
      $base.as((v, t, t2) => _NumModuloCopyWithImpl(v, t, t2));
}

abstract class NumModuloCopyWith<$R, $In extends NumModulo, $Out>
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
  NumModuloCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumModuloCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumModulo, $Out>
    implements NumModuloCopyWith<$R, NumModulo, $Out> {
  _NumModuloCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumModulo> $mapper =
      NumModuloMapper.ensureInitialized();
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
  NumModulo $make(CopyWithData data) => NumModulo(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumModuloCopyWith<$R2, NumModulo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumModuloCopyWithImpl($value, $cast, t);
}
