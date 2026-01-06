import 'package:my_custom_widget/features/ordering/domain/entity/create_order.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_checkout_data.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_details.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_history.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/payment_status.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api/api_response.dart';
import '../../../../core/error/failures.dart';

abstract class OrderingRepositories {
  Future<Either<AppFailure, OrderCheckoutData>> getOrderCheckoutData({required Map<String, dynamic> body});

  Future<Either<AppFailure, ApiResponse<CreateOrder>>> createOrder({required Map<String, dynamic> body});

  Future<Either<AppFailure, OrderHistoryList>> getCustomerOrders({required Map<String, dynamic> body});

  Future<Either<AppFailure, OrderDetails>> getOrderDetails({required Map<String, dynamic> body});

  Future<Either<AppFailure, OrderingStatus>> checkOrderingStatus({required Map<String, dynamic> body});

  Future<Either<AppFailure, PaymentStatus>> checkOrderPaymentStatus({required Map<String, dynamic> body});

  Future<Either<AppFailure, dynamic>> logPaymentFailure({required Map<String, dynamic> body});

  Future<Either<AppFailure, dynamic>> cancelOrderPayment({required Map<String, dynamic> body});
}
