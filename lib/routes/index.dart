import "package:e_commerce/config/path_export.dart";


class PageRoutes{
  static const String productList = "/productList";
  static const String productDetail = "/productDetail";
  static const String cart = "/cart";
  static const String checkout = "/checkout";

  defaultRoute() {
    return productList;
  }
  Map<String, WidgetBuilder> routes() {
    return {
      productList: (context) =>  const ProductList(),
      productDetail: (context) => const ProductDetail(),
      cart: (context) =>  const Cart(),
      checkout: (context) => const Checkout(),
    };
  }
}
