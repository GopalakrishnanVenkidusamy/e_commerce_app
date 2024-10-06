import 'package:e_commerce/generated/json/base/json_convert_content.dart';
import 'package:e_commerce/model/rating.dart';

Rating $RatingFromJson(Map<String, dynamic> json) {
	final Rating rating = Rating();
	final double? rate = jsonConvert.convert<double>(json['rate']);
	if (rate != null) {
		rating.rate = rate;
	}
	final double? count = jsonConvert.convert<double>(json['count']);
	if (count != null) {
		rating.count = count;
	}
	return rating;
}

Map<String, dynamic> $RatingToJson(Rating entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['rate'] = entity.rate;
	data['count'] = entity.count;
	return data;
}