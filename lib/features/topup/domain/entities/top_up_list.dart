import 'package:equatable/equatable.dart';

class TopUp extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final double? price;
  final double? value;
  final String? image;
  final bool? isActive;

  const TopUp({this.id, this.title, this.description, this.price, this.value, this.image, this.isActive});

  @override
  List<Object?> get props => [id, title, description, price, value, image, isActive];
}

class TopUpList extends Equatable {
  final int? totalNumberofResult;
  final List<TopUp>? topUp;

  const TopUpList({this.topUp, this.totalNumberofResult});

  @override
  List<Object?> get props => [topUp, totalNumberofResult];
}
