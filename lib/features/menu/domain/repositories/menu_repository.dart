import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/menu/domain/entity/invite_friend.dart';
import 'package:my_custom_widget/features/menu/domain/entity/merchant_info.dart';

import '../../../../core/error/failures.dart';

abstract class MenuRepositories {
  Future<Either<AppFailure, InviteFriends>> getSystemResource({Map<String, dynamic>? body});

  Future<Either<AppFailure, MerchantInfo>> getMerchantContactInfo({Map<String, dynamic>? body});
}
