import 'package:flutter/material.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/features/deal/controllers/flash_deal_controller.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/common/basewidget/custom_app_bar_widget.dart';
import 'package:da3em/common/basewidget/title_row_widget.dart';
import 'package:da3em/features/deal/widgets/flash_deals_list_widget.dart';
import 'package:provider/provider.dart';

class FlashDealScreenView extends StatefulWidget {
  const FlashDealScreenView({super.key});
  @override
  State<FlashDealScreenView> createState() => _FlashDealScreenViewState();
}
class _FlashDealScreenViewState extends State<FlashDealScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(title: getTranslated('flash_deal', context)),
        Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: TitleRowWidget(title: getTranslated('flash_deal', context),
            eventDuration: Provider.of<FlashDealController>(context).duration, isDetailsPage: true, ),),
        Expanded(child: RefreshIndicator(
          onRefresh: () async => await Provider.of<FlashDealController>(context, listen: false).getFlashDealList(true, false),
          child: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: FlashDealsListWidget(isHomeScreen: false))))]));
  }
}
