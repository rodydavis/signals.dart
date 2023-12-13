part of 'signals.dart';

// ignore: public_member_api_docs
void _debugPostEvent(
  String eventKind,
  Map<Object?, Object?> Function() event,
) {
  _initDevTools();
  if (_devToolsEnabled) {
    if (developer.extensionStreamHasListener) {
      developer.postEvent(eventKind, event());
    }
  }
}

bool _devToolsInitialized = false;
bool _devToolsEnabled = kDebugMode;

void disableSignalsDevTools() {
  _devToolsEnabled = false;
  _devToolsInitialized = false;
}

Map<String, dynamic> _getNodes() {
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
  final effects = _effects
      .where((e) => e.target != null)
      .map((e) => e.target!)
      .map((e) => {
            'id': e.globalId,
            'label': e.debugLabel,
            'value': '${_effectCount[e.globalId] ?? 0}',
            'sources': e._allSources.map((e) => e.globalId).join(','),
            'type': 'effect',
          })
      .toList();
  return {
    'nodes': [...signals, ...computed, ...effects]
  };
}

void reloadSignalsDevTools() {
  _debugPostEvent('ext.signals.reassemble', () => _getNodes());
}

// ignore: public_member_api_docs
void _initDevTools() {
  if (!_devToolsEnabled || _devToolsInitialized) return;
  developer.registerExtension(
    'ext.signals.getAllNodes',
    (method, parameters) async {
      return developer.ServiceExtensionResponse.result(
        json.encode(_getNodes()),
      );
    },
  );
  _devToolsInitialized = true;
}

Set<WeakReference<ReadonlySignal>> _signals = {};
void _onSignalCreated(Signal instance) {
  SignalsObserver.instance?.onSignalCreated(instance);
  if (!_devToolsEnabled) return;
  _debugPostEvent('ext.signals.signalCreate', () {
    return {
      'id': instance.globalId,
      'label': instance.debugLabel,
      'value': instance.peek()?.toString(),
      'targets': instance._allTargets.map((e) => e.globalId).join(','),
      'type': 'signal',
    };
  });
  _signals.add(WeakReference(instance));
}

void _onSignalUpdated(Signal instance, dynamic value) {
  SignalsObserver.instance?.onSignalUpdated(instance, value);
  if (!_devToolsEnabled) return;
  _debugPostEvent('ext.signals.signalUpdate', () {
    return {
      'id': instance.globalId,
      'label': instance.debugLabel,
      'value': value?.toString(),
      'targets': instance._allTargets.map((e) => e.globalId).join(','),
      'type': 'signal',
    };
  });
}

Set<WeakReference<Computed>> _computed = {};
void _onComputedCreated(Computed instance) {
  SignalsObserver.instance?.onComputedCreated(instance);
  if (!_devToolsEnabled) return;
  _debugPostEvent('ext.signals.computedCreate', () {
    return {
      'id': instance.globalId,
      'label': instance.debugLabel,
      'sources': instance._allSources.map((e) => e.globalId).join(','),
      'targets': instance._allTargets.map((e) => e.globalId).join(','),
      'value': '',
      'type': 'computed',
    };
  });
  _computed.add(WeakReference(instance));
}

void _onComputedUpdated(Computed instance, dynamic value) {
  SignalsObserver.instance?.onComputedUpdated(instance, value);
  if (!_devToolsEnabled) return;
  _debugPostEvent('ext.signals.computedUpdate', () {
    return {
      'id': instance.globalId,
      'label': instance.debugLabel,
      'value': value?.toString(),
      'sources': instance._allSources.map((e) => e.globalId).join(','),
      'targets': instance._allTargets.map((e) => e.globalId).join(','),
      'type': 'computed',
    };
  });
}

Map<int, int> _effectCount = {};
Set<WeakReference<_Effect>> _effects = {};
void _onEffectCreated(_Effect instance) {
  if (!_devToolsEnabled) return;
  _effectCount[instance.globalId] = 0;
  _effects.add(WeakReference(instance));
  _debugPostEvent('ext.signals.effectCreate', () {
    return {
      'id': instance.globalId,
      'label': instance.debugLabel,
      'sources': instance._allSources.map((e) => e.globalId).join(','),
      'value': '0',
      'type': 'effect',
    };
  });
}

void _onEffectCalled(_Effect instance) {
  if (!_devToolsEnabled) return;
  _effectCount[instance.globalId] ?? 0;
  var count = _effectCount[instance.globalId]!;
  _effectCount[instance.globalId] = ++count;
  _debugPostEvent('ext.signals.effectCalled', () {
    return {
      'id': instance.globalId,
      'label': instance.debugLabel,
      'sources': instance._allSources.map((e) => e.globalId).join(','),
      'value': '$count',
      'type': 'effect',
    };
  });
}

void _onEffectRemoved(_Effect instance) {
  if (!_devToolsEnabled) return;
  _effectCount.remove(instance.globalId);
  _effects.removeWhere((e) => e.target == instance);
  _debugPostEvent('ext.signals.effectRemove', () {
    return {
      'id': instance.globalId,
      'label': instance.debugLabel,
      // 'sources': instance._allSources.map((e) => e.globalId).join(','),
      'value': '-1',
      'type': 'effect',
    };
  });
}
