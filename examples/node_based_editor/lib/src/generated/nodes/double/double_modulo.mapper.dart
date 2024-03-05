// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_modulo.dart';

class DoubleModuloMapper extends SubClassMapperBase<DoubleModulo> {
  DoubleModuloMapper._();

  static DoubleModuloMapper? _instance;
  static DoubleModuloMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleModuloMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleModulo';

  static int _$id(DoubleModulo v) => v.id;
  static const Field<DoubleModulo, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleModulo v) => v.inputs;
  static const Field<DoubleModulo, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleModulo v) => v.offset;
  static const Field<DoubleModulo, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleModulo v) => v.label;
  static const Field<DoubleModulo, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleModulo v) => v.expanded;
  static const Field<DoubleModulo, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleModulo v) => v.getNode;
  static const Field<DoubleModulo, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleModulo> fields = const {
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
  final dynamic discriminatorValue = 'double_modulo';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleModulo _instantiate(DecodingData data) {
    return DoubleModulo(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleModulo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleModulo>(map);
  }

  static DoubleModulo fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleModulo>(json);
  }
}

mixin DoubleModuloMappable {
  String toJson() {
    return DoubleModuloMapper.ensureInitialized()
        .encodeJson<DoubleModulo>(this as DoubleModulo);
  }

  Map<String, dynamic> toMap() {
    return DoubleModuloMapper.ensureInitialized()
        .encodeMap<DoubleModulo>(this as DoubleModulo);
  }

  DoubleModuloCopyWith<DoubleModulo, DoubleModulo, DoubleModulo> get copyWith =>
      _DoubleModuloCopyWithImpl(this as DoubleModulo, $identity, $identity);
  @override
  String toString() {
    return DoubleModuloMapper.ensureInitialized()
        .stringifyValue(this as DoubleModulo);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleModuloMapper.ensureInitialized()
                .isValueEqual(this as DoubleModulo, other));
  }

  @override
  int get hashCode {
    return DoubleModuloMapper.ensureInitialized()
        .hashValue(this as DoubleModulo);
  }
}

extension DoubleModuloValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleModulo, $Out> {
  DoubleModuloCopyWith<$R, DoubleModulo, $Out> get $asDoubleModulo =>
      $base.as((v, t, t2) => _DoubleModuloCopyWithImpl(v, t, t2));
}

abstract class DoubleModuloCopyWith<$R, $In extends DoubleModulo, $Out>
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
  DoubleModuloCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleModuloCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleModulo, $Out>
    implements DoubleModuloCopyWith<$R, DoubleModulo, $Out> {
  _DoubleModuloCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleModulo> $mapper =
      DoubleModuloMapper.ensureInitialized();
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
  DoubleModulo $make(CopyWithData data) => DoubleModulo(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleModuloCopyWith<$R2, DoubleModulo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleModuloCopyWithImpl($value, $cast, t);
}
