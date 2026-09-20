part of 'cart_bloc.dart';

abstract class CartEvent {}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final Product product;
  final int quantity;

  AddToCartEvent({required this.product, required this.quantity});
}

class RemoveFromCartEvent extends CartEvent {
  final String productId;

  RemoveFromCartEvent({required this.productId});
}

class ClearCartEvent extends CartEvent {}
