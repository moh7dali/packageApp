import 'package:equatable/equatable.dart';

class InviteFriends extends Equatable {
  final String? value;

  const InviteFriends({required this.value});

  @override
  List<Object?> get props => [value];
}
