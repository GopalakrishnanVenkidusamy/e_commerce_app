import "package:e_commerce/config/path_export.dart";
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<GetCartProductList>(_getCartProductList);
    on<AddOrder>(_addOrder);
  }

  FutureOr<void> _getCartProductList(GetCartProductList event, Emitter<OrderState> emit) async{
    BaseStorage baseStorage = BaseStorage();
    await baseStorage.init();
    List<ProductDetails> productDetailsList = baseStorage.getProductDetailsList(Constant.storageKey);
    if (productDetailsList.isNotEmpty) {
      emit(CartProductList(productDetailsList));
    } else {
      emit(CartProductListFailed());
    }
  }

  FutureOr<void> _addOrder(AddOrder event, Emitter<OrderState> emit) async{
    BaseStorage baseStorage = BaseStorage();
    await baseStorage.init();
    OrderProduct orderProduct = OrderProduct();
    orderProduct.customerName = event.customerName;
    orderProduct.phoneNumber = event.phoneNumber;
    orderProduct.address = event.address;
    orderProduct.cardNumber= event.cardNumber;
    orderProduct.productList = event.productList;
    baseStorage.setOrderedProductDetailsList(Constant.orders,orderProduct);
    emit(OrderConfirmed());
  }
}
