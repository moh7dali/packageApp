import 'package:my_custom_widget/features/ordering/data/models/order_details_model.dart';
import 'package:my_custom_widget/features/ordering/data/models/order_history_model.dart';
import 'package:my_custom_widget/features/ordering/data/models/payment_status_model.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/create_order.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_checkout_data.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_details.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_history.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/api/api_response.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entity/payment_status.dart';
import '../models/create_order_model.dart';
import '../models/order_checkout_data_model.dart';

abstract class OrderingApiDataSource {
  Future<OrderCheckoutData> getOrderCheckoutData({required Map<String, dynamic> body});

  Future<ApiResponse<CreateOrder>> createOrderApi({required Map<String, dynamic> body});

  Future<OrderHistoryList> getCustomerOrders({required Map<String, dynamic> body});

  Future<OrderDetails> getOrderDetails({required Map<String, dynamic> body});

  Future<OrderingStatus> checkOrderingStatus({required Map<String, dynamic> body});

  Future<PaymentStatus> checkOrderPaymentStatus({required Map<String, dynamic> body});

  Future<dynamic> logPaymentFailure({required Map<String, dynamic> body});

  Future<dynamic> cancelOrderPayment({required Map<String, dynamic> body});
}

class OrderingApiDataSourceImpl implements OrderingApiDataSource {
  @override
  Future<OrderCheckoutData> getOrderCheckoutData({required Map<String, dynamic> body}) async {
    OrderCheckoutData orderCheckoutData = await ApiRequest<OrderCheckoutData>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getOrderCheckoutData,
      body: body,
      authorized: true,
      fromJson: OrderCheckoutDataModel.fromJson,
    );
    return orderCheckoutData;
  }

  @override
  Future<ApiResponse<CreateOrder>> createOrderApi({required Map<String, dynamic> body}) async {
    final createOrder = await ApiRequest<CreateOrder>().requestFullResponse(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.createOrder,
      body: body,
      authorized: true,
      fromJson: CreateOrderModel.fromJson,
    );
    return createOrder;
  }

  @override
  Future<OrderHistoryList> getCustomerOrders({required Map<String, dynamic> body}) async {
    OrderHistoryList orderHistoryList = await ApiRequest<OrderHistoryList>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getCustomerOrder,
      body: body,
      authorized: true,
      fromJson: OrderHistoryListModel.fromJson,
    );
    return orderHistoryList;
  }

  @override
  Future<OrderDetails> getOrderDetails({required Map<String, dynamic> body}) async {
    OrderDetails orderDetails = await ApiRequest<OrderDetails>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getOrderDetails,
      body: {},
      queryParameters: body,
      authorized: true,
      fromJson: OrderDetailsModel.fromJson,
    );
    return orderDetails;
  }

  @override
  Future<OrderingStatus> checkOrderingStatus({required Map<String, dynamic> body}) async {
    OrderingStatus orderingStatus = await ApiRequest<OrderingStatus>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.checkOrderingStatus,
      body: body,
      authorized: true,
      fromJson: OrderingStatusModel.fromJson,
    );
    return orderingStatus;
  }

  @override
  Future<PaymentStatus> checkOrderPaymentStatus({required Map<String, dynamic> body}) async {
    PaymentStatus paymentStatus = await ApiRequest<PaymentStatus>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.checkOrderPaymentStatus,
      body: body,
      authorized: true,
      fromJson: PaymentStatusModel.fromJson,
    );
    return paymentStatus;
  }

  @override
  Future cancelOrderPayment({required Map<String, dynamic> body}) async {
    dynamic cancel = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.cancelOrderPayment,
      body: {},
      queryParameters: body,
      authorized: true,
      fromJson: getDynamic,
    );
    return cancel;
  }

  @override
  Future logPaymentFailure({required Map<String, dynamic> body}) async {
    dynamic fail = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.logPaymentFailure,
      body: body,
      authorized: true,
      fromJson: getDynamic,
    );
    return fail;
  }
}
