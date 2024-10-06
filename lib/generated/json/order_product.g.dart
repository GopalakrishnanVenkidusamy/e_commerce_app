import 'package:e_commerce/generated/json/base/json_convert_content.dart';
import 'package:e_commerce/model/order_product.dart';
import 'package:e_commerce/model/product_details.dart';


OrderProduct $OrderProductFromJson(Map<String, dynamic> json) {
	final OrderProduct orderProduct = OrderProduct();
	final String? customerName = jsonConvert.convert<String>(json['customer_name']);
	if (customerName != null) {
		orderProduct.customerName = customerName;
	}
	final String? phoneNumber = jsonConvert.convert<String>(json['phoneNumber']);
	if (phoneNumber != null) {
		orderProduct.phoneNumber = phoneNumber;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		orderProduct.address = address;
	}
	final String? cardNumber = jsonConvert.convert<String>(json['card_number']);
	if (cardNumber != null) {
		orderProduct.cardNumber = cardNumber;
	}
	final List<ProductDetails>? productList = jsonConvert.convertListNotNull<ProductDetails>(json['product']);
	if (productList != null) {
		orderProduct.productList = productList;
	}
	return orderProduct;
}

Map<String, dynamic> $OrderProductToJson(OrderProduct entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['customer_name'] = entity.customerName;
	data['phoneNumber'] = entity.phoneNumber;
	data['address'] = entity.address;
	data['card_number'] = entity.cardNumber;
	data['product'] =  entity.productList?.map((v) => v.toJson()).toList();
	return data;
}