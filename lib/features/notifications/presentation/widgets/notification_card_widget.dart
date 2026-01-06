import 'package:my_custom_widget/features/notifications/domain/entity/notification.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/image_preview_widget.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({super.key, required this.notification, required this.onTap});

  final NotificationInfo notification;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final isUnread = notification.isRead == false;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: isUnread ? AppTheme.primaryColor.withOpacity(.06) : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: isUnread ? AppTheme.primaryColor.withOpacity(.22) : AppTheme.primaryColor.withOpacity(.10)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 18, offset: const Offset(0, 10))],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Left indicator + icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(.10),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.primaryColor.withOpacity(.16)),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.notifications_none_rounded, color: AppTheme.primaryColor, size: 24),
                      if (isUnread)
                        Positioned(
                          top: 9,
                          right: 10,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // ✅ Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.subject,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16, isBold: true),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.message.trim(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.80), size: AppTheme.size14),
                      ),
                      const SizedBox(height: 10),

                      // ✅ time pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppTheme.primaryColor.withOpacity(.12)),
                        ),
                        child: Text(
                          DateFormat("HH:mm a dd-MM-yyyy").format(notification.creationDate),
                          style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.70), size: AppTheme.size12, isBold: true),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // ✅ Image preview (if exists)
                if (notification.imageUrl != null)
                  GestureDetector(
                    onTap: () {
                      context.pushTransparentRoute(ImagePreview(image: notification.imageUrl ?? ""));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: CachedNetworkImage(
                        imageUrl: notification.imageUrl ?? "",
                        placeholder: (w, e) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
                        errorWidget: (c, e, s) => Image.asset(AssetsConsts.imageError),
                        width: 78,
                        height: 78,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
