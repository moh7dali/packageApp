import 'package:equatable/equatable.dart';

class CampaignDetails extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? toDate;
  final String? fromDate;

  const CampaignDetails({
    this.id,
    this.name,
    this.description,
    this.toDate,
    this.fromDate,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        toDate,
        fromDate,
      ];
}
