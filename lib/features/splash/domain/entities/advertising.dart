import 'package:equatable/equatable.dart';

class Advertising extends Equatable {
  final int id;
  final int assignType;
  final int assignTypeId;
  final int displayOrder;
  final List<String> advertisingImages;

  const Advertising({
    required this.id,
    required this.assignType,
    required this.assignTypeId,
    required this.displayOrder,
    required this.advertisingImages,
  });

  @override
  List<Object?> get props => [id, assignType, assignTypeId, displayOrder, advertisingImages];
}
