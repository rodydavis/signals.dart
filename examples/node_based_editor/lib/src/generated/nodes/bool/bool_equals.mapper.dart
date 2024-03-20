// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bool_equals.dart';

class BoolEqualsMapper extends SubClassMapperBase<BoolEquals> {
  BoolEqualsMapper._();

  static BoolEqualsMapper? _instance;
  static BoolEqualsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoolEqualsMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'BoolEquals';

  static int _$id(BoolEquals v) => v.id;
  static const Field<BoolEquals, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(BoolEquals v) => v.inputs;
  static const Field<BoolEquals, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(BoolEquals v) => v.offset;
  static const Field<BoolEquals, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(BoolEquals v) => v.label;
  static const Field<BoolEquals, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(BoolEquals v) => v.expanded;
  static const Field<BoolEquals, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(BoolEquals v) => v.getNode;
  static const Field<BoolEquals, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<BoolEquals> fields = const {
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
  final dynamic discriminatorValue = 'bool_equals';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static BoolEquals _instantiate(DecodingData data) {
    return BoolEquals(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static BoolEquals fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoolEquals>(map);
  }

  static BoolEquals fromJson(String json) {
    return ensureInitialized().decodeJson<BoolEquals>(json);
  }
}

mixin BoolEqualsMappable {
  String toJson() {
    return BoolEqualsMapper.ensureInitialized()
        .encodeJson<BoolEquals>(this as BoolEquals);
  }

  Map<String, dynamic> toMap() {
    return BoolEqualsMapper.ensureInitialized()
        .encodeMap<BoolEquals>(this as BoolEquals);
  }

  BoolEqualsCopyWith<BoolEquals, BoolEquals, BoolEquals> get copyWith =>
      _BoolEqualsCopyWithImpl(this as BoolEquals, $identity, $identity);
  @override
  String toString() {
    return BoolEqualsMapper.ensureInitialized()
        .stringifyValue(this as BoolEquals);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BoolEqualsMapper.ensureInitialized()
                .isValueEqual(this as BoolEquals, other));
  }

  @override
  int get hashCode {
    return BoolEqualsMapper.ensureInitialized().hashValue(this as BoolEquals);
  }
}

extension BoolEqualsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoolEquals, $Out> {
  BoolEqualsCopyWith<$R, BoolEquals, $Out> get $asBoolEquals =>
      $base.as((v, t, t2) => _BoolEqualsCopyWithImpl(v, t, t2));
}

abstract class BoolEqualsCopyWith<$R, $In extends BoolEquals, $Out>
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
  BoolEqualsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BoolEqualsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoolEquals, $Out>
    implements BoolEqualsCopyWith<$R, BoolEquals, $Out> {
  _BoolEqualsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoolEquals> $mapper =
      BoolEqualsMapper.ensureInitialized();
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
  BoolEquals $make(CopyWithData data) => BoolEquals(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  BoolEqualsCopyWith<$R2, BoolEquals, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoolEqualsCopyWithImpl($value, $cast, t);
}
