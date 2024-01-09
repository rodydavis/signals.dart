import 'package:lite_ref/lite_ref.dart';
import 'package:shopping_cart/src/cart/controller.dart';
import 'package:shopping_cart/src/cart/events.dart';
import 'package:shopping_cart/src/cart/service.dart';
import 'package:shopping_cart/src/catalog/controller.dart';
import 'package:shopping_cart/src/catalog/events.dart';
import 'package:shopping_cart/src/catalog/service.dart';

final cartService = Ref.singleton(() => CartService());

final cartController = Ref.singleton(
  () => CartController(cartService())..dispatch(CartStarted()),
);

final catalogService = Ref.singleton(() => CatalogService());

final catalogController = Ref.singleton(
  () {
    return CatalogController(catalogService())..dispatch(CatalogEvent.started);
  },
);
