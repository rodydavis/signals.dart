import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:signals/signals.dart';

typedef $Node = ({
  int id,
  String type,
  String? label,
  String? value,
  String? sources,
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
        final item = parseNode(data);
        final idx = nodes //
            .indexWhere((e) => e.id == item.id && e.type == item.type);
        if (idx == -1) {
          nodes.add(item);
        } else {
          nodes[idx] = item;
        }
        break;
      default:
    }
  });
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
  );
}
