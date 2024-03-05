// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_to_num.dart';

class DoubleToNumMapper extends SubClassMapperBase<DoubleToNum> {
  DoubleToNumMapper._();

  static DoubleToNumMapper? _instance;
  static DoubleToNumMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleToNumMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleToNum';

  static int _$id(DoubleToNum v) => v.id;
  static const Field<DoubleToNum, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleToNum v) => v.inputs;
  static const Field<DoubleToNum, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleToNum v) => v.offset;
  static const Field<DoubleToNum, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleToNum v) => v.label;
  static const Field<DoubleToNum, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleToNum v) => v.expanded;
  static const Field<DoubleToNum, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleToNum v) => v.getNode;
  static const Field<DoubleToNum, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleToNum> fields = const {
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
  final dynamic discriminatorValue = 'double_to_num';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleToNum _instantiate(DecodingData data) {
    return DoubleToNum(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleToNum fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleToNum>(map);
  }

  static DoubleToNum fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleToNum>(json);
  }
}

mixin DoubleToNumMappable {
  String toJson() {
    return DoubleToNumMapper.ensureInitialized()
        .encodeJson<DoubleToNum>(this as DoubleToNum);
  }

  Map<String, dynamic> toMap() {
    return DoubleToNumMapper.ensureInitialized()
        .encodeMap<DoubleToNum>(this as DoubleToNum);
  }

  DoubleToNumCopyWith<DoubleToNum, DoubleToNum, DoubleToNum> get copyWith =>
      _DoubleToNumCopyWithImpl(this as DoubleToNum, $identity, $identity);
  @override
  String toString() {
    return DoubleToNumMapper.ensureInitialized()
        .stringifyValue(this as DoubleToNum);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleToNumMapper.ensureInitialized()
                .isValueEqual(this as DoubleToNum, other));
  }

  @override
  int get hashCode {
    return DoubleToNumMapper.ensureInitialized().hashValue(this as DoubleToNum);
  }
}

extension DoubleToNumValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleToNum, $Out> {
  DoubleToNumCopyWith<$R, DoubleToNum, $Out> get $asDoubleToNum =>
      $base.as((v, t, t2) => _DoubleToNumCopyWithImpl(v, t, t2));
}

abstract class DoubleToNumCopyWith<$R, $In extends DoubleToNum, $Out>
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
  DoubleToNumCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleToNumCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleToNum, $Out>
    implements DoubleToNumCopyWith<$R, DoubleToNum, $Out> {
  _DoubleToNumCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleToNum> $mapper =
      DoubleToNumMapper.ensureInitialized();
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
  DoubleToNum $make(CopyWithData data) => DoubleToNum(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleToNumCopyWith<$R2, DoubleToNum, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleToNumCopyWithImpl($value, $cast, t);
}
