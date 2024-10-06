import "package:e_commerce/config/path_export.dart";

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    on<GetProductList>(_getProductList);
  }

  Future<void> _getProductList(GetProductList event, Emitter<ProductListState> emit) async {
    Response response = await BaseService().httpGet(Endpoint.getProductList);
    if(response.statusCode == 200){
      final List<dynamic> jsonArray = json.decode(response.body);
      List<ProductDetails> productDetailsList =
      jsonArray.map((json) => ProductDetails.fromJson(json)).toList();
      emit(GetProductListSuccess(productDetailsList));
    }else{
      emit(GetProductListFailed(response.body));
    }
  }
}
