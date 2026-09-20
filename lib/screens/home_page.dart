import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/market_store.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _openCart() async {
    await context.push('/cart');
    if (mounted) setState(() {});
  }

  Future<void> _openProductDetails(String productId) async {
    await context.push('/product/$productId');
    if (mounted) setState(() {});
  }

  Future<void> _openAddProduct() async {
    await context.push('/add-product');
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final products = MarketStore.products;
    final cartCount = MarketStore.cartCount;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Mini Market',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount', style: const TextStyle(fontSize: 11)),
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
                size: 24,
              ),
            ),
            onPressed: _openCart,
          ),
          const SizedBox(width: 8),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
        ),
      ),
      body: products.isEmpty
          ? const Center(
              child: Text(
                'No products available',
                style: TextStyle(fontSize: 16, color: Color(0xFF94A3B8)),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.82,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onTap: () => _openProductDetails(product.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        backgroundColor: const Color(0xFFDBE2FE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onPressed: _openAddProduct,
        child: const Icon(Icons.add, color: Color(0xFF1E293B), size: 28),
      ),
    );
  }
}
