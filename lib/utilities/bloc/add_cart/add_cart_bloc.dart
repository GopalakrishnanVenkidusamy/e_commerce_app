import "package:e_commerce/config/path_export.dart";
part 'add_cart_event.dart';
part 'add_cart_state.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddCartState> {
  AddCartBloc() : super(AddCartInitial()) {
    on<AddCart>(addCart);
  }

 Future<void> addCart(AddCart event, Emitter<AddCartState> emit)  async {
    BaseStorage baseStorage = BaseStorage();
    await baseStorage.init();
    List<ProductDetails> productList = [];
    productList = baseStorage.getProductDetailsList(Constant.storageKey);
    ProductDetails productDetails = event.productDetails;
    int index = -1;
    if(productList.isNotEmpty){
     for(int i=0;i<productList.length;i++){
       if(productList[i].id == productDetails.id){
         index = i;
         break;
       }
     }

      if(index >= 0) {
        productList[index].quantity = (productList[index].quantity ?? 0) + 1;
      }else{
        productDetails.quantity = 1;
        productList.add(productDetails);
      }
    }else{
      productDetails.quantity = 1;
      productList.add(productDetails);
    }
    if(productList.isNotEmpty) {
      baseStorage.setProductDetailsList(Constant.storageKey, productList);
      emit(AddedCartSuccess());
    }
  }
}