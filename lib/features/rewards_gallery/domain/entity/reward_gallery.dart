import 'package:equatable/equatable.dart';

class RewardsGallery extends Equatable {
  final int? typeId;
  final int? id;
  final String? title;
  final String? name;
  final List<String>? imageUrl;
  final String? description;
  final double? numberOfPoints;

  const RewardsGallery({this.id, this.typeId, this.name, this.imageUrl, this.description, this.title, this.numberOfPoints});

  @override
  List<Object?> get props => [typeId, name, imageUrl, description, numberOfPoints, title,id];
}

class RewardsGalleryList extends Equatable {
  final int? totalNumberofResult;
  final List<RewardsGallery>? rewardsList;

  const RewardsGalleryList({
    this.rewardsList,
    this.totalNumberofResult,
  });

  @override
  List<Object?> get props => [rewardsList, totalNumberofResult];
}
