import 'package:shopping_cart/src/const.dart';
import 'package:shopping_cart/src/models/product.dart';

class CartService {
  final _items = <Product>[];

  Future<List<Product>> loadProducts() =>
      Future.delayed(k100ms * 10, () => _items);

  void add(Product item) => _items.add(item);

  void remove(Product item) => _items.remove(item);
}
