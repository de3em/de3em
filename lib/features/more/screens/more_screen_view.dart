import 'package:flutter/material.dart';
import 'package:da3em/features/loyaltyPoint/controllers/loyalty_point_controller.dart';
import 'package:da3em/features/more/screens/profile_screen_info.dart';
import 'package:da3em/features/order_details/screens/guest_track_order_screen.dart';
import 'package:da3em/features/profile/controllers/profile_contrroller.dart';
import 'package:da3em/features/profile/screens/profile_screen.dart';
import 'package:da3em/features/support/screens/support_ticket_screen.dart';
import 'package:da3em/features/wallet/controllers/wallet_controller.dart';
import 'package:da3em/utill/app_constants.dart';
import 'package:da3em/features/more/widgets/logout_confirm_bottom_sheet_widget.dart';
import 'package:da3em/features/auth/screens/auth_screen.dart';
import 'package:da3em/features/chat/screens/inbox_screen.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/features/auth/controllers/auth_controller.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/features/category/screens/category_screen.dart';
import 'package:da3em/features/compare/screens/compare_product_screen.dart';
import 'package:da3em/features/contact_us/screens/contact_us_screen.dart';
import 'package:da3em/features/coupon/screens/coupon_screen.dart';
import 'package:da3em/features/more/screens/html_screen_view.dart';
import 'package:da3em/features/more/widgets/profile_info_section_widget.dart';
import 'package:da3em/features/more/widgets/more_horizontal_section_widget.dart';
import 'package:da3em/features/notification/screens/notification_screen.dart';
import 'package:da3em/features/address/screens/address_list_screen.dart';
import 'package:da3em/features/refer_and_earn/screens/refer_and_earn_screen.dart';
import 'package:da3em/features/setting/screens/settings_screen.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'faq_screen_view.dart';
import 'package:da3em/features/more/widgets/title_button_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late bool isGuestMode;
  String? version;
  bool singleVendor = false;

  @override
  void initState() {
    isGuestMode =
        !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    if (Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
      version = Provider.of<SplashController>(context, listen: false)
              .configModel!
              .softwareVersion ??
          'version';
      Provider.of<ProfileController>(context, listen: false)
          .getUserInfo(context);
      if (Provider.of<SplashController>(context, listen: false)
              .configModel!
              .walletStatus ==
          1) {
        Provider.of<WalletController>(context, listen: false)
            .getTransactionList(context, 1, 'all');
      }
      if (Provider.of<SplashController>(context, listen: false)
              .configModel!
              .loyaltyPointStatus ==
          1) {
        Provider.of<LoyaltyPointController>(context, listen: false)
            .getLoyaltyPointList(context, 1);
      }
    }
    singleVendor = Provider.of<SplashController>(context, listen: false)
            .configModel!
            .businessMode ==
        "single";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var splashController =
        Provider.of<SplashController>(context, listen: false);
    var authController = Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: ProfileInfoSectionWidget(),
        actions: [
          SizedBox(
            width: 40,
            child: IconButton(
                onPressed: () {
                  MaterialPageRoute(builder: (_) => const SettingsScreen());
                },
                icon: Icon(
                  Iconsax.setting,
                  size: 20,
                )),
          ),
          SizedBox(
            width: 40,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const NotificationScreen()));
                },
                icon: Icon(Iconsax.notification)),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text("Ordering informations"),
                      enabled: false,
                      subtitle: MoreHorizontalSection(),
                    ),
                    // const SizedBox(height: 10),
                    // const Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 0),
                    //     child: Center(child: )),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(
                    //       Dimensions.paddingSizeDefault,
                    //       Dimensions.paddingSizeDefault,
                    //       Dimensions.paddingSizeDefault,
                    //       0),
                    //   child: Text(
                    //     getTranslated('general', context) ?? '',
                    //     style: textRegular.copyWith(
                    //         fontSize: Dimensions.fontSizeExtraLarge,
                    //         color: Theme.of(context).colorScheme.onPrimary),
                    //   ),
                    // ),
                    // Divider(thickness: 10, color: Colors.grey.withOpacity(0.3)),
                    Container(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      child: ListTile(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ProfileScreenInfo();
                              });
                        },
                        trailing: TextButton(
                            onPressed: () {}, child: Icon(Iconsax.arrow_right)),
                        leading: Icon(Iconsax.user, color: Colors.grey),

                        title: Text("المعلومات الشخصية"),
                        subtitleTextStyle:
                            TextStyle(color: Colors.grey, fontSize: 13),
                        subtitle:
                            Text("عرض وتعديل معلوماتي الشخصية"),
                        // MenuButtonWidget(
                        //     icon: Iconsax.sms_tracking,
                        //     title: getTranslated('TRACK_ORDER', context),
                        //     navigateTo: const GuestTrackOrderScreen()),

                        // if (splashController.configModel!.activeTheme !=
                        //         "default" &&
                        //     authController.isLoggedIn())
                        //   MenuButtonWidget(

                        //       title:
                        //           getTranslated('compare_products', context),
                        //       navigateTo: const CompareProductScreen()),
                        // MenuButtonWidget(
                        //   ico
                        //     title: getTranslated(
                        //       'notification',
                        //       context,
                        //     ),
                        //     isNotification: true,
                        //     navigateTo: const NotificationScreen()),
                        // MenuButtonWidget(
                        //     icon: Iconsax.setting,
                        //     title: getTranslated('settings', context),
                        //     navigateTo: const SettingsScreen())
                      ),
                    ),
                    // Divider(thickness: 10, color: Colors.grey.withOpacity(0.3)),

                    ListTile(
                      leading:
                          Icon(Iconsax.message_question, color: Colors.grey),
                      title: Text(
                          getTranslated('help_and_support', context) ?? ""),
                      enabled: false,
                    ),

                    // become a seller (open sellwithus.da3em.net)
                    ListTile(
                      leading: Icon(Iconsax.shop, color: Colors.red),
                      title: Text("أفتح متجرك في داعم"),
                      onTap: () {
                        launchUrlString("http://sellwithus.da3em.net");
                      },
                    ),

                    Column(children: [
                      // singleVendor
                      //     ? const SizedBox()
                      //     : MenuButtonWidget(
                      //         icon: Iconsax.direct_inbox,
                      //         title: getTranslated('inbox', context),
                      //         navigateTo: const InboxScreen()),
                      MenuButtonWidget(
                          icon: Iconsax.call_add,
                          title: getTranslated('contact_us', context),
                          navigateTo: const ContactUsScreen()),
                      MenuButtonWidget(
                          icon: Iconsax.ticket_star,
                          title: getTranslated('support_ticket', context),
                          navigateTo: const SupportTicketScreen()),

                        
                      // MenuButtonWidget(
                      //     icon: Iconsax.note,
                      //     title: getTranslated('terms_condition', context),
                      //     navigateTo: HtmlViewScreen(
                      //       title:
                      //           getTranslated('terms_condition', context),
                      //       url: Provider.of<SplashController>(context,
                      //               listen: false)
                      //           .configModel!
                      //           .termsConditions,
                      //     )),
                      // MenuButtonWidget(
                      //     icon: Icons.privacy_tip_outlined,
                      //     title: getTranslated('privacy_policy', context),
                      //     navigateTo: HtmlViewScreen(
                      //       title: getTranslated('privacy_policy', context),
                      //       url: Provider.of<SplashController>(context,
                      //               listen: false)
                      //           .configModel!
                      //           .privacyPolicy,
                      //     )),
                      // if (Provider.of<SplashController>(context,
                      //             listen: false)
                      //         .configModel!
                      //         .refundPolicy!
                      //         .status ==
                      //     1)
                      //   MenuButtonWidget(
                      //       icon: Iconsax.refresh_left_square,
                      //       title: getTranslated('refund_policy', context),
                      //       navigateTo: HtmlViewScreen(
                      //         title:
                      //             getTranslated('refund_policy', context),
                      //         url: Provider.of<SplashController>(context,
                      //                 listen: false)
                      //             .configModel!
                      //             .refundPolicy!
                      //             .content,
                      //       )),
                      // if (Provider.of<SplashController>(context,
                      //             listen: false)
                      //         .configModel!
                      //         .returnPolicy!
                      //         .status ==
                      //     1)
                      //   MenuButtonWidget(
                      //       icon: Iconsax.money_recive,
                      //       title: getTranslated('return_policy', context),
                      //       navigateTo: HtmlViewScreen(
                      //         title:
                      //             getTranslated('return_policy', context),
                      //         url: Provider.of<SplashController>(context,
                      //                 listen: false)
                      //             .configModel!
                      //             .returnPolicy!
                      //             .content,
                      //       )),
                      // if (Provider.of<SplashController>(context,
                      //             listen: false)
                      //         .configModel!
                      //         .cancellationPolicy!
                      //         .status ==
                      //     1)
                      //   MenuButtonWidget(
                      //       icon: Iconsax.truck_remove,
                      //       title: getTranslated(
                      //           'cancellation_policy', context),
                      //       navigateTo: HtmlViewScreen(
                      //         title: getTranslated(
                      //             'cancellation_policy', context),
                      //         url: Provider.of<SplashController>(context,
                      //                 listen: false)
                      //             .configModel!
                      //             .cancellationPolicy!
                      //             .content,
                      //       )),
                      MenuButtonWidget(
                          icon: Iconsax.message_question,
                          title: getTranslated('faq', context),
                          navigateTo: FaqScreen(
                            title: getTranslated('faq', context),
                          )),
                      MenuButtonWidget(
                          icon: Iconsax.user,
                          title: getTranslated('about_us', context),
                          navigateTo: HtmlViewScreen(
                            title: getTranslated('about_us', context),
                            url: Provider.of<SplashController>(context,
                                    listen: false)
                                .configModel!
                                .aboutUs,
                          ))
                    ]),
                    ListTile(
                        leading: Icon(Iconsax.logout,
                            color: Theme.of(context).colorScheme.error),
                        title: Text(
                          isGuestMode
                              ? getTranslated('sign_in', context)!
                              : getTranslated('sign_out', context)!,
                        ),
                        onTap: () {
                          if (isGuestMode) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AuthScreen()));
                          } else {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) =>
                                    const LogoutCustomBottomSheetWidget());
                          }
                        }),
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.paddingSizeDefault),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${getTranslated('version', context)} ${AppConstants.appVersion}',
                                style: TextStyle(color: Colors.grey),
                              )
                            ]))
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
