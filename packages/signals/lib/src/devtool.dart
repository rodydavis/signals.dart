part of 'signals.dart';

// ignore: public_member_api_docs
void _debugPostEvent(
  String eventKind, [
  Map<Object?, Object?> event = const {},
]) {
  _initDevTools();
  if (_devToolsEnabled) {
    developer.postEvent(eventKind, event);
  }
}

bool _devToolsInitialized = false;
bool _devToolsEnabled = kDebugMode;

// ignore: public_member_api_docs
void _initDevTools() {
  if (!_devToolsEnabled || _devToolsInitialized) return;
  developer.registerExtension(
    'ext.signals.getAllNodes',
    (method, parameters) async {
      final signals = _signals
          .where((e) => e.target != null)
          .map((e) => e.target!)
          .map((e) => {
                'id': e.globalId,
                'label': e.debugLabel,
                'value': e.toString(),
                'targets': e._allTargets.map((e) => e.globalId).join(','),
                'type': 'signal',
              })
          .toList();
      final computed = _computed
          .where((e) => e.target != null)
          .map((e) => e.target!)
          .map((e) => {
                'id': e.globalId,
                'label': e.debugLabel,
                'value': e.toString(),
                'targets': e._allTargets.map((e) => e.globalId).join(','),
                'sources': e._allSources.map((e) => e.globalId).join(','),
                'type': 'computed',
              })
          .toList();
      final effects = _effects.keys
          .where((e) => e.target != null)
          .map((e) => e.target!)
          .map((e) => {
                'id': e.globalId,
                'label': e.debugLabel,
                'value':
                    _effects[_effects.keys.firstWhere((r) => r.target == e)]!
                        .toString(),
                'sources': e._allSources.map((e) => e.globalId).join(','),
                'type': 'effect',
              })
          .toList();
      return developer.ServiceExtensionResponse.result(
        json.encode({
          'nodes': [...signals, ...computed, ...effects]
        }),
      );
    },
  );
  _devToolsInitialized = true;
}

Set<WeakReference<ReadonlySignal>> _signals = {};
void _onSignalCreated(Signal instance) {
  SignalsObserver.instance?.onSignalCreated(instance);
  if (!_devToolsEnabled) return;
  if (_signals.any((e) => e.target == instance)) return;
  _signals.add(WeakReference(instance));
  _debugPostEvent('ext.signals.signalCreate', {
    'id': instance.globalId,
    'label': instance.debugLabel,
    'value': instance.peek()?.toString(),
    'targets': instance._allTargets.map((e) => e.globalId).join(','),
    'type': 'signal',
  });
}

void _onSignalUpdated(Signal instance, dynamic value) {
  SignalsObserver.instance?.onSignalUpdated(instance, value);
  if (!_devToolsEnabled) return;
  _debugPostEvent('ext.signals.signalUpdate', {
    'id': instance.globalId,
    'label': instance.debugLabel,
    'value': value?.toString(),
    'targets': instance._allTargets.map((e) => e.globalId).join(','),
    'type': 'signal',
  });
}

Set<WeakReference<Computed>> _computed = {};
void _onComputedCreated(Computed instance) {
  SignalsObserver.instance?.onComputedCreated(instance);
  if (!_devToolsEnabled) return;
  if (_computed.any((e) => e.target == instance)) return;
  _computed.add(WeakReference(instance));
  _debugPostEvent('ext.signals.computedCreate', {
    'id': instance.globalId,
    'label': instance.debugLabel,
    'sources': instance._allSources.map((e) => e.globalId).join(','),
    'targets': instance._allTargets.map((e) => e.globalId).join(','),
    'value': '',
    'type': 'computed',
  });
}

void _onComputedUpdated(Computed instance, dynamic value) {
  SignalsObserver.instance?.onComputedUpdated(instance, value);
  if (!_devToolsEnabled) return;
  _debugPostEvent('ext.signals.computedUpdate', {
    'id': instance.globalId,
    'label': instance.debugLabel,
    'value': value?.toString(),
    'sources': instance._allSources.map((e) => e.globalId).join(','),
    'targets': instance._allTargets.map((e) => e.globalId).join(','),
    'type': 'computed',
  });
}

Map<WeakReference<_Effect>, int> _effects = {};
void _onEffectCreated(_Effect instance) {
  if (!_devToolsEnabled) return;
  if (_effects.keys.any((e) => e.target == instance)) return;
  _effects[WeakReference(instance)] = 0;
  _debugPostEvent('ext.signals.effectCreate', {
    'id': instance.globalId,
    'label': instance.debugLabel,
    'sources': instance._allSources.map((e) => e.globalId).join(','),
    'value': '0',
    'type': 'effect',
  });
}

void _onEffectCalled(_Effect instance) {
  if (!_devToolsEnabled) return;
  if (!_effects.keys.any((e) => e.target == instance)) return;
  final ref = _effects.keys.firstWhere((e) => e.target == instance);
  final count = _effects[ref]!;
  _effects[ref] = count + 1;
  _debugPostEvent('ext.signals.effectCalled', {
    'id': instance.globalId,
    'label': instance.debugLabel,
    'sources': instance._allSources.map((e) => e.globalId).join(','),
    'value': '${_effects[ref]}',
    'type': 'effect',
  });
}

void _onEffectRemoved(_Effect instance) {
  if (!_devToolsEnabled) return;
  if (!_effects.keys.any((e) => e.target == instance)) return;
  final ref = _effects.keys.firstWhere((e) => e.target == instance);
  _effects.remove(ref);
  _debugPostEvent('ext.signals.effectRemove', {
    'id': instance.globalId,
    'label': instance.debugLabel,
    'sources': instance._allSources.map((e) => e.globalId).join(','),
    'value': '-1',
    'type': 'effect',
  });
}
