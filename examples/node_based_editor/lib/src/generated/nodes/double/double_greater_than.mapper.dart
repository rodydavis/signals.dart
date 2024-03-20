// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_greater_than.dart';

class DoubleGreaterThanMapper extends SubClassMapperBase<DoubleGreaterThan> {
  DoubleGreaterThanMapper._();

  static DoubleGreaterThanMapper? _instance;
  static DoubleGreaterThanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleGreaterThanMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleGreaterThan';

  static int _$id(DoubleGreaterThan v) => v.id;
  static const Field<DoubleGreaterThan, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleGreaterThan v) =>
      v.inputs;
  static const Field<DoubleGreaterThan, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleGreaterThan v) => v.offset;
  static const Field<DoubleGreaterThan, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleGreaterThan v) => v.label;
  static const Field<DoubleGreaterThan, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleGreaterThan v) => v.expanded;
  static const Field<DoubleGreaterThan, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleGreaterThan v) => v.getNode;
  static const Field<DoubleGreaterThan, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleGreaterThan> fields = const {
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
  final dynamic discriminatorValue = 'double_greater_than';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleGreaterThan _instantiate(DecodingData data) {
    return DoubleGreaterThan(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleGreaterThan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleGreaterThan>(map);
  }

  static DoubleGreaterThan fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleGreaterThan>(json);
  }
}

mixin DoubleGreaterThanMappable {
  String toJson() {
    return DoubleGreaterThanMapper.ensureInitialized()
        .encodeJson<DoubleGreaterThan>(this as DoubleGreaterThan);
  }

  Map<String, dynamic> toMap() {
    return DoubleGreaterThanMapper.ensureInitialized()
        .encodeMap<DoubleGreaterThan>(this as DoubleGreaterThan);
  }

  DoubleGreaterThanCopyWith<DoubleGreaterThan, DoubleGreaterThan,
          DoubleGreaterThan>
      get copyWith => _DoubleGreaterThanCopyWithImpl(
          this as DoubleGreaterThan, $identity, $identity);
  @override
  String toString() {
    return DoubleGreaterThanMapper.ensureInitialized()
        .stringifyValue(this as DoubleGreaterThan);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleGreaterThanMapper.ensureInitialized()
                .isValueEqual(this as DoubleGreaterThan, other));
  }

  @override
  int get hashCode {
    return DoubleGreaterThanMapper.ensureInitialized()
        .hashValue(this as DoubleGreaterThan);
  }
}

extension DoubleGreaterThanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleGreaterThan, $Out> {
  DoubleGreaterThanCopyWith<$R, DoubleGreaterThan, $Out>
      get $asDoubleGreaterThan =>
          $base.as((v, t, t2) => _DoubleGreaterThanCopyWithImpl(v, t, t2));
}

abstract class DoubleGreaterThanCopyWith<$R, $In extends DoubleGreaterThan,
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
  DoubleGreaterThanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleGreaterThanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleGreaterThan, $Out>
    implements DoubleGreaterThanCopyWith<$R, DoubleGreaterThan, $Out> {
  _DoubleGreaterThanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleGreaterThan> $mapper =
      DoubleGreaterThanMapper.ensureInitialized();
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
  DoubleGreaterThan $make(CopyWithData data) => DoubleGreaterThan(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleGreaterThanCopyWith<$R2, DoubleGreaterThan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleGreaterThanCopyWithImpl($value, $cast, t);
}
