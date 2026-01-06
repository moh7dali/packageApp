import 'package:equatable/equatable.dart';

class UserRewards extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final int? status;
  final int? rewardTypeId;
  final String? imageUrl;
  final String? expiryDate;
  final String? creationDate;

  const UserRewards({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.rewardTypeId,
    required this.imageUrl,
    required this.expiryDate,
    required this.creationDate,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        rewardTypeId,
        imageUrl,
        expiryDate,
        creationDate,
      ];
}
