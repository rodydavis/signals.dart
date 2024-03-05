// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_add.dart';

class NumAddMapper extends SubClassMapperBase<NumAdd> {
  NumAddMapper._();

  static NumAddMapper? _instance;
  static NumAddMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumAddMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumAdd';

  static int _$id(NumAdd v) => v.id;
  static const Field<NumAdd, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumAdd v) => v.inputs;
  static const Field<NumAdd, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumAdd v) => v.offset;
  static const Field<NumAdd, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumAdd v) => v.label;
  static const Field<NumAdd, Signal<String>> _f$label = Field('label', _$label);
  static Signal<bool> _$expanded(NumAdd v) => v.expanded;
  static const Field<NumAdd, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumAdd v) => v.getNode;
  static const Field<NumAdd, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumAdd> fields = const {
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
  final dynamic discriminatorValue = 'num_add';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumAdd _instantiate(DecodingData data) {
    return NumAdd(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumAdd fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumAdd>(map);
  }

  static NumAdd fromJson(String json) {
    return ensureInitialized().decodeJson<NumAdd>(json);
  }
}

mixin NumAddMappable {
  String toJson() {
    return NumAddMapper.ensureInitialized().encodeJson<NumAdd>(this as NumAdd);
  }

  Map<String, dynamic> toMap() {
    return NumAddMapper.ensureInitialized().encodeMap<NumAdd>(this as NumAdd);
  }

  NumAddCopyWith<NumAdd, NumAdd, NumAdd> get copyWith =>
      _NumAddCopyWithImpl(this as NumAdd, $identity, $identity);
  @override
  String toString() {
    return NumAddMapper.ensureInitialized().stringifyValue(this as NumAdd);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumAddMapper.ensureInitialized()
                .isValueEqual(this as NumAdd, other));
  }

  @override
  int get hashCode {
    return NumAddMapper.ensureInitialized().hashValue(this as NumAdd);
  }
}

extension NumAddValueCopy<$R, $Out> on ObjectCopyWith<$R, NumAdd, $Out> {
  NumAddCopyWith<$R, NumAdd, $Out> get $asNumAdd =>
      $base.as((v, t, t2) => _NumAddCopyWithImpl(v, t, t2));
}

abstract class NumAddCopyWith<$R, $In extends NumAdd, $Out>
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
  NumAddCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumAddCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, NumAdd, $Out>
    implements NumAddCopyWith<$R, NumAdd, $Out> {
  _NumAddCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumAdd> $mapper = NumAddMapper.ensureInitialized();
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
  NumAdd $make(CopyWithData data) => NumAdd(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumAddCopyWith<$R2, NumAdd, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NumAddCopyWithImpl($value, $cast, t);
}
