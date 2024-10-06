part of 'order_bloc.dart';


sealed class OrderEvent {}

class GetCartProductList extends OrderEvent{}

class AddOrder extends OrderEvent{
  String? customerName;
  String? phoneNumber;
  String? address;
  String? cardNumber;
  List<ProductDetails>? productList;
  AddOrder({this.customerName,this.phoneNumber,this.address,this.cardNumber,this.productList});
}