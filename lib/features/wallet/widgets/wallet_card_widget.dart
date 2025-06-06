import 'package:flutter/material.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/features/wallet/controllers/wallet_controller.dart';
import 'package:da3em/features/wallet/widgets/add_fund_dialogue_widget.dart';
import 'package:da3em/helper/price_converter.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:provider/provider.dart';

class WalletCardWidget extends StatelessWidget {
  const WalletCardWidget({super.key, required this.tooltipController, required this.focusNode,
    required this.inputAmountController});

  final JustTheController tooltipController;
  final FocusNode focusNode;
  final TextEditingController inputAmountController;

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletController>(builder: (context, profile, _) {
      return Row(children: [
          Expanded(flex: 8,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(getTranslated('wallet_amount', context)!,
                    style:  textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge)),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Row(children: [
                    Text(PriceConverter.convertPrice(context,
                        (profile.walletBalance != null && profile.walletBalance!.totalWalletBalance != null) ?
                        profile.walletBalance!.totalWalletBalance ?? 0 : 0),
                        style:  textBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeOverLarge)),

                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                    JustTheTooltip(backgroundColor: Colors.black87,
                      controller: tooltipController,
                      preferredDirection: AxisDirection.down,
                      tailLength: 10,
                      tailBaseWidth: 20,
                      content: Container(width: MediaQuery.of(context).size.width * 0.57,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: Text(getTranslated('if_you_want_to_add_fund_to_your_wallet_then_click_add_fund_button', context)!,
                            style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault))),
                      child: InkWell(onTap: () => tooltipController.showTooltip(),
                        child: const Icon(Icons.info_outline, color: Colors.white))),
                  ],
                ),
              ],
            ),
          ),
          if(Provider.of<SplashController>(context, listen: false).configModel?.addFundsToWallet == 1)
          Expanded(child: InkWell(onTap: () {
                showDialog(context: context, builder: (BuildContext context) {
                  return AddFundDialogueWidget(focusNode: focusNode, inputAmountController: inputAmountController);
                });
              },
              child: Container(decoration: (const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                child: Icon(Icons.add, color: Theme.of(context).primaryColor, size: 20)),
            ),
          ),
        ],
      );
    });
  }
}
