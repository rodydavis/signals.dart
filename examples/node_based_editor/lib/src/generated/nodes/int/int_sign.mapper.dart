// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_sign.dart';

class IntSignMapper extends SubClassMapperBase<IntSign> {
  IntSignMapper._();

  static IntSignMapper? _instance;
  static IntSignMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntSignMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntSign';

  static int _$id(IntSign v) => v.id;
  static const Field<IntSign, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntSign v) => v.inputs;
  static const Field<IntSign, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntSign v) => v.offset;
  static const Field<IntSign, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntSign v) => v.label;
  static const Field<IntSign, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntSign v) => v.expanded;
  static const Field<IntSign, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntSign v) => v.getNode;
  static const Field<IntSign, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntSign> fields = const {
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
  final dynamic discriminatorValue = 'int_sign';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntSign _instantiate(DecodingData data) {
    return IntSign(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntSign fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntSign>(map);
  }

  static IntSign fromJson(String json) {
    return ensureInitialized().decodeJson<IntSign>(json);
  }
}

mixin IntSignMappable {
  String toJson() {
    return IntSignMapper.ensureInitialized()
        .encodeJson<IntSign>(this as IntSign);
  }

  Map<String, dynamic> toMap() {
    return IntSignMapper.ensureInitialized()
        .encodeMap<IntSign>(this as IntSign);
  }

  IntSignCopyWith<IntSign, IntSign, IntSign> get copyWith =>
      _IntSignCopyWithImpl(this as IntSign, $identity, $identity);
  @override
  String toString() {
    return IntSignMapper.ensureInitialized().stringifyValue(this as IntSign);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntSignMapper.ensureInitialized()
                .isValueEqual(this as IntSign, other));
  }

  @override
  int get hashCode {
    return IntSignMapper.ensureInitialized().hashValue(this as IntSign);
  }
}

extension IntSignValueCopy<$R, $Out> on ObjectCopyWith<$R, IntSign, $Out> {
  IntSignCopyWith<$R, IntSign, $Out> get $asIntSign =>
      $base.as((v, t, t2) => _IntSignCopyWithImpl(v, t, t2));
}

abstract class IntSignCopyWith<$R, $In extends IntSign, $Out>
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
  IntSignCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntSignCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntSign, $Out>
    implements IntSignCopyWith<$R, IntSign, $Out> {
  _IntSignCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntSign> $mapper =
      IntSignMapper.ensureInitialized();
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
  IntSign $make(CopyWithData data) => IntSign(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntSignCopyWith<$R2, IntSign, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _IntSignCopyWithImpl($value, $cast, t);
}
