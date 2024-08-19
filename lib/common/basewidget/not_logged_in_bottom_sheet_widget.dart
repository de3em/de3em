import 'package:flutter/material.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/custom_button_widget.dart';
import 'package:da3em/features/auth/screens/auth_screen.dart';

class NotLoggedInBottomSheetWidget extends StatelessWidget {
  const NotLoggedInBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return const AuthScreen();
    return Container(
      padding: const EdgeInsets.only(bottom: 40, top: 15),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeDefault))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(
          //   width: 40,
          //   height: 5,
          //   decoration: BoxDecoration(color: Theme.of(context).hintColor.withOpacity(.5), borderRadius: BorderRadius.circular(20)),
          // ),
          // const SizedBox(
          //   height: 40,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          //   child: SizedBox(width: 60, child: Image.asset(Images.loginIcon)),
          // ),
          const SizedBox(
            height: Dimensions.paddingSizeExtraSmall,
          ),
          Text(
            getTranslated('please_login', context)!,
            style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
            child: Text('${getTranslated('need_to_login', context)}'),
          ),
          // phone number fform field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: getTranslated('phone_number', context),
                hintStyle: const TextStyle(color: Colors.grey),
                // fillColor: Theme.of(context).backgroundColor,
                filled: true,
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.phone),
              ),
            ),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOverLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: SizedBox(
                        width: 120,
                        child: CustomButton(
                          buttonText: '${getTranslated('cancel', context)}',
                          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(.5),
                          textColor: Theme.of(context).textTheme.bodyLarge?.color,
                          onTap: () => Navigator.pop(context),
                        ))),
                const SizedBox(
                  width: Dimensions.paddingSizeExtraLarge,
                ),
                Expanded(
                  child: SizedBox(
                    width: 120,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
                      },
                      label: Text('${getTranslated('login', context)}'),
                      icon: Icon(Icons.person),
                    ),
                    
                    //  CustomButton(
                    //   buttonText: '${getTranslated('login', context)}',
                    //   backgroundColor: Theme.of(context).primaryColor,
                    //   onTap: () {
                    //     Navigator.of(context).pop();
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
                    //   },
                    // ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
