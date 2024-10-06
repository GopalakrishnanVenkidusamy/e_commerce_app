part of 'order_bloc.dart';

sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class CartProductList extends OrderState {
  late List<ProductDetails> productList;
  CartProductList(this.productList);
}
final class CartProductListFailed extends OrderState {
  CartProductListFailed();
}

final class OrderConfirmed extends OrderState {}