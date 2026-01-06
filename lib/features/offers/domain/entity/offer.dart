import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final DateTime? endDate;

  const Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.endDate,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl, endDate];
}
