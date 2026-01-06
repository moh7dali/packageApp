import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/error/failures.dart';
import 'package:my_custom_widget/features/notifications/domain/entity/notification_list.dart';
import 'package:my_custom_widget/features/notifications/domain/repositories/notification_repository.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/network_info.dart';
import '../datasource/notification_api_datasource.dart';

class NotificationsRepositoryImpl implements NotificationsRepositories {
  final NotificationsApiDataSource remoteDataSource;
  

  NotificationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, NotificationList>> getCustomerNotifications({Map<String, dynamic>? body}) async {
   
      try {
        final remoteCustomerNotifications = await remoteDataSource.getCustomerNotifications(body: body!);
        return Right(remoteCustomerNotifications);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }

  @override
  Future<Either<AppFailure, dynamic>> changeNotificationsReadStatus({Map<String, dynamic>? body}) async {
   
      try {
        final remoteChangeNotificationsReadStatus = await remoteDataSource.changeNotificationsReadStatus(body: body ?? {});
        return Right(remoteChangeNotificationsReadStatus);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }

  @override
  Future<Either<AppFailure, int>> getNumberOfUnreadNotifications() async {
   
      try {
        final remoteNumberOfUnreadNotifications = await remoteDataSource.getNumberOfUnreadNotifications();
        return Right(remoteNumberOfUnreadNotifications);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }
}
