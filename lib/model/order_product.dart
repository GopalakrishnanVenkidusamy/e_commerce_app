import 'package:e_commerce/generated/json/base/json_field.dart';
import 'package:e_commerce/generated/json/order_product.g.dart';

import 'package:e_commerce/model/product_details.dart';

@JsonSerializable()
class OrderProduct {

	OrderProduct();

	factory OrderProduct.fromJson(Map<String, dynamic> json) => $OrderProductFromJson(json);

	Map<String, dynamic> toJson() => $OrderProductToJson(this);

  @JSONField(name: "customer_name")
  String? customerName;
  @JSONField(name: "phoneNumber")
  String? phoneNumber;
  @JSONField(name: "address")
  String? address;
  @JSONField(name: "card_number")
  String? cardNumber;
  @JSONField(name: "product")
  List<ProductDetails>? productList;
}