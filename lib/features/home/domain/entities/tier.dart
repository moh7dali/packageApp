import 'package:equatable/equatable.dart';

class TiersData extends Equatable {
  final int? id;
  final double? lowerLimit;
  final String? name;
  final String? imageUrl;
  final String? tierColor;
  final dynamic maintainingAmount;
  final dynamic latinName;
  final int? merchantId;
  final DateTime? creationDate;
  final int? createdBy;
  final dynamic modificationDate;
  final dynamic modifiedBy;
  final bool? isActive;

  const TiersData({
    this.id,
    this.lowerLimit,
    this.name,
    this.imageUrl,
    this.tierColor,
    this.maintainingAmount,
    this.latinName,
    this.merchantId,
    this.creationDate,
    this.createdBy,
    this.modificationDate,
    this.modifiedBy,
    this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        lowerLimit,
        name,
        maintainingAmount,
        latinName,
        merchantId,
        creationDate,
        createdBy,
        modificationDate,
        modifiedBy,
        isActive,
        tierColor,
        imageUrl
      ];
}
