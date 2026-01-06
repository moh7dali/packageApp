import 'package:my_custom_widget/features/offers/presentation/getx/offers_controller.dart';
import 'package:my_custom_widget/features/offers/presentation/widgets/offer_widget.dart';
import 'package:my_custom_widget/shared/widgets/no_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../../notifications/presentation/widgets/notification_card_loading.dart';
import '../../domain/entity/offer.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OffersController>(
      init: OffersController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text("offers".tr.toUpperCase())),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PaginationListView<Offer>(
              loadFirstList: () async => await controller.getOffers(page: 1),
              loadMoreList: (page) async => controller.getOffers(page: page),
              isList: false,
              itemBuilder: (context, value) => OfferWidget(offer: value),
              emptyWidget: NoItemWidget(),
              emptyText: "offersEmpty".tr,
              loadingWidget: const NotificationCardLoading(),
            ),
          ),
        );
      },
    );
  }
}
