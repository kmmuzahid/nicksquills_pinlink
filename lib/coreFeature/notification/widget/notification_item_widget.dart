/*
 * @Author: Km Muzahid
 * @Date: 2026-01-17 09:51:26
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit_internal.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:core_kit/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/coreFeature/notification/model/notification_model.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationModel notificationModel;
  final IconData icon;
  final VoidCallback? onTap;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  const NotificationItemWidget({
    super.key,
    required this.notificationModel,
    this.icon = Icons.notifications,
    this.onTap,
    required this.onReject,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isFriendRequest = notificationModel.type == 'friend_request';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        decoration: BoxDecoration(
          color: context.colors.bACKGROUND_darkCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isFriendRequest &&
                    notificationModel.profile != null &&
                    notificationModel.profile!.isNotEmpty
                ? CommonImage(
                    size: 44,
                    src: notificationModel.profile!,
                    borderRadius: 44,
                  )
                : Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: !notificationModel.isRead
                          ? context.colors.pRIMARY_priSoft
                          : theme.colorScheme.primary,
                      size: 22,
                    ),
                  ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CommonText(
                          text: notificationModel.title ?? '',
                          maxLines: 1,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: context.colors.pRIMARY_priSoft,
                            fontWeight: notificationModel.isRead
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ),

                      CommonText(
                        text: notificationModel.createdAt?.ago ?? '',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: notificationModel.isRead
                              ? context.colors.tEXT_subDark
                              : context.colors.tEXT_white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    notificationModel.message ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: notificationModel.isRead
                          ? context.colors.tEXT_subDark
                          : context.colors.tEXT_white,
                    ),
                  ),

                  if (isFriendRequest) ...[
                    8.height,
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        CommonButton(
                          buttonColor: Colors.transparent,
                          borderColor:
                              context.colors.bACKGROUND_darkCardBoarder,
                          titleColor: context.colors.sTATUS_error,
                          buttonHeight: 40,
                          onTap: () {
                            onReject();
                          },
                          titleText: 'Reject',
                        ),

                        const SizedBox(width: 12),
                        CommonButton(
                          buttonColor: Colors.transparent,
                          borderColor:
                              context.colors.bACKGROUND_darkCardBoarder,
                          titleColor: context.colors.tEXT_white,
                          buttonHeight: 40,
                          onTap: () {
                            onAccept();
                          },
                          titleText: 'Accept',
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
