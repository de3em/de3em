import 'package:flutter/material.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String? buttonText;
  final bool isBuy;
  final bool isBorder;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? radius;
  final double? fontSize;
  final String? leftIcon;
  final double? borderWidth;

  const CustomButton(
      {super.key,
      this.onTap,
      required this.buttonText,
      this.isBuy = false,
      this.isBorder = false,
      this.backgroundColor,
      this.radius,
      this.textColor,
      this.fontSize,
      this.leftIcon,
      this.borderColor,
      this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leftIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SizedBox(
                  width: 30,
                  child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    child: Image.asset(leftIcon!),
                  )),
            ),
          Flexible(
            child: Text(buttonText ?? ""),
          ),
        ],
      ),
    );
  }
}
