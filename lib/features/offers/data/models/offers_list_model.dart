import '../../domain/entity/offer.dart';
import '../../domain/entity/offers_list.dart';
import 'offer_model.dart';

class OffersListModel extends OffersList {
  const OffersListModel({
    required super.totalNumberofResult,
    required super.offers,
  });

  factory OffersListModel.fromJson(Map<String, dynamic> json) => OffersListModel(
        totalNumberofResult: json["TotalNumberOfResult"],
        offers: json["List"] == null ? [] : List<Offer>.from(json["List"]!.map((x) => OfferModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalNumberOfResult": totalNumberofResult,
        "Brands": offers,
      };
}
