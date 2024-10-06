part of 'add_cart_bloc.dart';

sealed class AddCartState {}

final class AddCartInitial extends AddCartState {}
final class AddedCartSuccess extends AddCartState {}
final class AddCartFailed extends AddCartState {}