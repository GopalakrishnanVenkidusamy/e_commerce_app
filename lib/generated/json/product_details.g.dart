import 'package:e_commerce/generated/json/base/json_convert_content.dart';
import 'package:e_commerce/model/product_details.dart';
import 'package:e_commerce/model/rating.dart';


ProductDetails $ProductDetailsFromJson(Map<String, dynamic> json) {
	final ProductDetails productDetails = ProductDetails();
	final double? id = jsonConvert.convert<double>(json['id']);
	if (id != null) {
		productDetails.id = id;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		productDetails.title = title;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		productDetails.price = price;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		productDetails.description = description;
	}
	final String? category = jsonConvert.convert<String>(json['category']);
	if (category != null) {
		productDetails.category = category;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		productDetails.image = image;
	}
	final double? quantity = jsonConvert.convert<double>(json['quantity']);
	if (quantity != null) {
		productDetails.quantity = quantity;
	}
	final Rating? rating = jsonConvert.convert<Rating>(json['rating']);
	if (rating != null) {
		productDetails.rating = rating;
	}
	return productDetails;
}

Map<String, dynamic> $ProductDetailsToJson(ProductDetails entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['price'] = entity.price;
	data['description'] = entity.description;
	data['category'] = entity.category;
	data['image'] = entity.image;
	data['quantity'] = entity.quantity;
	data['rating'] = entity.rating?.toJson();
	return data;
}