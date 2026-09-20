import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/product_bloc/product_bloc.dart';
import '../data/market_store.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(GetProductsEvent());
  }

  Future<void> _openProduct(Product product) async {
    await context.push('/product/${product.id}');

    setState(() {});
  }

  Future<void> _openCart() async {
    context.push('/cart');

    setState(() {});
  }

  Future<void> _openAddProduct() async {
    context.push('/product/new');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Mini Market',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: _openCart,
            child: Badge(
              isLabelVisible: MarketStore.cartCount > 0,
              label: Text('${MarketStore.cartCount}'),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(width: 8),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final products = switch (state) {
            ProductListState(:final products) => products,
            ProductInitialState() => MarketStore.products,
            ProductLoading() => MarketStore.products,
            _ => MarketStore.products,
          };

          if (state is ProductLoading && products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: products.isEmpty
                ? const Center(
                    child: Text(
                      'No products yet.\nTap + to add your first one.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () => _openProduct(product),
                      );
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
