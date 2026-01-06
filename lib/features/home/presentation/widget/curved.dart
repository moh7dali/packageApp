import 'package:my_custom_widget/core/constants/assets_constants.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/features/category/domain/entities/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CurvedCategoryScroller extends StatefulWidget {
  final List<Category> items;
  final double itemWidth;
  final double radius;
  final int? selectedCategoryId;
  final void Function(Category) onTap;

  const CurvedCategoryScroller({
    super.key,
    required this.items,
    this.itemWidth = 90,
    this.radius = 280,
    required this.onTap,
    this.selectedCategoryId,
  });

  @override
  State<CurvedCategoryScroller> createState() => _CurvedCategoryScrollerState();
}

class _CurvedCategoryScrollerState extends State<CurvedCategoryScroller> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double totalHeight = Get.height * .25;
        final double topY = totalHeight * 0.4;
        final double bottomY = totalHeight * 1;
        final double curveDepth = totalHeight * 0.75;
        const double itemGap = 16.0;
        return SizedBox(
          height: totalHeight,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(width, totalHeight),
                painter: _DoubleArcBandPainter(color: AppTheme.whiteColor, topY: topY, bottomY: bottomY, curveDepth: curveDepth),
              ),

              ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: widget.items.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final double spacing = widget.itemWidth;
                  final double startPadding = 16;

                  final double itemCenterX = startPadding + index * spacing + spacing / 2 - _controller.offset;

                  final double t = (itemCenterX / width).clamp(0.0, 1.0);

                  final double yOnArc = topY - 2 * curveDepth * t * (1 - t);

                  const double extraOffset = 10;
                  final double dy = yOnArc + extraOffset;

                  return Transform.translate(
                    offset: Offset(0, dy),
                    child: SizedBox(
                      width: spacing,
                      child: _CategoryBubble(item: item, onTap: widget.onTap, isSelected: widget.selectedCategoryId == item.id),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryBubble extends StatelessWidget {
  final Category item;
  final void Function(Category) onTap;
  final bool isSelected;

  const _CategoryBubble({super.key, required this.item, required this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(item),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppTheme.primaryColor : AppTheme.secondaryColor,
              boxShadow: [BoxShadow(blurRadius: 8, spreadRadius: 1, offset: const Offset(0, 4), color: Colors.black.withOpacity(0.10))],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl ?? "",
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return SvgPicture.asset(AssetsConsts.iconLogo);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.name ?? "",
            style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12, isBold: true),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _DoubleArcBandPainter extends CustomPainter {
  final Color color;
  final double topY;
  final double bottomY;
  final double curveDepth;

  _DoubleArcBandPainter({required this.color, required this.topY, required this.bottomY, required this.curveDepth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, topY)
      ..quadraticBezierTo(size.width / 2, topY - curveDepth, size.width, topY)
      ..lineTo(size.width, bottomY)
      ..quadraticBezierTo(size.width / 2, bottomY - curveDepth, 0, bottomY)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
