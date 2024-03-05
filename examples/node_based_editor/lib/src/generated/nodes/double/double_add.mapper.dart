// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_add.dart';

class DoubleAddMapper extends SubClassMapperBase<DoubleAdd> {
  DoubleAddMapper._();

  static DoubleAddMapper? _instance;
  static DoubleAddMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleAddMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleAdd';

  static int _$id(DoubleAdd v) => v.id;
  static const Field<DoubleAdd, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleAdd v) => v.inputs;
  static const Field<DoubleAdd, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleAdd v) => v.offset;
  static const Field<DoubleAdd, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleAdd v) => v.label;
  static const Field<DoubleAdd, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleAdd v) => v.expanded;
  static const Field<DoubleAdd, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleAdd v) => v.getNode;
  static const Field<DoubleAdd, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleAdd> fields = const {
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
  final dynamic discriminatorValue = 'double_add';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleAdd _instantiate(DecodingData data) {
    return DoubleAdd(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleAdd fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleAdd>(map);
  }

  static DoubleAdd fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleAdd>(json);
  }
}

mixin DoubleAddMappable {
  String toJson() {
    return DoubleAddMapper.ensureInitialized()
        .encodeJson<DoubleAdd>(this as DoubleAdd);
  }

  Map<String, dynamic> toMap() {
    return DoubleAddMapper.ensureInitialized()
        .encodeMap<DoubleAdd>(this as DoubleAdd);
  }

  DoubleAddCopyWith<DoubleAdd, DoubleAdd, DoubleAdd> get copyWith =>
      _DoubleAddCopyWithImpl(this as DoubleAdd, $identity, $identity);
  @override
  String toString() {
    return DoubleAddMapper.ensureInitialized()
        .stringifyValue(this as DoubleAdd);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleAddMapper.ensureInitialized()
                .isValueEqual(this as DoubleAdd, other));
  }

  @override
  int get hashCode {
    return DoubleAddMapper.ensureInitialized().hashValue(this as DoubleAdd);
  }
}

extension DoubleAddValueCopy<$R, $Out> on ObjectCopyWith<$R, DoubleAdd, $Out> {
  DoubleAddCopyWith<$R, DoubleAdd, $Out> get $asDoubleAdd =>
      $base.as((v, t, t2) => _DoubleAddCopyWithImpl(v, t, t2));
}

abstract class DoubleAddCopyWith<$R, $In extends DoubleAdd, $Out>
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
  DoubleAddCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleAddCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleAdd, $Out>
    implements DoubleAddCopyWith<$R, DoubleAdd, $Out> {
  _DoubleAddCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleAdd> $mapper =
      DoubleAddMapper.ensureInitialized();
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
  DoubleAdd $make(CopyWithData data) => DoubleAdd(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleAddCopyWith<$R2, DoubleAdd, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleAddCopyWithImpl($value, $cast, t);
}
