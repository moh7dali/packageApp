import 'package:equatable/equatable.dart';

class Malls extends Equatable {
  final int? id;
  final String? name;
  final String? imageUrl;

  const Malls({this.id, this.name, this.imageUrl});

  @override
  List<Object?> get props => [id, name, imageUrl];
}
