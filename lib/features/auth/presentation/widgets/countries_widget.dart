import 'package:my_custom_widget/shared/widgets/no_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../domain/entities/country.dart';
import '../getx/auth_controller.dart';

class CountriesWidget extends StatelessWidget {
  const CountriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              SharedHelper().closeAllDialogs();
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  height: Get.height * .65,
                  width: Get.width * .75,
                  decoration: BoxDecoration(
                      color: AppTheme.accentColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(.4))),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: controller.searchController,
                            textInputAction: TextInputAction.search,
                            style: AppTheme.textStyle(color: AppTheme.blackColor, size: AppTheme.size14),
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (value) {
                              controller.searchCountries(value);
                            },
                            decoration: InputDecoration(
                              hintText: 'search'.tr,
                              filled: true,
                              fillColor: Colors.white,
                              border: AppTheme.outLineBorder,
                              enabledBorder: AppTheme.outLineBorder,
                              focusedBorder: AppTheme.outLineBorder,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                              hintStyle: AppTheme.textStyle(color: AppTheme.greyColor, size: AppTheme.size14),
                            ),
                          ),
                        ),
                        controller.isLoadingCountries
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(25.sp),
                                child: Image.asset(
                                  AssetsConsts.loading,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Expanded(
                                child: PaginationListView<Country>(
                                  loadFirstList: () async =>
                                      controller.after ? await controller.getCountriesAfter() : await controller.getCountriesList(page: 1),
                                  loadMoreList: (page) => controller.getCountriesList(page: page),
                                  itemBuilder: (context, country) => Container(
                                    color: country.id == controller.selectedCountry.id ? AppTheme.primaryColor : null,
                                    child: ListTile(
                                      onTap: () {
                                        controller.selectCountry(country);
                                      },
                                      leading: Text(country.flag ?? "🇯🇴",
                                          style: AppTheme.textStyle(color: AppTheme.blackColor, size: AppTheme.size20, isBold: true)),
                                      title: Text(
                                        country.name ?? "",
                                        style: AppTheme.textStyle(
                                            color: country.id == controller.selectedCountry.id ? AppTheme.accentColor : AppTheme.blackColor,
                                            size: AppTheme.size14,
                                            isBold: true),
                                      ),
                                      trailing: Text(
                                        country.callingCode ?? "+962",
                                        style: AppTheme.textStyle(
                                            color: country.id == controller.selectedCountry.id ? AppTheme.accentColor : AppTheme.blackColor,
                                            size: AppTheme.size14,
                                            isBold: true),
                                      ),
                                    ),
                                  ),
                                  emptyWidget: NoItemWidget(),
                                  emptyText: "merchantsEmpty".tr,
                                  loadingWidget: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        AssetsConsts.loading,
                                        height: Get.height * .05,
                                        width: Get.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
