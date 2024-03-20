// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_less_than.dart';

class DoubleLessThanMapper extends SubClassMapperBase<DoubleLessThan> {
  DoubleLessThanMapper._();

  static DoubleLessThanMapper? _instance;
  static DoubleLessThanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleLessThanMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleLessThan';

  static int _$id(DoubleLessThan v) => v.id;
  static const Field<DoubleLessThan, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleLessThan v) => v.inputs;
  static const Field<DoubleLessThan, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleLessThan v) => v.offset;
  static const Field<DoubleLessThan, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleLessThan v) => v.label;
  static const Field<DoubleLessThan, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleLessThan v) => v.expanded;
  static const Field<DoubleLessThan, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleLessThan v) => v.getNode;
  static const Field<DoubleLessThan, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleLessThan> fields = const {
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
  final dynamic discriminatorValue = 'double_less_than';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleLessThan _instantiate(DecodingData data) {
    return DoubleLessThan(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleLessThan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleLessThan>(map);
  }

  static DoubleLessThan fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleLessThan>(json);
  }
}

mixin DoubleLessThanMappable {
  String toJson() {
    return DoubleLessThanMapper.ensureInitialized()
        .encodeJson<DoubleLessThan>(this as DoubleLessThan);
  }

  Map<String, dynamic> toMap() {
    return DoubleLessThanMapper.ensureInitialized()
        .encodeMap<DoubleLessThan>(this as DoubleLessThan);
  }

  DoubleLessThanCopyWith<DoubleLessThan, DoubleLessThan, DoubleLessThan>
      get copyWith => _DoubleLessThanCopyWithImpl(
          this as DoubleLessThan, $identity, $identity);
  @override
  String toString() {
    return DoubleLessThanMapper.ensureInitialized()
        .stringifyValue(this as DoubleLessThan);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleLessThanMapper.ensureInitialized()
                .isValueEqual(this as DoubleLessThan, other));
  }

  @override
  int get hashCode {
    return DoubleLessThanMapper.ensureInitialized()
        .hashValue(this as DoubleLessThan);
  }
}

extension DoubleLessThanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleLessThan, $Out> {
  DoubleLessThanCopyWith<$R, DoubleLessThan, $Out> get $asDoubleLessThan =>
      $base.as((v, t, t2) => _DoubleLessThanCopyWithImpl(v, t, t2));
}

abstract class DoubleLessThanCopyWith<$R, $In extends DoubleLessThan, $Out>
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
  DoubleLessThanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleLessThanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleLessThan, $Out>
    implements DoubleLessThanCopyWith<$R, DoubleLessThan, $Out> {
  _DoubleLessThanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleLessThan> $mapper =
      DoubleLessThanMapper.ensureInitialized();
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
  DoubleLessThan $make(CopyWithData data) => DoubleLessThan(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleLessThanCopyWith<$R2, DoubleLessThan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleLessThanCopyWithImpl($value, $cast, t);
}
