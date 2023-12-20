import 'package:flutter/material.dart';
import 'package:shopping_cart/src/const.dart';
import 'package:shopping_cart/src/models/product.dart';

class CatalogService {
  Future<List<Product>> load() => Future.delayed(
      k100ms * 8,
      () => [
            (price: 42, id: 0, color: Colors.red, name: 'Red Car'),
            (price: 53, id: 1, color: Colors.green, name: 'Green Car'),
            (price: 58, id: 2, color: Colors.blue, name: 'Blue Car'),
            (price: 32, id: 3, color: Colors.yellow, name: 'Yellow Car'),
            (price: 93, id: 4, color: Colors.purple, name: 'Purple Car'),
            (price: 102, id: 5, color: Colors.orange, name: 'Orange Car'),
            (price: 77, id: 6, color: Colors.teal, name: 'Teal Car'),
            (price: 81, id: 7, color: Colors.pink, name: 'Pink Car'),
            (price: 49, id: 8, color: Colors.cyan, name: 'Cyan Car'),
            (price: 29, id: 9, color: Colors.lime, name: 'Lime Car'),
            (price: 84, id: 10, color: Colors.indigo, name: 'Indigo Car'),
            (price: 90, id: 11, color: Colors.amber, name: 'Amber Car'),
            (price: 104, id: 12, color: Colors.brown, name: 'Brown Car'),
            (price: 30, id: 13, color: Colors.grey, name: 'Grey Car'),
            (price: 62, id: 15, color: Colors.black, name: 'Black Car'),
          ]);
}
