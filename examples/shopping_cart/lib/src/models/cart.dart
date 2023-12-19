part of 'models.dart';

class Cart extends Equatable {
  const Cart({this.items = const <Product>[]});

  final List<Product> items;

  int get totalPrice {
    return items.fold(0, (total, current) => total + current.price);
  }

  @override
  List<Object> get props => [items];
}
