part of 'cart_product_list_bloc.dart';


sealed class CartProductListState {}

final class CartProductListInitial extends CartProductListState {}
final class GetCartProductDetails extends CartProductListState {
  late List<ProductDetails> productList;
  GetCartProductDetails(this.productList);
}
final class CartProductListFailed extends CartProductListState {
  CartProductListFailed();
}
final class CartProductDeleteSuccess extends CartProductListState {}

final class GetProductListSuccess extends CartProductListState {
  late List<ProductDetails> productList;
  GetProductListSuccess(this.productList);
}

final class GetProductDetailsFailed extends CartProductListState {}
final class CheckOutProduct extends CartProductListState {}