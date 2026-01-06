import '../../domain/entity/invite_friend.dart';

class InviteFriendsModel extends InviteFriends {
  const InviteFriendsModel({required super.value});

  factory InviteFriendsModel.fromJson(Map<String, dynamic> json) => InviteFriendsModel(value: json["Value"]);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Value'] = value;
    return map;
  }
}
