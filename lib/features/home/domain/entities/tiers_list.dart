import 'package:mozaic_loyalty_sdk/features/home/domain/entities/tier.dart';

class TiersList extends TiersData {
  final List<TiersData>? tiers;
  final int? totalNumberOfResult;

  const TiersList({this.tiers, this.totalNumberOfResult});

  @override
  List<Object?> get props => [tiers, totalNumberOfResult];
}
