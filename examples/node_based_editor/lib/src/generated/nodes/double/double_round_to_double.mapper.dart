// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_round_to_double.dart';

class DoubleRoundToDoubleMapper
    extends SubClassMapperBase<DoubleRoundToDouble> {
  DoubleRoundToDoubleMapper._();

  static DoubleRoundToDoubleMapper? _instance;
  static DoubleRoundToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleRoundToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleRoundToDouble';

  static int _$id(DoubleRoundToDouble v) => v.id;
  static const Field<DoubleRoundToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleRoundToDouble v) =>
      v.inputs;
  static const Field<DoubleRoundToDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleRoundToDouble v) => v.offset;
  static const Field<DoubleRoundToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleRoundToDouble v) => v.label;
  static const Field<DoubleRoundToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleRoundToDouble v) => v.expanded;
  static const Field<DoubleRoundToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleRoundToDouble v) => v.getNode;
  static const Field<DoubleRoundToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleRoundToDouble> fields = const {
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
  final dynamic discriminatorValue = 'double_round_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleRoundToDouble _instantiate(DecodingData data) {
    return DoubleRoundToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleRoundToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleRoundToDouble>(map);
  }

  static DoubleRoundToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleRoundToDouble>(json);
  }
}

mixin DoubleRoundToDoubleMappable {
  String toJson() {
    return DoubleRoundToDoubleMapper.ensureInitialized()
        .encodeJson<DoubleRoundToDouble>(this as DoubleRoundToDouble);
  }

  Map<String, dynamic> toMap() {
    return DoubleRoundToDoubleMapper.ensureInitialized()
        .encodeMap<DoubleRoundToDouble>(this as DoubleRoundToDouble);
  }

  DoubleRoundToDoubleCopyWith<DoubleRoundToDouble, DoubleRoundToDouble,
          DoubleRoundToDouble>
      get copyWith => _DoubleRoundToDoubleCopyWithImpl(
          this as DoubleRoundToDouble, $identity, $identity);
  @override
  String toString() {
    return DoubleRoundToDoubleMapper.ensureInitialized()
        .stringifyValue(this as DoubleRoundToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleRoundToDoubleMapper.ensureInitialized()
                .isValueEqual(this as DoubleRoundToDouble, other));
  }

  @override
  int get hashCode {
    return DoubleRoundToDoubleMapper.ensureInitialized()
        .hashValue(this as DoubleRoundToDouble);
  }
}

extension DoubleRoundToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleRoundToDouble, $Out> {
  DoubleRoundToDoubleCopyWith<$R, DoubleRoundToDouble, $Out>
      get $asDoubleRoundToDouble =>
          $base.as((v, t, t2) => _DoubleRoundToDoubleCopyWithImpl(v, t, t2));
}

abstract class DoubleRoundToDoubleCopyWith<$R, $In extends DoubleRoundToDouble,
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
  DoubleRoundToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleRoundToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleRoundToDouble, $Out>
    implements DoubleRoundToDoubleCopyWith<$R, DoubleRoundToDouble, $Out> {
  _DoubleRoundToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleRoundToDouble> $mapper =
      DoubleRoundToDoubleMapper.ensureInitialized();
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
  DoubleRoundToDouble $make(CopyWithData data) => DoubleRoundToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleRoundToDoubleCopyWith<$R2, DoubleRoundToDouble, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DoubleRoundToDoubleCopyWithImpl($value, $cast, t);
}
