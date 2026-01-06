import 'package:equatable/equatable.dart';

class Brands extends Equatable {
  final int? id;
  final String? name;
  final String? imageUrl;

  const Brands({
    this.id,
    this.name,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, imageUrl];
}
