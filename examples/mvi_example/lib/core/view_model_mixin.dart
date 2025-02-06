import 'dart:async';

import 'package:flutter/material.dart';
import 'package:signals_mvi_example/core/base_view_model.dart';

mixin ViewModelMixin<T extends StatefulWidget,
    VM extends BaseViewModel<BaseState, BaseEvent, BaseEffect>> on State<T> {
  late final VM viewModel;
  late final StreamSubscription<BaseEffect> _effectSubscription;

  @protected
  VM provideViewModel();

  @protected
  void onEffect(covariant BaseEffect effect) {}

  @override
  void initState() {
    super.initState();
    viewModel = provideViewModel();
    _effectSubscription = viewModel.effects.listen(onEffect);
  }

  @override
  void dispose() {
    viewModel.dispose();
    _effectSubscription.cancel();
    super.dispose();
  }

  void addEvent(BaseEvent event) {
    viewModel.addEvent(event);
  }
}
