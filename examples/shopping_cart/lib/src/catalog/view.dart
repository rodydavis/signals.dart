import 'package:flutter/material.dart';
import 'package:shopping_cart/deps.dart';
import 'package:shopping_cart/src/cart/events.dart';
import 'package:shopping_cart/src/models/models.dart';
import 'package:shopping_cart/src/models/product.dart';
import 'package:signals/signals_flutter.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final state = catalogController.instance.catalog.watch(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final cols = _getCrossAxisCount(screenWidth);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CatalogAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          switch (state) {
            AsyncError() => const SliverFillRemaining(
                child: Text('Something went wrong!'),
              ),
            AsyncData(value: final catalog) => SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => CatalogGridItem(
                    catalog.getByPosition(index),
                  ),
                  childCount: catalog.products.length,
                ),
              ),
            _ => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
          },
        ],
      ),
    );
  }
}

class CatalogGridItem extends StatelessWidget {
  const CatalogGridItem(this.item, {super.key});

  final Product item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleLarge;
    return Container(
      decoration: BoxDecoration(
        color: item.color.withAlpha(50),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.name, style: textTheme),
            Icon(
              size: 80,
              Icons.directions_car_sharp, // Replace with actual item icon
              color: item.color,
            ),
            AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({required this.item, super.key});

  final Product item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = cartController.instance.cart.watch(context);

    return switch (state) {
      AsyncError() => const Text('Something went wrong!'),
      AsyncData(value: final cart) => Builder(
          builder: (context) {
            final isInCart = cart.items.contains(item);
            return TextButton(
              style: TextButton.styleFrom(
                  disabledForegroundColor: theme.primaryColor,
                  backgroundColor: theme.cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(100, 50)),
              onPressed: isInCart
                  ? null
                  : () => cartController.instance.dispatch(CartItemAdded(item)),
              child: isInCart
                  ? const Icon(Icons.check, semanticLabel: 'ADDED')
                  : const Text('ADD'),
            );
          },
        ),
      _ => const CircularProgressIndicator(),
    };
  }
}

class CatalogAppBar extends StatelessWidget {
  const CatalogAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = cartController.instance.cart.watch(context);
    int count = 0;

    if (cart is AsyncData<Cart>) {
      count = cart.value.items.length;
    }

    return SliverAppBar(
      title: const Text('Catalog'),
      floating: true,
      pinned: true,
      actions: [
        Stack(
          children: [
            IconButton(
              key: const Key('cart_button'),
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Navigator.of(context).pushNamed('/cart'),
            ),
            if (count > 0)
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

int _getCrossAxisCount(double width) {
  if (width < 600) {
    // Mobile
    return 1;
  } else if (width < 1200) {
    // Tablet
    return 3;
  } else {
    // Desktop
    return 5;
  }
}
