import 'dart:async';

import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

abstract class BaseState {
  const BaseState();
}

abstract class BaseEvent {
  const BaseEvent();
}

abstract class BaseEffect {
  const BaseEffect();
}

abstract class BaseViewModel<BaseState, BaseEvent, BaseEffect> {
  BaseViewModel(BaseState initialState) : _state = Signal(initialState) {
    _eventsSubscription = _events.stream.listen(onEvent);
  }

  late final Signal<BaseState> _state;
  ReadonlySignal<BaseState> get state => _state.readonly();

  final _events = StreamController<BaseEvent>();
  late final StreamSubscription<BaseEvent> _eventsSubscription;

  final _effects = StreamController<BaseEffect>();
  Stream<BaseEffect> get effects => _effects.stream;

  @protected
  void onEvent(BaseEvent event);

  @protected
  // ignore: use_setters_to_change_properties
  void updateState(BaseState newState) => _state.value = newState;

  void addEvent(BaseEvent event) => _events.add(event);

  @protected
  void addEffect(BaseEffect effect) => _effects.add(effect);

  void dispose() {
    _state.dispose();
    _eventsSubscription.cancel();
  }
}
