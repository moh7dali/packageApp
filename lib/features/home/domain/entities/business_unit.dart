import 'package:equatable/equatable.dart';

class BusinessUnit extends Equatable {
  final int? id;
  final String? name;
  final String? imageUrl;

  const BusinessUnit({this.id, this.name, this.imageUrl});

  @override
  List<Object?> get props => [id, name, imageUrl];
}
