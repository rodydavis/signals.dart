// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_is_odd.dart';

class IntIsOddMapper extends SubClassMapperBase<IntIsOdd> {
  IntIsOddMapper._();

  static IntIsOddMapper? _instance;
  static IntIsOddMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntIsOddMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntIsOdd';

  static int _$id(IntIsOdd v) => v.id;
  static const Field<IntIsOdd, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntIsOdd v) => v.inputs;
  static const Field<IntIsOdd, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntIsOdd v) => v.offset;
  static const Field<IntIsOdd, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntIsOdd v) => v.label;
  static const Field<IntIsOdd, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntIsOdd v) => v.expanded;
  static const Field<IntIsOdd, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntIsOdd v) => v.getNode;
  static const Field<IntIsOdd, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntIsOdd> fields = const {
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
  final dynamic discriminatorValue = 'int_is_odd';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntIsOdd _instantiate(DecodingData data) {
    return IntIsOdd(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntIsOdd fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntIsOdd>(map);
  }

  static IntIsOdd fromJson(String json) {
    return ensureInitialized().decodeJson<IntIsOdd>(json);
  }
}

mixin IntIsOddMappable {
  String toJson() {
    return IntIsOddMapper.ensureInitialized()
        .encodeJson<IntIsOdd>(this as IntIsOdd);
  }

  Map<String, dynamic> toMap() {
    return IntIsOddMapper.ensureInitialized()
        .encodeMap<IntIsOdd>(this as IntIsOdd);
  }

  IntIsOddCopyWith<IntIsOdd, IntIsOdd, IntIsOdd> get copyWith =>
      _IntIsOddCopyWithImpl(this as IntIsOdd, $identity, $identity);
  @override
  String toString() {
    return IntIsOddMapper.ensureInitialized().stringifyValue(this as IntIsOdd);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntIsOddMapper.ensureInitialized()
                .isValueEqual(this as IntIsOdd, other));
  }

  @override
  int get hashCode {
    return IntIsOddMapper.ensureInitialized().hashValue(this as IntIsOdd);
  }
}

extension IntIsOddValueCopy<$R, $Out> on ObjectCopyWith<$R, IntIsOdd, $Out> {
  IntIsOddCopyWith<$R, IntIsOdd, $Out> get $asIntIsOdd =>
      $base.as((v, t, t2) => _IntIsOddCopyWithImpl(v, t, t2));
}

abstract class IntIsOddCopyWith<$R, $In extends IntIsOdd, $Out>
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
  IntIsOddCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntIsOddCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntIsOdd, $Out>
    implements IntIsOddCopyWith<$R, IntIsOdd, $Out> {
  _IntIsOddCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntIsOdd> $mapper =
      IntIsOddMapper.ensureInitialized();
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
  IntIsOdd $make(CopyWithData data) => IntIsOdd(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntIsOddCopyWith<$R2, IntIsOdd, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntIsOddCopyWithImpl($value, $cast, t);
}
