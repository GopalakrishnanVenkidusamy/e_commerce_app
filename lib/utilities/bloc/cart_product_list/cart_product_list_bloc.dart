import "package:e_commerce/config/path_export.dart";

part 'cart_product_list_event.dart';
part 'cart_product_list_state.dart';

class CartProductListBloc extends Bloc<CartProductListEvent, CartProductListState> {
  CartProductListBloc() : super(CartProductListInitial()) {
    on<GetAllCartProductList>(getAllCartProductList);
    on<DeleteProductFromCart>(deleteProductFromCart);
    on<CheckoutProduct>(checkoutProduct);
  }


  FutureOr<void> getAllCartProductList(GetAllCartProductList event, Emitter<CartProductListState> emit) async {
    BaseStorage baseStorage = BaseStorage();
    await baseStorage.init();
    List<ProductDetails> productDetailsList = baseStorage.getProductDetailsList(Constant.storageKey);
    if (productDetailsList.isNotEmpty) {
        emit(GetCartProductDetails(productDetailsList));
      } else {
        emit(CartProductListFailed());
      }

  }

  FutureOr<void> deleteProductFromCart(DeleteProductFromCart event, Emitter<CartProductListState> emit) async{
    BaseStorage baseStorage = BaseStorage();
    await baseStorage.init();
    List<ProductDetails> productList = [];
    productList = baseStorage.getProductDetailsList(Constant.storageKey);
    if(productList.isNotEmpty){
      productList.removeAt(event.index);
      baseStorage.setProductDetailsList(Constant.orders, productList);
      emit(CartProductDeleteSuccess());
    }
  }
  Future<void> checkoutProduct(CheckoutProduct event, Emitter<CartProductListState> emit)  async {
    BaseStorage baseStorage = BaseStorage();
    await baseStorage.init();
    baseStorage.setProductDetailsList(Constant.storageKey, event.productList);
    emit(CheckOutProduct());
  }



}