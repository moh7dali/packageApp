import 'package:equatable/equatable.dart';

class LookUp extends Equatable {
  final int id;
  final String name;

  const LookUp({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}