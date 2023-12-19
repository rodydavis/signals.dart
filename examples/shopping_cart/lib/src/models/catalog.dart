part of 'models.dart';

class Catalog extends Equatable {
  const Catalog(this.products);

  final List<Product> products;

  Product getById(int id) => products[id % products.length];

  Product getByPosition(int position) => getById(position);

  @override
  List<Object> get props => [products];
}
