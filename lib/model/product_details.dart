import 'package:e_commerce/generated/json/base/json_field.dart';
import 'package:e_commerce/generated/json/product_details.g.dart';
import 'package:e_commerce/model/rating.dart';


@JsonSerializable()
class ProductDetails {

	ProductDetails();

	factory ProductDetails.fromJson(Map<String, dynamic> json) => $ProductDetailsFromJson(json);

	Map<String, dynamic> toJson() => $ProductDetailsToJson(this);

  @JSONField(name: "id")
  double? id;
  @JSONField(name: "title")
  String? title;
  @JSONField(name: "price")
  double? price;
  @JSONField(name: "description")
  String? description;
  @JSONField(name: "category")
  String? category;
  @JSONField(name: "image")
  String? image;
  @JSONField(name: "quantity")
  double? quantity;
  @JSONField(name: "rating")
  Rating? rating;

}
