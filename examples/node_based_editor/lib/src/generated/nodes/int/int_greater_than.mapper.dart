// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_greater_than.dart';

class IntGreaterThanMapper extends SubClassMapperBase<IntGreaterThan> {
  IntGreaterThanMapper._();

  static IntGreaterThanMapper? _instance;
  static IntGreaterThanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntGreaterThanMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntGreaterThan';

  static int _$id(IntGreaterThan v) => v.id;
  static const Field<IntGreaterThan, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntGreaterThan v) => v.inputs;
  static const Field<IntGreaterThan, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntGreaterThan v) => v.offset;
  static const Field<IntGreaterThan, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntGreaterThan v) => v.label;
  static const Field<IntGreaterThan, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntGreaterThan v) => v.expanded;
  static const Field<IntGreaterThan, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntGreaterThan v) => v.getNode;
  static const Field<IntGreaterThan, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntGreaterThan> fields = const {
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
  final dynamic discriminatorValue = 'int_greater_than';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntGreaterThan _instantiate(DecodingData data) {
    return IntGreaterThan(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntGreaterThan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntGreaterThan>(map);
  }

  static IntGreaterThan fromJson(String json) {
    return ensureInitialized().decodeJson<IntGreaterThan>(json);
  }
}

mixin IntGreaterThanMappable {
  String toJson() {
    return IntGreaterThanMapper.ensureInitialized()
        .encodeJson<IntGreaterThan>(this as IntGreaterThan);
  }

  Map<String, dynamic> toMap() {
    return IntGreaterThanMapper.ensureInitialized()
        .encodeMap<IntGreaterThan>(this as IntGreaterThan);
  }

  IntGreaterThanCopyWith<IntGreaterThan, IntGreaterThan, IntGreaterThan>
      get copyWith => _IntGreaterThanCopyWithImpl(
          this as IntGreaterThan, $identity, $identity);
  @override
  String toString() {
    return IntGreaterThanMapper.ensureInitialized()
        .stringifyValue(this as IntGreaterThan);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntGreaterThanMapper.ensureInitialized()
                .isValueEqual(this as IntGreaterThan, other));
  }

  @override
  int get hashCode {
    return IntGreaterThanMapper.ensureInitialized()
        .hashValue(this as IntGreaterThan);
  }
}

extension IntGreaterThanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntGreaterThan, $Out> {
  IntGreaterThanCopyWith<$R, IntGreaterThan, $Out> get $asIntGreaterThan =>
      $base.as((v, t, t2) => _IntGreaterThanCopyWithImpl(v, t, t2));
}

abstract class IntGreaterThanCopyWith<$R, $In extends IntGreaterThan, $Out>
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
  IntGreaterThanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntGreaterThanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntGreaterThan, $Out>
    implements IntGreaterThanCopyWith<$R, IntGreaterThan, $Out> {
  _IntGreaterThanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntGreaterThan> $mapper =
      IntGreaterThanMapper.ensureInitialized();
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
  IntGreaterThan $make(CopyWithData data) => IntGreaterThan(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntGreaterThanCopyWith<$R2, IntGreaterThan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntGreaterThanCopyWithImpl($value, $cast, t);
}
