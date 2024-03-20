// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_less_than.dart';

class NumLessThanMapper extends SubClassMapperBase<NumLessThan> {
  NumLessThanMapper._();

  static NumLessThanMapper? _instance;
  static NumLessThanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumLessThanMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumLessThan';

  static int _$id(NumLessThan v) => v.id;
  static const Field<NumLessThan, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumLessThan v) => v.inputs;
  static const Field<NumLessThan, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumLessThan v) => v.offset;
  static const Field<NumLessThan, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumLessThan v) => v.label;
  static const Field<NumLessThan, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumLessThan v) => v.expanded;
  static const Field<NumLessThan, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumLessThan v) => v.getNode;
  static const Field<NumLessThan, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumLessThan> fields = const {
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
  final dynamic discriminatorValue = 'num_less_than';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumLessThan _instantiate(DecodingData data) {
    return NumLessThan(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumLessThan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumLessThan>(map);
  }

  static NumLessThan fromJson(String json) {
    return ensureInitialized().decodeJson<NumLessThan>(json);
  }
}

mixin NumLessThanMappable {
  String toJson() {
    return NumLessThanMapper.ensureInitialized()
        .encodeJson<NumLessThan>(this as NumLessThan);
  }

  Map<String, dynamic> toMap() {
    return NumLessThanMapper.ensureInitialized()
        .encodeMap<NumLessThan>(this as NumLessThan);
  }

  NumLessThanCopyWith<NumLessThan, NumLessThan, NumLessThan> get copyWith =>
      _NumLessThanCopyWithImpl(this as NumLessThan, $identity, $identity);
  @override
  String toString() {
    return NumLessThanMapper.ensureInitialized()
        .stringifyValue(this as NumLessThan);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumLessThanMapper.ensureInitialized()
                .isValueEqual(this as NumLessThan, other));
  }

  @override
  int get hashCode {
    return NumLessThanMapper.ensureInitialized().hashValue(this as NumLessThan);
  }
}

extension NumLessThanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumLessThan, $Out> {
  NumLessThanCopyWith<$R, NumLessThan, $Out> get $asNumLessThan =>
      $base.as((v, t, t2) => _NumLessThanCopyWithImpl(v, t, t2));
}

abstract class NumLessThanCopyWith<$R, $In extends NumLessThan, $Out>
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
  NumLessThanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumLessThanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumLessThan, $Out>
    implements NumLessThanCopyWith<$R, NumLessThan, $Out> {
  _NumLessThanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumLessThan> $mapper =
      NumLessThanMapper.ensureInitialized();
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
  NumLessThan $make(CopyWithData data) => NumLessThan(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumLessThanCopyWith<$R2, NumLessThan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumLessThanCopyWithImpl($value, $cast, t);
}
