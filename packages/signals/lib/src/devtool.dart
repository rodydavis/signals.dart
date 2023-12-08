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
                'type': 'computed',
              })
          .toList();
      return developer.ServiceExtensionResponse.result(
        json.encode({
          'nodes': [...signals, ...computed]
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
    'value': instance.peek()?.toString(),
    'sources': instance._allSources.map((e) => e.globalId).join(','),
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
    'type': 'computed',
  });
}

Set<WeakReference<_Effect>> _effects = {};
void _onEffectCreated(_Effect instance) {
  if (!_devToolsEnabled) return;
  if (_effects.any((e) => e.target == instance)) return;
  _effects.add(WeakReference(instance));
  _debugPostEvent('ext.signals.effectCreate', {
    'id': instance.globalId,
    'label': instance.debugLabel,
    'type': 'effect',
  });
}

void _onEffectCalled(_Effect instance) {
  if (!_devToolsEnabled) return;
  if (!_effects.any((e) => e.target == instance)) return;
  _debugPostEvent('ext.signals.effectUpdate', {
    'id': instance.globalId,
    'label': instance.debugLabel,
    'type': 'effect',
  });
}
