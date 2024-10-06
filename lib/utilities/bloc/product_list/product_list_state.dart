part of 'product_list_bloc.dart';

sealed class ProductListState {}

final class ProductListInitial extends ProductListState {}

final class GetProductListSuccess extends ProductListState {
  late List<ProductDetails> productList;
  GetProductListSuccess(this.productList);
}

final class GetProductListFailed extends ProductListState {
  late String error;
  GetProductListFailed(this.error);
}