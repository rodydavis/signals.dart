import 'package:flutter/material.dart';
import 'package:shopping_cart/src/cart/controller.dart';
import 'package:shopping_cart/src/cart/events.dart';
import 'package:shopping_cart/src/cart/service.dart';
import 'package:shopping_cart/src/catalog/controller.dart';
import 'package:shopping_cart/src/catalog/events.dart';
import 'package:shopping_cart/src/catalog/service.dart';

import 'src/app.dart';

void main() async {
  final cartServer = CartService();
  final cartController = CartController(cartServer);

  final catalogService = CatalogService();
  final catalogController = CatalogController(catalogService);

  runApp(MyApp(
    cartController: cartController..dispatch(CartStarted()),
    catalogController: catalogController..dispatch(CatalogEvent.started),
  ));
}
