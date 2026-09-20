import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../screens/add_product.dart';
import '../screens/cart_page.dart';
import '../screens/home_page.dart';
import '../screens/product_details.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
          path: 'product/:id',
          builder: (BuildContext context, GoRouterState state) {
            final productId = state.pathParameters['id'] ?? '';
            return ProductDetails(productId: productId);
          },
        ),
        GoRoute(
          path: 'cart',
          builder: (BuildContext context, GoRouterState state) {
            return const CartPage();
          },
        ),
        GoRoute(
          path: 'add-product',
          builder: (BuildContext context, GoRouterState state) {
            final product = state.extra as Product?;
            return AddProduct(product: product);
          },
        ),
      ],
    ),
  ],
);
