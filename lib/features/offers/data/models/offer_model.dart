import 'package:my_custom_widget/features/offers/domain/entity/offer.dart';

class OfferModel extends Offer {
  const OfferModel({
    required int id,
    required String title,
    required String description,
    required String imageUrl,
    required DateTime endDate,
  }) : super(
          id: id,
          title: title,
          description: description,
          imageUrl: imageUrl,
          endDate: endDate,
        );

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['Id'] as int,
      title: json['Title'] as String,
      description: json['Description'] as String,
      imageUrl: json['ImageUrl'] as String,
      endDate: DateTime.parse(json['EndDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Title': title,
      'Description': description,
      'ImageUrl': imageUrl,
      'EndDate': endDate?.toIso8601String(),
    };
  }
}
