import 'package:flutter/material.dart';
import 'package:da3em/features/notification/controllers/notification_controller.dart';
import 'package:da3em/features/profile/controllers/profile_contrroller.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:provider/provider.dart';

class MenuButtonWidget extends StatelessWidget {
  final IconData icon;
  final String? title;
  final Widget navigateTo;
  final bool isNotification;
  final bool isProfile;
  const MenuButtonWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.navigateTo,
      this.isNotification = false,
      this.isProfile = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: isNotification
            ? Consumer<NotificationController>(
                builder: (context, notificationController, _) {
                return CircleAvatar(
                  radius: 10,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                      notificationController
                              .notificationModel?.newNotificationItem
                              .toString() ??
                          '0',
                      style: textRegular.copyWith(
                          color: ColorResources.white,
                          fontSize: Dimensions.fontSizeSmall)),
                );
              })
            : isProfile
                ? Consumer<ProfileController>(
                    builder: (context, profileProvider, _) {
                    return CircleAvatar(
                        radius: 10,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                            profileProvider.userInfoModel?.referCount
                                    .toString() ??
                                '0',
                            style: textRegular.copyWith(
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeSmall)));
                  })
                : const SizedBox(),
        leading: Icon(icon),
        title: Text(
          title!,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => navigateTo)));
  }
}
