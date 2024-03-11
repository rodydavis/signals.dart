// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_to_string_as_exponential.dart';

class NumToStringAsExponentialMapper
    extends SubClassMapperBase<NumToStringAsExponential> {
  NumToStringAsExponentialMapper._();

  static NumToStringAsExponentialMapper? _instance;
  static NumToStringAsExponentialMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = NumToStringAsExponentialMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumToStringAsExponential';

  static int _$id(NumToStringAsExponential v) => v.id;
  static const Field<NumToStringAsExponential, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumToStringAsExponential v) =>
      v.inputs;
  static const Field<NumToStringAsExponential, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumToStringAsExponential v) => v.offset;
  static const Field<NumToStringAsExponential, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumToStringAsExponential v) => v.label;
  static const Field<NumToStringAsExponential, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumToStringAsExponential v) => v.expanded;
  static const Field<NumToStringAsExponential, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumToStringAsExponential v) =>
      v.getNode;
  static const Field<NumToStringAsExponential, BaseNode Function(int)>
      _f$getNode = Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumToStringAsExponential> fields = const {
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
  final dynamic discriminatorValue = 'num_to_string_as_exponential';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumToStringAsExponential _instantiate(DecodingData data) {
    return NumToStringAsExponential(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumToStringAsExponential fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumToStringAsExponential>(map);
  }

  static NumToStringAsExponential fromJson(String json) {
    return ensureInitialized().decodeJson<NumToStringAsExponential>(json);
  }
}

mixin NumToStringAsExponentialMappable {
  String toJson() {
    return NumToStringAsExponentialMapper.ensureInitialized()
        .encodeJson<NumToStringAsExponential>(this as NumToStringAsExponential);
  }

  Map<String, dynamic> toMap() {
    return NumToStringAsExponentialMapper.ensureInitialized()
        .encodeMap<NumToStringAsExponential>(this as NumToStringAsExponential);
  }

  NumToStringAsExponentialCopyWith<NumToStringAsExponential,
          NumToStringAsExponential, NumToStringAsExponential>
      get copyWith => _NumToStringAsExponentialCopyWithImpl(
          this as NumToStringAsExponential, $identity, $identity);
  @override
  String toString() {
    return NumToStringAsExponentialMapper.ensureInitialized()
        .stringifyValue(this as NumToStringAsExponential);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumToStringAsExponentialMapper.ensureInitialized()
                .isValueEqual(this as NumToStringAsExponential, other));
  }

  @override
  int get hashCode {
    return NumToStringAsExponentialMapper.ensureInitialized()
        .hashValue(this as NumToStringAsExponential);
  }
}

extension NumToStringAsExponentialValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumToStringAsExponential, $Out> {
  NumToStringAsExponentialCopyWith<$R, NumToStringAsExponential, $Out>
      get $asNumToStringAsExponential => $base
          .as((v, t, t2) => _NumToStringAsExponentialCopyWithImpl(v, t, t2));
}

abstract class NumToStringAsExponentialCopyWith<
    $R,
    $In extends NumToStringAsExponential,
    $Out> implements BaseNodeCopyWith<$R, $In, $Out> {
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
  NumToStringAsExponentialCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NumToStringAsExponentialCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumToStringAsExponential, $Out>
    implements
        NumToStringAsExponentialCopyWith<$R, NumToStringAsExponential, $Out> {
  _NumToStringAsExponentialCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumToStringAsExponential> $mapper =
      NumToStringAsExponentialMapper.ensureInitialized();
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
  NumToStringAsExponential $make(CopyWithData data) => NumToStringAsExponential(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumToStringAsExponentialCopyWith<$R2, NumToStringAsExponential, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _NumToStringAsExponentialCopyWithImpl($value, $cast, t);
}
