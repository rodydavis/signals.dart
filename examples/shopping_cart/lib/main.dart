import 'package:flutter/material.dart';
import 'package:shopping_cart/src/cart/controller.dart';
import 'package:shopping_cart/src/cart/events.dart';
import 'package:shopping_cart/src/cart/service.dart';
import 'package:shopping_cart/src/catalog/controller.dart';
import 'package:shopping_cart/src/catalog/events.dart';
import 'package:shopping_cart/src/catalog/service.dart';

import 'src/app.dart';

void main() async {
  // you could use Provider or GetIt to provide the controllers to widgets
  // instead of passing them through the contructor
  final cartService = CartService();
  final cartController = CartController(cartService);

  final catalogService = CatalogService();
  final catalogController = CatalogController(catalogService);

  runApp(MyApp(
    cartController: cartController..dispatch(CartStarted()),
    catalogController: catalogController..dispatch(CatalogEvent.started),
  ));
}
