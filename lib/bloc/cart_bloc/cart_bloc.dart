import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/market_store.dart';
import '../../models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<LoadCartEvent>((event, emit) {
      emit(_buildState());
    });

    on<AddToCartEvent>((event, emit) {
      MarketStore.addToCart(event.product, event.quantity);
      emit(_buildState());
    });

    on<RemoveFromCartEvent>((event, emit) {
      MarketStore.removeFromCart(event.productId);
      emit(_buildState());
    });

    on<ClearCartEvent>((event, emit) {
      MarketStore.clearCart();
      emit(_buildState());
    });
  }

  CartLoadedState _buildState() {
    return CartLoadedState(
      cart: List<CartItem>.from(MarketStore.cart),
      itemCount: MarketStore.cartCount,
      total: MarketStore.cartTotal,
    );
  }
}
