// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_less_than.dart';

class IntLessThanMapper extends SubClassMapperBase<IntLessThan> {
  IntLessThanMapper._();

  static IntLessThanMapper? _instance;
  static IntLessThanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntLessThanMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntLessThan';

  static int _$id(IntLessThan v) => v.id;
  static const Field<IntLessThan, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntLessThan v) => v.inputs;
  static const Field<IntLessThan, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntLessThan v) => v.offset;
  static const Field<IntLessThan, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntLessThan v) => v.label;
  static const Field<IntLessThan, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntLessThan v) => v.expanded;
  static const Field<IntLessThan, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntLessThan v) => v.getNode;
  static const Field<IntLessThan, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntLessThan> fields = const {
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
  final dynamic discriminatorValue = 'int_less_than';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntLessThan _instantiate(DecodingData data) {
    return IntLessThan(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntLessThan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntLessThan>(map);
  }

  static IntLessThan fromJson(String json) {
    return ensureInitialized().decodeJson<IntLessThan>(json);
  }
}

mixin IntLessThanMappable {
  String toJson() {
    return IntLessThanMapper.ensureInitialized()
        .encodeJson<IntLessThan>(this as IntLessThan);
  }

  Map<String, dynamic> toMap() {
    return IntLessThanMapper.ensureInitialized()
        .encodeMap<IntLessThan>(this as IntLessThan);
  }

  IntLessThanCopyWith<IntLessThan, IntLessThan, IntLessThan> get copyWith =>
      _IntLessThanCopyWithImpl(this as IntLessThan, $identity, $identity);
  @override
  String toString() {
    return IntLessThanMapper.ensureInitialized()
        .stringifyValue(this as IntLessThan);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntLessThanMapper.ensureInitialized()
                .isValueEqual(this as IntLessThan, other));
  }

  @override
  int get hashCode {
    return IntLessThanMapper.ensureInitialized().hashValue(this as IntLessThan);
  }
}

extension IntLessThanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntLessThan, $Out> {
  IntLessThanCopyWith<$R, IntLessThan, $Out> get $asIntLessThan =>
      $base.as((v, t, t2) => _IntLessThanCopyWithImpl(v, t, t2));
}

abstract class IntLessThanCopyWith<$R, $In extends IntLessThan, $Out>
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
  IntLessThanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntLessThanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntLessThan, $Out>
    implements IntLessThanCopyWith<$R, IntLessThan, $Out> {
  _IntLessThanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntLessThan> $mapper =
      IntLessThanMapper.ensureInitialized();
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
  IntLessThan $make(CopyWithData data) => IntLessThan(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntLessThanCopyWith<$R2, IntLessThan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntLessThanCopyWithImpl($value, $cast, t);
}
