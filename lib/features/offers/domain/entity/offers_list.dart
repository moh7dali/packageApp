import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/offers/domain/entity/offer.dart';

class OffersList extends Equatable {
  final int? totalNumberofResult;
  final List<Offer>? offers;

  const OffersList({this.offers, this.totalNumberofResult});

  @override
  List<Object?> get props => [offers, totalNumberofResult];
}
