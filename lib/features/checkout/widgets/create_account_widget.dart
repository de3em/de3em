import 'package:flutter/material.dart';
import 'package:da3em/common/basewidget/custom_textfield_widget.dart';
import 'package:da3em/features/checkout/controllers/checkout_controller.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:provider/provider.dart';

class CreateAccountWidget extends StatelessWidget {
  const CreateAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutController>(
      builder: (context, checkoutController, _) {
        return Card(child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
              color: Theme.of(context).cardColor),
            child: Column( crossAxisAlignment:CrossAxisAlignment.start, children: [
              Row(children: [
                 SizedBox(
                  height: 24, width: 30,
                  child: Checkbox(
                    visualDensity: VisualDensity.compact,
                    side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(width: 2, color: Theme.of(context).primaryColor.withOpacity(0.10))),
                    checkColor: Colors.white,
                    value: checkoutController.isCheckCreateAccount,
                    onChanged: (bool? value) {
                      checkoutController.setIsCheckCreateAccount(value!, update: true);
                    },
                  ),
                ),

                Text(getTranslated('create_account_with', context)!,
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))

              ]),

              checkoutController.isCheckCreateAccount ?
              Column(
                children: [
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Container(
                      child: CustomTextFieldWidget(
                        hintText: getTranslated('minimum_password_length', context),
                        labelText: getTranslated('password', context),
                        controller: checkoutController.passwordController,
                        isPassword: true,
                        //nextFocus: _confirmPasswordFocus,
                        inputAction: TextInputAction.next,
                        // validator: (value)=> ValidateCheck.validatePassword(value, "password_must_be_required"),
                      )
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  Container(
                    child: CustomTextFieldWidget(
                      isPassword: true,
                      hintText: getTranslated('re_enter_password', context),
                      labelText: getTranslated('re_enter_password', context),
                      controller:  checkoutController.confirmPasswordController,
                      // focusNode: _confirmPasswordFocus,
                      inputAction: TextInputAction.done,
                      //validator: (value)=> ValidateCheck.validateConfirmPassword(value, _passwordController.text.trim()),
                    )),
                ],
              ) : const SizedBox(),
            ])
        ));
      }
    );

  }
}
