import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/assets_constants.dart';

import '../../../../core/utils/theme.dart';

class LoadingHistoryCard extends StatelessWidget {
  const LoadingHistoryCard({super.key, this.isDetails = true});
  final bool isDetails;

  @override
  Widget build(BuildContext context) {
    return isDetails
        ? Column(
            children: [
              Card(
                margin: const EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: Get.width * .45,
                                  height: Get.height * .018,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: Get.width * .45,
                                  height: Get.height * .018,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: Get.width * .45,
                                  height: Get.height * .018,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.asset(
                            AssetsConsts.loading,
                            width: 75,
                            height: 75,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                        child: ClipRRect(
                          borderRadius: AppTheme.borderRadius,
                          child: Image.asset(
                            AssetsConsts.loading,
                            width: 80,
                            height: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: Get.width * .5,
                                  height: Get.height * .012,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: Get.width * .5,
                                  height: Get.height * .012,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: Get.width * .5,
                                  height: Get.height * .012,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(
                                      AssetsConsts.loading,
                                      width: Get.width * .2,
                                      height: Get.height * .012,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(
                                      AssetsConsts.loading,
                                      width: Get.width * .25,
                                      height: Get.height * .012,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                        child: ClipRRect(
                          borderRadius: AppTheme.borderRadius,
                          child: Image.asset(
                            AssetsConsts.loading,
                            width: 80,
                            height: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: Get.width * .5,
                                  height: Get.height * .012,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: Get.width * .5,
                                  height: Get.height * .012,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: Get.width * .5,
                                  height: Get.height * .012,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(
                                      AssetsConsts.loading,
                                      width: Get.width * .2,
                                      height: Get.height * .012,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(
                                      AssetsConsts.loading,
                                      width: Get.width * .25,
                                      height: Get.height * .012,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(
                                      AssetsConsts.loading,
                                      width: Get.width * .45,
                                      height: Get.height * .012,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(
                                      AssetsConsts.loading,
                                      width: Get.width * .45,
                                      height: Get.height * .012,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(
                                      AssetsConsts.loading,
                                      width: Get.width * .3,
                                      height: Get.height * .012,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset(
                                AssetsConsts.loading,
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset(
                                AssetsConsts.loading,
                                width: Get.width * .7,
                                height: Get.height * .03,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset(
                                AssetsConsts.loading,
                                width: Get.width * .35,
                                height: Get.height * .012,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset(
                                AssetsConsts.loading,
                                width: Get.width * .35,
                                height: Get.height * .012,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset(
                                AssetsConsts.loading,
                                width: Get.width * .35,
                                height: Get.height * .012,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset(
                                AssetsConsts.loading,
                                width: Get.width * .35,
                                height: Get.height * .012,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset(
                                AssetsConsts.loading,
                                width: Get.width * .35,
                                height: Get.height * .012,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset(
                                AssetsConsts.loading,
                                width: Get.width * .35,
                                height: Get.height * .012,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.asset(
                            AssetsConsts.loading,
                            width: Get.width * .9,
                            height: Get.height * .005,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset(
                                AssetsConsts.loading,
                                width: Get.width * .35,
                                height: Get.height * .012,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset(
                                AssetsConsts.loading,
                                width: Get.width * .25,
                                height: Get.height * .012,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(2.0),
            itemCount: 5,
            itemBuilder: (_, index) => Card(
                  margin: const EdgeInsets.all(4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child: Image.asset(
                                            AssetsConsts.loading,
                                            width: Get.width * .25,
                                            height: Get.height * .012,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child: Image.asset(
                                            AssetsConsts.loading,
                                            width: Get.width * .25,
                                            height: Get.height * .012,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child: Image.asset(
                                            AssetsConsts.loading,
                                            width: Get.width * .25,
                                            height: Get.height * .012,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child: Image.asset(
                                            AssetsConsts.loading,
                                            width: Get.width * .3,
                                            height: Get.height * .012,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child: Image.asset(
                                            AssetsConsts.loading,
                                            width: Get.width * .25,
                                            height: Get.height * .012,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child: Image.asset(
                                            AssetsConsts.loading,
                                            width: Get.width * .31,
                                            height: Get.height * .012,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: 75,
                                  height: 75,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
  }
}

List<String> getStatus(int statusId) {
  switch (statusId) {
    case 1:
      return ['PendingForPayment', AssetsConsts.orderPendingForPayment, 'false'];
    case 2:
      return ['PendingForReview', AssetsConsts.orderReceived, 'false'];
    case 3:
      return ['PendingForApprove', AssetsConsts.orderReceived, 'false'];
    case 4:
      return ['InProgress', AssetsConsts.orderInProgress, 'false'];
    case 5:
      return ['ReadyForDelivery', AssetsConsts.orderReadyForDelivery, 'false'];
    case 6:
      return ['Canceled', AssetsConsts.orderCancel, 'false'];
    case 7:
      return ['Closed', AssetsConsts.orderApproved, 'false'];
    case 15:
      return ['ReadyForPickup', AssetsConsts.orderReadyForPickUp, 'false'];
    default:
      return ['unknown', AssetsConsts.mozaicLogo, 'false'];
  }
}
