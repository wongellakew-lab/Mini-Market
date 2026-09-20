import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/cart_bloc/cart_bloc.dart';
import '../data/categories.dart';
import '../data/market_store.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _checkout() {
    final cartState = context.read<CartBloc>().state;
    final items = cartState is CartLoadedState ? cartState.cart : MarketStore.cart;

    if (items.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Your cart is empty')));
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Checkout'),
        content: Text(
          'Complete order for \$${items.fold<double>(0, (sum, item) => sum + item.total).toStringAsFixed(1)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(ClearCartEvent());
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order placed successfully!')),
              );
            },
            child: const Text(
              'Confirm',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cart = state is CartLoadedState ? state.cart : MarketStore.cart;
        final total = state is CartLoadedState ? state.total : MarketStore.cartTotal;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.pop(),
            ),
            title: const Text(
              'Your cart',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: cart.isEmpty
                      ? const Center(
                          child: Text(
                            'Your cart is empty',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            final item = cart[index];
                            final product = item.product;
                            final productColor = colorForCategory(product.category);
                            final productBgColor = bgColorForCategory(
                              product.category,
                            );
                            final productIcon = iconForCategory(product.category);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: productBgColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        productIcon,
                                        color: productColor,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Qty ${item.quantity}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF64748B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Color(0xFF94A3B8),
                                    ),
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                        RemoveFromCartEvent(productId: product.id),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          Text(
                            '\$${total.toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xFFCBD5E1),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: _checkout,
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
