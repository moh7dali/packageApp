import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/features/home/domain/entities/slider.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';

class SliderAdsWidget extends StatefulWidget {
  const SliderAdsWidget({super.key, required this.slides, required this.isLoading});

  final bool isLoading;
  final List<SliderItem> slides;

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<SliderAdsWidget> {
  int _current = 0;
  bool isStart = false;
  final CarouselSliderController _controller = CarouselSliderController();

  List<Widget> imageSliders() {
    return widget.slides
        .map(
          (item) => GestureDetector(
            onTap: () {
              switch (item.assignTypeId) {
                case SliderAssignType.noAssign:
                  break;
                case SliderAssignType.assignedToBrand:
                  break;
              }
            },
            child: ClipRRect(
              borderRadius: AppTheme.borderRadius,
              child: Image.network(
                item.imageUrl ?? "",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(AssetsConsts.imageError, width: Get.width, fit: BoxFit.cover),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  }
                  return ClipRRect(
                    borderRadius: AppTheme.borderRadius,
                    child: Image.asset(AssetsConsts.loading, fit: BoxFit.cover, width: Get.height),
                  );
                },
                width: Get.height,
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> loadings() {
    return [
      ClipRRect(
        borderRadius: AppTheme.borderRadius,
        child: Image.asset(AssetsConsts.loading, fit: BoxFit.cover, width: Get.height),
      ),
      ClipRRect(
        borderRadius: AppTheme.borderRadius,
        child: Image.asset(AssetsConsts.loading, fit: BoxFit.cover, width: Get.height),
      ),
      ClipRRect(
        borderRadius: AppTheme.borderRadius,
        child: Image.asset(AssetsConsts.loading, fit: BoxFit.cover, width: Get.height),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return widget.slides.isEmpty
        ? Container()
        : SizedBox(
            height: Get.height * .3,
            child: Column(
              children: [
                Expanded(
                  child: CarouselSlider(
                    items: widget.isLoading ? loadings() : imageSliders(),
                    carouselController: _controller,
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 4),
                      autoPlayAnimationDuration: Duration(milliseconds: 300),
                      height: Get.height * .35,
                      enlargeCenterPage: true,
                      aspectRatio: 0.1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                          isStart = true;
                        });
                        Future.delayed(Duration(milliseconds: 100), () {
                          if (mounted) {
                            setState(() {
                              isStart = false;
                            });
                          }
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.slides.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: _current == entry.key ? 40.0 : 15,
                        height: 6.0,
                        margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Color(0xff869AA3)),
                        child: _current == entry.key
                            ? Row(
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(seconds: 4),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppTheme.primaryColor),
                                    height: 6.0,
                                    width: isStart ? 15 : 40.0,
                                  ),
                                ],
                              )
                            : Container(),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
  }
}
