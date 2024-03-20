// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_truncate_to_double.dart';

class IntTruncateToDoubleMapper
    extends SubClassMapperBase<IntTruncateToDouble> {
  IntTruncateToDoubleMapper._();

  static IntTruncateToDoubleMapper? _instance;
  static IntTruncateToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntTruncateToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntTruncateToDouble';

  static int _$id(IntTruncateToDouble v) => v.id;
  static const Field<IntTruncateToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntTruncateToDouble v) =>
      v.inputs;
  static const Field<IntTruncateToDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntTruncateToDouble v) => v.offset;
  static const Field<IntTruncateToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntTruncateToDouble v) => v.label;
  static const Field<IntTruncateToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntTruncateToDouble v) => v.expanded;
  static const Field<IntTruncateToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntTruncateToDouble v) => v.getNode;
  static const Field<IntTruncateToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntTruncateToDouble> fields = const {
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
  final dynamic discriminatorValue = 'int_truncate_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntTruncateToDouble _instantiate(DecodingData data) {
    return IntTruncateToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntTruncateToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntTruncateToDouble>(map);
  }

  static IntTruncateToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<IntTruncateToDouble>(json);
  }
}

mixin IntTruncateToDoubleMappable {
  String toJson() {
    return IntTruncateToDoubleMapper.ensureInitialized()
        .encodeJson<IntTruncateToDouble>(this as IntTruncateToDouble);
  }

  Map<String, dynamic> toMap() {
    return IntTruncateToDoubleMapper.ensureInitialized()
        .encodeMap<IntTruncateToDouble>(this as IntTruncateToDouble);
  }

  IntTruncateToDoubleCopyWith<IntTruncateToDouble, IntTruncateToDouble,
          IntTruncateToDouble>
      get copyWith => _IntTruncateToDoubleCopyWithImpl(
          this as IntTruncateToDouble, $identity, $identity);
  @override
  String toString() {
    return IntTruncateToDoubleMapper.ensureInitialized()
        .stringifyValue(this as IntTruncateToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntTruncateToDoubleMapper.ensureInitialized()
                .isValueEqual(this as IntTruncateToDouble, other));
  }

  @override
  int get hashCode {
    return IntTruncateToDoubleMapper.ensureInitialized()
        .hashValue(this as IntTruncateToDouble);
  }
}

extension IntTruncateToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntTruncateToDouble, $Out> {
  IntTruncateToDoubleCopyWith<$R, IntTruncateToDouble, $Out>
      get $asIntTruncateToDouble =>
          $base.as((v, t, t2) => _IntTruncateToDoubleCopyWithImpl(v, t, t2));
}

abstract class IntTruncateToDoubleCopyWith<$R, $In extends IntTruncateToDouble,
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
  IntTruncateToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntTruncateToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntTruncateToDouble, $Out>
    implements IntTruncateToDoubleCopyWith<$R, IntTruncateToDouble, $Out> {
  _IntTruncateToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntTruncateToDouble> $mapper =
      IntTruncateToDoubleMapper.ensureInitialized();
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
  IntTruncateToDouble $make(CopyWithData data) => IntTruncateToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntTruncateToDoubleCopyWith<$R2, IntTruncateToDouble, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _IntTruncateToDoubleCopyWithImpl($value, $cast, t);
}
