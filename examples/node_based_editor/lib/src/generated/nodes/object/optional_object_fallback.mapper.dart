// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'optional_object_fallback.dart';

class OptionalObjectFallbackMapper
    extends SubClassMapperBase<OptionalObjectFallback> {
  OptionalObjectFallbackMapper._();

  static OptionalObjectFallbackMapper? _instance;
  static OptionalObjectFallbackMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OptionalObjectFallbackMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'OptionalObjectFallback';

  static int _$id(OptionalObjectFallback v) => v.id;
  static const Field<OptionalObjectFallback, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(OptionalObjectFallback v) =>
      v.inputs;
  static const Field<OptionalObjectFallback, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(OptionalObjectFallback v) => v.offset;
  static const Field<OptionalObjectFallback, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(OptionalObjectFallback v) => v.label;
  static const Field<OptionalObjectFallback, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(OptionalObjectFallback v) => v.expanded;
  static const Field<OptionalObjectFallback, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(OptionalObjectFallback v) =>
      v.getNode;
  static const Field<OptionalObjectFallback, BaseNode Function(int)>
      _f$getNode = Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<OptionalObjectFallback> fields = const {
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
  final dynamic discriminatorValue = 'optional_object_fallback';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static OptionalObjectFallback _instantiate(DecodingData data) {
    return OptionalObjectFallback(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static OptionalObjectFallback fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OptionalObjectFallback>(map);
  }

  static OptionalObjectFallback fromJson(String json) {
    return ensureInitialized().decodeJson<OptionalObjectFallback>(json);
  }
}

mixin OptionalObjectFallbackMappable {
  String toJson() {
    return OptionalObjectFallbackMapper.ensureInitialized()
        .encodeJson<OptionalObjectFallback>(this as OptionalObjectFallback);
  }

  Map<String, dynamic> toMap() {
    return OptionalObjectFallbackMapper.ensureInitialized()
        .encodeMap<OptionalObjectFallback>(this as OptionalObjectFallback);
  }

  OptionalObjectFallbackCopyWith<OptionalObjectFallback, OptionalObjectFallback,
          OptionalObjectFallback>
      get copyWith => _OptionalObjectFallbackCopyWithImpl(
          this as OptionalObjectFallback, $identity, $identity);
  @override
  String toString() {
    return OptionalObjectFallbackMapper.ensureInitialized()
        .stringifyValue(this as OptionalObjectFallback);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            OptionalObjectFallbackMapper.ensureInitialized()
                .isValueEqual(this as OptionalObjectFallback, other));
  }

  @override
  int get hashCode {
    return OptionalObjectFallbackMapper.ensureInitialized()
        .hashValue(this as OptionalObjectFallback);
  }
}

extension OptionalObjectFallbackValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OptionalObjectFallback, $Out> {
  OptionalObjectFallbackCopyWith<$R, OptionalObjectFallback, $Out>
      get $asOptionalObjectFallback =>
          $base.as((v, t, t2) => _OptionalObjectFallbackCopyWithImpl(v, t, t2));
}

abstract class OptionalObjectFallbackCopyWith<
    $R,
    $In extends OptionalObjectFallback,
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
  OptionalObjectFallbackCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _OptionalObjectFallbackCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OptionalObjectFallback, $Out>
    implements
        OptionalObjectFallbackCopyWith<$R, OptionalObjectFallback, $Out> {
  _OptionalObjectFallbackCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OptionalObjectFallback> $mapper =
      OptionalObjectFallbackMapper.ensureInitialized();
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
  OptionalObjectFallback $make(CopyWithData data) => OptionalObjectFallback(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  OptionalObjectFallbackCopyWith<$R2, OptionalObjectFallback, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _OptionalObjectFallbackCopyWithImpl($value, $cast, t);
}
