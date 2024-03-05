// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_sign.dart';

class NumSignMapper extends SubClassMapperBase<NumSign> {
  NumSignMapper._();

  static NumSignMapper? _instance;
  static NumSignMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumSignMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumSign';

  static int _$id(NumSign v) => v.id;
  static const Field<NumSign, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumSign v) => v.inputs;
  static const Field<NumSign, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumSign v) => v.offset;
  static const Field<NumSign, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumSign v) => v.label;
  static const Field<NumSign, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumSign v) => v.expanded;
  static const Field<NumSign, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumSign v) => v.getNode;
  static const Field<NumSign, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumSign> fields = const {
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
  final dynamic discriminatorValue = 'num_sign';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumSign _instantiate(DecodingData data) {
    return NumSign(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumSign fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumSign>(map);
  }

  static NumSign fromJson(String json) {
    return ensureInitialized().decodeJson<NumSign>(json);
  }
}

mixin NumSignMappable {
  String toJson() {
    return NumSignMapper.ensureInitialized()
        .encodeJson<NumSign>(this as NumSign);
  }

  Map<String, dynamic> toMap() {
    return NumSignMapper.ensureInitialized()
        .encodeMap<NumSign>(this as NumSign);
  }

  NumSignCopyWith<NumSign, NumSign, NumSign> get copyWith =>
      _NumSignCopyWithImpl(this as NumSign, $identity, $identity);
  @override
  String toString() {
    return NumSignMapper.ensureInitialized().stringifyValue(this as NumSign);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumSignMapper.ensureInitialized()
                .isValueEqual(this as NumSign, other));
  }

  @override
  int get hashCode {
    return NumSignMapper.ensureInitialized().hashValue(this as NumSign);
  }
}

extension NumSignValueCopy<$R, $Out> on ObjectCopyWith<$R, NumSign, $Out> {
  NumSignCopyWith<$R, NumSign, $Out> get $asNumSign =>
      $base.as((v, t, t2) => _NumSignCopyWithImpl(v, t, t2));
}

abstract class NumSignCopyWith<$R, $In extends NumSign, $Out>
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
  NumSignCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumSignCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumSign, $Out>
    implements NumSignCopyWith<$R, NumSign, $Out> {
  _NumSignCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumSign> $mapper =
      NumSignMapper.ensureInitialized();
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
  NumSign $make(CopyWithData data) => NumSign(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumSignCopyWith<$R2, NumSign, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NumSignCopyWithImpl($value, $cast, t);
}
