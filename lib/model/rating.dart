import 'package:e_commerce/generated/json/base/json_field.dart';
import 'package:e_commerce/generated/json/rating.g.dart';




@JsonSerializable()
class Rating {

	Rating();

	factory Rating.fromJson(Map<String, dynamic> json) => $RatingFromJson(json);

	Map<String, dynamic> toJson() => $RatingToJson(this);

  @JSONField(name: "rate")
  double? rate;
  @JSONField(name: "count")
  double? count;
}