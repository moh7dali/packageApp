import 'package:equatable/equatable.dart';

class BranchImages extends Equatable {
  const BranchImages({this.imageUrl, this.id});

  final num? id;
  final String? imageUrl;

  @override
  List<Object?> get props => [id, imageUrl];
}
