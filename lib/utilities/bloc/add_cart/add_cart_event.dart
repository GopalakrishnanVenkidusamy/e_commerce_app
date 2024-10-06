part of 'add_cart_bloc.dart';

sealed class AddCartEvent {}

class AddCart extends AddCartEvent{
   late ProductDetails productDetails;
   AddCart(this.productDetails);
}