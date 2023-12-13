import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:signals/signals.dart';

final nodes = listSignal<$Node>([]);
final nodeAdd = signal<$Node?>(null);
final nodeUpdate = signal<$Node?>(null);
final nodeRemove = signal<$Node?>(null);
final reassembleCount = signal<int>(0);

Function? initNodes() {
  final subscription = serviceManager.service?.onExtensionEvent
      .where((e) => e.extensionKind?.startsWith('ext.signals') ?? false)
      .listen((event) {
    final kind = event.extensionKind;
    final data = event.extensionData?.data ?? {};
    switch (kind) {
      case 'ext.signals.signalCreate':
      case 'ext.signals.computedCreate':
      case 'ext.signals.effectCreate':
        final n = $Node.fromJson(data);
        nodes.add(n);
        nodeAdd.value = n;
        break;
      case 'ext.signals.signalUpdate':
      case 'ext.signals.computedUpdate':
      case 'ext.signals.effectCalled':
        final n = $Node.fromJson(data);
        final idx = nodes.indexWhere((e) => e.id == n.id && e.type == n.type);
        if (n.value == '-1' && n.type == 'effect') {
          nodes.removeWhere((e) => e.id == n.id);
          nodeRemove.value = n;
        } else {
          if (idx == -1) {
            nodes.add(n);
            nodeUpdate.value = n;
          } else {
            final current = nodes[idx];
            if (n.type == 'signal' || n.type == 'computed') {
              current.value = n.value;
              nodeUpdate.value = current;
            } else {
              nodes[idx] = n;
              nodeUpdate.value = n;
            }
          }
        }
        break;
      case 'ext.signals.signalRemove':
      case 'ext.signals.computedRemove':
      case 'ext.signals.effectRemove':
        final n = $Node.fromJson(data);
        final idx = nodes.indexWhere((e) => e.id == n.id && e.type == n.type);
        if (idx != -1) {
          nodes.removeAt(idx);
        }
        nodeRemove.value = n;
        break;
      case 'ext.signals.reassemble':
        final items = (data['nodes'] as List?) ?? [];
        final results = <$Node>[];
        for (final item in items) {
          results.add($Node.fromJson(item));
        }
        nodes.value = results;
        reassembleCount.value++;
        break;
      default:
        break;
    }
  });
  return subscription?.cancel;
}

Future<void> refreshNodes() async {
  try {
    final response = await serviceManager.callServiceExtensionOnMainIsolate(
      'ext.signals.getAllNodes',
    );
    final items = (response.json?['nodes'] as List?) ?? [];
    final results = <$Node>[];
    for (final item in items) {
      results.add($Node.fromJson(item));
    }
    nodes.value = results;
    reassembleCount.value++;
  } catch (e) {
    debugPrint('Error fetching all signals: $e');
  }
}

class $Node {
  int id;
  String type;
  String? label;
  String? value;
  String? sources;
  String? targets;

  $Node({
    required this.id,
    required this.type,
    this.label,
    this.value,
    this.sources,
    this.targets,
  });

  @override
  String toString() => '$type|$id|$label';

  factory $Node.fromJson(Map<String, dynamic> item) {
    return $Node(
      id: item['id'] as int,
      type: item['type'] as String,
      label: item['label'] as String?,
      value: item['value'] as String?,
      sources: item['sources'] as String?,
      targets: item['targets'] as String?,
    );
  }
}
