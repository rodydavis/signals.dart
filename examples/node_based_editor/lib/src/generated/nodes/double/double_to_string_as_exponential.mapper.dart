// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_to_string_as_exponential.dart';

class DoubleToStringAsExponentialMapper
    extends SubClassMapperBase<DoubleToStringAsExponential> {
  DoubleToStringAsExponentialMapper._();

  static DoubleToStringAsExponentialMapper? _instance;
  static DoubleToStringAsExponentialMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = DoubleToStringAsExponentialMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleToStringAsExponential';

  static int _$id(DoubleToStringAsExponential v) => v.id;
  static const Field<DoubleToStringAsExponential, int> _f$id =
      Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(
          DoubleToStringAsExponential v) =>
      v.inputs;
  static const Field<DoubleToStringAsExponential,
      Map<String, NodeInput<dynamic>>> _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleToStringAsExponential v) => v.offset;
  static const Field<DoubleToStringAsExponential, Signal<NodeOffset>>
      _f$offset = Field('offset', _$offset);
  static Signal<String> _$label(DoubleToStringAsExponential v) => v.label;
  static const Field<DoubleToStringAsExponential, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleToStringAsExponential v) => v.expanded;
  static const Field<DoubleToStringAsExponential, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleToStringAsExponential v) =>
      v.getNode;
  static const Field<DoubleToStringAsExponential, BaseNode Function(int)>
      _f$getNode = Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleToStringAsExponential> fields = const {
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
  final dynamic discriminatorValue = 'double_to_string_as_exponential';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleToStringAsExponential _instantiate(DecodingData data) {
    return DoubleToStringAsExponential(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleToStringAsExponential fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleToStringAsExponential>(map);
  }

  static DoubleToStringAsExponential fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleToStringAsExponential>(json);
  }
}

mixin DoubleToStringAsExponentialMappable {
  String toJson() {
    return DoubleToStringAsExponentialMapper.ensureInitialized()
        .encodeJson<DoubleToStringAsExponential>(
            this as DoubleToStringAsExponential);
  }

  Map<String, dynamic> toMap() {
    return DoubleToStringAsExponentialMapper.ensureInitialized()
        .encodeMap<DoubleToStringAsExponential>(
            this as DoubleToStringAsExponential);
  }

  DoubleToStringAsExponentialCopyWith<DoubleToStringAsExponential,
          DoubleToStringAsExponential, DoubleToStringAsExponential>
      get copyWith => _DoubleToStringAsExponentialCopyWithImpl(
          this as DoubleToStringAsExponential, $identity, $identity);
  @override
  String toString() {
    return DoubleToStringAsExponentialMapper.ensureInitialized()
        .stringifyValue(this as DoubleToStringAsExponential);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleToStringAsExponentialMapper.ensureInitialized()
                .isValueEqual(this as DoubleToStringAsExponential, other));
  }

  @override
  int get hashCode {
    return DoubleToStringAsExponentialMapper.ensureInitialized()
        .hashValue(this as DoubleToStringAsExponential);
  }
}

extension DoubleToStringAsExponentialValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleToStringAsExponential, $Out> {
  DoubleToStringAsExponentialCopyWith<$R, DoubleToStringAsExponential, $Out>
      get $asDoubleToStringAsExponential => $base
          .as((v, t, t2) => _DoubleToStringAsExponentialCopyWithImpl(v, t, t2));
}

abstract class DoubleToStringAsExponentialCopyWith<
    $R,
    $In extends DoubleToStringAsExponential,
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
  DoubleToStringAsExponentialCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleToStringAsExponentialCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleToStringAsExponential, $Out>
    implements
        DoubleToStringAsExponentialCopyWith<$R, DoubleToStringAsExponential,
            $Out> {
  _DoubleToStringAsExponentialCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleToStringAsExponential> $mapper =
      DoubleToStringAsExponentialMapper.ensureInitialized();
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
  DoubleToStringAsExponential $make(CopyWithData data) =>
      DoubleToStringAsExponential(
          id: data.get(#id, or: $value.id),
          inputs: data.get(#inputs, or: $value.inputs),
          offset: data.get(#offset, or: $value.offset),
          label: data.get(#label, or: $value.label),
          expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleToStringAsExponentialCopyWith<$R2, DoubleToStringAsExponential, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DoubleToStringAsExponentialCopyWithImpl($value, $cast, t);
}
