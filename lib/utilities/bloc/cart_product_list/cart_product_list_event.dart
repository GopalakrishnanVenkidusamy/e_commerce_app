part of 'cart_product_list_bloc.dart';

sealed class CartProductListEvent {}

class GetAllCartProductList extends CartProductListEvent{}

class DeleteProductFromCart extends CartProductListEvent{
  int index;
  DeleteProductFromCart(this.index);
}


class CheckoutProduct extends CartProductListEvent{
  List<ProductDetails> productList;
  CheckoutProduct(this.productList);
}