// ignore_for_file: invalid_return_type_for_catch_error

import 'package:shopping_cart/src/models/models.dart';
import 'package:signals/signals_flutter.dart';

import 'events.dart';
import 'service.dart';

class CartController {
  CartController(this._cartService);

  final CartService _cartService;

  late final _cart = signal<AsyncState<Cart>>(AsyncLoading());
  ReadonlySignal<AsyncState<Cart>> get cart => _cart;

  Future<void> dispatch(CartEvent event) async {
    switch (event) {
      case CartStarted():
        _cart.value = AsyncLoading();
        _cartService
            .loadProducts()
            .then((items) => _cart.value = AsyncData(Cart(items: [...items])))
            .catchError((e, s) => _cart.set(AsyncError(e, s)));

      case CartItemAdded(:final item):
        if (_cart.value case AsyncData<Cart>(:final value)) {
          try {
            _cartService.add(item);
            _cart.value = AsyncData(Cart(items: [...value!.items, item]));
          } catch (e, s) {
            _cart.value = AsyncError(e, s);
          }
        }

      case CartItemRemoved(:final item):
        if (_cart.value case AsyncData<Cart>(:final value)) {
          try {
            _cartService.remove(item);
            _cart.value = AsyncData(
              Cart(
                items: [...value!.items]..remove(event.item),
              ),
            );
          } catch (e, s) {
            _cart.value = AsyncError(e, s);
          }
        }
    }
  }
}
