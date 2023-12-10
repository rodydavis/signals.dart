import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:signals/signals.dart';

typedef $Node = ({
  int id,
  String type,
  String? label,
  String? value,
  String? sources,
  String? targets,
});

final nodes = listSignal<$Node>([]);

void initNodes() {
  refreshNodes().ignore();
  serviceManager.service?.onExtensionEvent
      .where((e) => e.extensionKind?.startsWith('ext.signals') ?? false)
      .listen((event) {
    final kind = event.extensionKind;
    final data = event.extensionData?.data ?? {};
    switch (kind) {
      case 'ext.signals.signalCreate':
      case 'ext.signals.signalUpdate':
      case 'ext.signals.computedCreate':
      case 'ext.signals.computedUpdate':
      case 'ext.signals.effectCreate':
      case 'ext.signals.effectCalled':
      case 'ext.signals.effectRemove':
        final item = parseNode(data);
        final idx = nodes.indexWhere(
          (e) => e.id == item.id && e.type == item.type,
        );
        if (idx == -1) {
          nodes.add(item);
        } else {
          nodes[idx] = item;
        }
        if (item.value == '-1' && item.type == 'effect') {
          nodes.removeWhere((e) => e.id == item.id);
        }
        break;
      default:
    }
  });
}

Stream<$Node> onSignalCreated() async* {
  final source = serviceManager.service?.onExtensionEvent
      .where((e) => e.extensionKind == 'ext.signals.signalCreate');
  if (source == null) return;
  await for (final event in source) {
    final data = event.extensionData?.data ?? {};
    yield parseNode(data);
  }
}

Stream<$Node> onSignalUpdated() async* {
  final source = serviceManager.service?.onExtensionEvent
      .where((e) => e.extensionKind == 'ext.signals.signalUpdate');
  if (source == null) return;
  await for (final event in source) {
    final data = event.extensionData?.data ?? {};
    yield parseNode(data);
  }
}

Stream<$Node> onComputedCreated() async* {
  final source = serviceManager.service?.onExtensionEvent
      .where((e) => e.extensionKind == 'ext.signals.computedCreate');
  if (source == null) return;
  await for (final event in source) {
    final data = event.extensionData?.data ?? {};
    yield parseNode(data);
  }
}

Stream<$Node> onComputedUpdated() async* {
  final source = serviceManager.service?.onExtensionEvent
      .where((e) => e.extensionKind == 'ext.signals.computedUpdate');
  if (source == null) return;
  await for (final event in source) {
    final data = event.extensionData?.data ?? {};
    yield parseNode(data);
  }
}

Stream<$Node> onEffectCreated() async* {
  final source = serviceManager.service?.onExtensionEvent
      .where((e) => e.extensionKind == 'ext.signals.effectCreate');
  if (source == null) return;
  await for (final event in source) {
    final data = event.extensionData?.data ?? {};
    yield parseNode(data);
  }
}

Stream<$Node> onEffectUpdated() async* {
  final source = serviceManager.service?.onExtensionEvent
      .where((e) => e.extensionKind == 'ext.signals.effectCalled');
  if (source == null) return;
  await for (final event in source) {
    final data = event.extensionData?.data ?? {};
    yield parseNode(data);
  }
}

Stream<$Node> onEffectRemove() async* {
  final source = serviceManager.service?.onExtensionEvent
      .where((e) => e.extensionKind == 'ext.signals.effectRemove');
  if (source == null) return;
  await for (final event in source) {
    final data = event.extensionData?.data ?? {};
    yield parseNode(data);
  }
}

Future<void> refreshNodes() async {
  try {
    final response = await serviceManager.callServiceExtensionOnMainIsolate(
      'ext.signals.getAllNodes',
    );
    final items = (response.json?['nodes'] as List?) ?? [];
    final results = <$Node>[];
    for (final item in items) {
      results.add(parseNode(item));
    }
    nodes.value = results;
  } catch (e) {
    print('Error fetching all signals: $e');
  }
}

$Node parseNode(dynamic item) {
  return (
    id: item['id'] as int,
    type: item['type'] as String,
    label: item['label'] as String?,
    value: item['value'] as String?,
    sources: item['sources'] as String?,
    targets: item['targets'] as String?,
  );
}
