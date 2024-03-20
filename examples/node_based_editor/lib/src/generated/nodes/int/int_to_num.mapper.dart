// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_to_num.dart';

class IntToNumMapper extends SubClassMapperBase<IntToNum> {
  IntToNumMapper._();

  static IntToNumMapper? _instance;
  static IntToNumMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntToNumMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntToNum';

  static int _$id(IntToNum v) => v.id;
  static const Field<IntToNum, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntToNum v) => v.inputs;
  static const Field<IntToNum, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntToNum v) => v.offset;
  static const Field<IntToNum, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntToNum v) => v.label;
  static const Field<IntToNum, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntToNum v) => v.expanded;
  static const Field<IntToNum, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntToNum v) => v.getNode;
  static const Field<IntToNum, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntToNum> fields = const {
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
  final dynamic discriminatorValue = 'int_to_num';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntToNum _instantiate(DecodingData data) {
    return IntToNum(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntToNum fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntToNum>(map);
  }

  static IntToNum fromJson(String json) {
    return ensureInitialized().decodeJson<IntToNum>(json);
  }
}

mixin IntToNumMappable {
  String toJson() {
    return IntToNumMapper.ensureInitialized()
        .encodeJson<IntToNum>(this as IntToNum);
  }

  Map<String, dynamic> toMap() {
    return IntToNumMapper.ensureInitialized()
        .encodeMap<IntToNum>(this as IntToNum);
  }

  IntToNumCopyWith<IntToNum, IntToNum, IntToNum> get copyWith =>
      _IntToNumCopyWithImpl(this as IntToNum, $identity, $identity);
  @override
  String toString() {
    return IntToNumMapper.ensureInitialized().stringifyValue(this as IntToNum);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntToNumMapper.ensureInitialized()
                .isValueEqual(this as IntToNum, other));
  }

  @override
  int get hashCode {
    return IntToNumMapper.ensureInitialized().hashValue(this as IntToNum);
  }
}

extension IntToNumValueCopy<$R, $Out> on ObjectCopyWith<$R, IntToNum, $Out> {
  IntToNumCopyWith<$R, IntToNum, $Out> get $asIntToNum =>
      $base.as((v, t, t2) => _IntToNumCopyWithImpl(v, t, t2));
}

abstract class IntToNumCopyWith<$R, $In extends IntToNum, $Out>
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
  IntToNumCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntToNumCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntToNum, $Out>
    implements IntToNumCopyWith<$R, IntToNum, $Out> {
  _IntToNumCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntToNum> $mapper =
      IntToNumMapper.ensureInitialized();
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
  IntToNum $make(CopyWithData data) => IntToNum(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntToNumCopyWith<$R2, IntToNum, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntToNumCopyWithImpl($value, $cast, t);
}
