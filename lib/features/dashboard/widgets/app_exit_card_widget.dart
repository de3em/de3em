import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/custom_button_widget.dart';

class AppExitCard extends StatelessWidget {
  const AppExitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.only(bottom: 40, top: 15),
      decoration: BoxDecoration(color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeDefault))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 40,height: 4,decoration: BoxDecoration(color: Theme.of(context).hintColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(20)),),

        const SizedBox(height: 30,),
        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          child: SizedBox(width: 60,child: Image.asset(Images.exitIcon)),),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

        Text(getTranslated('close_the_app', context)!,
          style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
        Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
          child: Text('${getTranslated('do_you_want_to_close_and_exit_app', context)}'),),

        const SizedBox(height: Dimensions.paddingSizeDefault),
        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOverLarge),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Expanded(child: SizedBox(width: 120, child: CustomButton(buttonText: '${getTranslated('cancel', context)}',
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(.5),
              textColor: Theme.of(context).textTheme.bodyLarge?.color,
              onTap: ()=> Navigator.pop(context),))),

           const SizedBox(width: Dimensions.paddingSizeDefault,),
            Expanded(child: SizedBox(width: 120,
                child: CustomButton(buttonText: '${getTranslated('exit', context)}',
              onTap: ()=> SystemNavigator.pop())))]))
      ],),
    );
  }
}
