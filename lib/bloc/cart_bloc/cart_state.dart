part of 'cart_bloc.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartItem> cart;
  final int itemCount;
  final double total;

  CartLoadedState({
    required this.cart,
    required this.itemCount,
    required this.total,
  });
}
