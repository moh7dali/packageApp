import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/menu/domain/entity/invite_friend.dart';
import 'package:my_custom_widget/features/menu/domain/entity/merchant_info.dart';

import '../../../../core/error/failures.dart';
import '../entity/profile_info.dart';

abstract class MenuRepositories {
  Future<Either<AppFailure, ProfileInfo>> getProfileInfo();

  Future<Either<AppFailure, InviteFriends>> getSystemResource({Map<String, dynamic>? body});

  Future<Either<AppFailure, MerchantInfo>> getMerchantContactInfo({Map<String, dynamic>? body});

  Future<Either<AppFailure, dynamic>> deleteAccount();

  Future<Either<AppFailure, dynamic>> logOut();
}
