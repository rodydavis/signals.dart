// ignore_for_file: invalid_return_type_for_catch_error

import 'package:shopping_cart/src/models/models.dart';
import 'package:signals/signals.dart';

import 'events.dart';
import 'service.dart';

class CatalogController {
  CatalogController(this._catalogService);

  final CatalogService _catalogService;

  final _catalog = signal<AsyncState<Catalog>>(AsyncLoading());
  ReadonlySignal<AsyncState<Catalog>> get catalog => _catalog;

  Future<void> dispatch(CatalogEvent event) async {
    switch (event) {
      case CatalogEvent.started:
        _catalog.value = AsyncLoading();
        _catalogService
            .load()
            .then((catalog) => _catalog.value = AsyncData(Catalog(catalog)))
            .catchError((e, s) => _catalog.value = AsyncError(e, s));
    }
  }
}
