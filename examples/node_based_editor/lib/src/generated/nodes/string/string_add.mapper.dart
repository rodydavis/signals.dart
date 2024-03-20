// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_add.dart';

class StringAddMapper extends SubClassMapperBase<StringAdd> {
  StringAddMapper._();

  static StringAddMapper? _instance;
  static StringAddMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringAddMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringAdd';

  static int _$id(StringAdd v) => v.id;
  static const Field<StringAdd, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringAdd v) => v.inputs;
  static const Field<StringAdd, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringAdd v) => v.offset;
  static const Field<StringAdd, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringAdd v) => v.label;
  static const Field<StringAdd, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringAdd v) => v.expanded;
  static const Field<StringAdd, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringAdd v) => v.getNode;
  static const Field<StringAdd, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringAdd> fields = const {
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
  final dynamic discriminatorValue = 'string_add';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringAdd _instantiate(DecodingData data) {
    return StringAdd(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringAdd fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringAdd>(map);
  }

  static StringAdd fromJson(String json) {
    return ensureInitialized().decodeJson<StringAdd>(json);
  }
}

mixin StringAddMappable {
  String toJson() {
    return StringAddMapper.ensureInitialized()
        .encodeJson<StringAdd>(this as StringAdd);
  }

  Map<String, dynamic> toMap() {
    return StringAddMapper.ensureInitialized()
        .encodeMap<StringAdd>(this as StringAdd);
  }

  StringAddCopyWith<StringAdd, StringAdd, StringAdd> get copyWith =>
      _StringAddCopyWithImpl(this as StringAdd, $identity, $identity);
  @override
  String toString() {
    return StringAddMapper.ensureInitialized()
        .stringifyValue(this as StringAdd);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringAddMapper.ensureInitialized()
                .isValueEqual(this as StringAdd, other));
  }

  @override
  int get hashCode {
    return StringAddMapper.ensureInitialized().hashValue(this as StringAdd);
  }
}

extension StringAddValueCopy<$R, $Out> on ObjectCopyWith<$R, StringAdd, $Out> {
  StringAddCopyWith<$R, StringAdd, $Out> get $asStringAdd =>
      $base.as((v, t, t2) => _StringAddCopyWithImpl(v, t, t2));
}

abstract class StringAddCopyWith<$R, $In extends StringAdd, $Out>
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
  StringAddCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StringAddCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringAdd, $Out>
    implements StringAddCopyWith<$R, StringAdd, $Out> {
  _StringAddCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringAdd> $mapper =
      StringAddMapper.ensureInitialized();
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
  StringAdd $make(CopyWithData data) => StringAdd(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringAddCopyWith<$R2, StringAdd, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringAddCopyWithImpl($value, $cast, t);
}
