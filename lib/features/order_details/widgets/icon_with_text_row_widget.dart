import 'package:flutter/material.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:provider/provider.dart';

class IconWithTextRowWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final String? imageIcon;
  final Color? iconColor;
  final Color? textColor;
  final bool isTitle;

  const IconWithTextRowWidget({
    super.key,
    required this.text,
    required this.icon,
    this.iconColor,
    this.textColor,
    this.isTitle = false,
    this.imageIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center the row content
      crossAxisAlignment: CrossAxisAlignment.center, // Align items in the center vertically
      children: [
        imageIcon != null
            ? Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: 17,
            child: Image.asset(
              imageIcon!,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
          ),
        )
            : Icon(
          icon,
          color: Provider.of<ThemeController>(context, listen: false).darkTheme
              ? Colors.white
              : Theme.of(context).primaryColor.withOpacity(0.30),
          size: Dimensions.iconSizeDefault,
        ),
        const SizedBox(width: Dimensions.marginSizeSmall),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center, // Center the text
            style: titilliumRegular.copyWith(
              fontSize: isTitle ? Dimensions.fontSizeLarge + 3 : Dimensions.fontSizeDefault + 3, // Enlarge font size
              color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ],
    );
  }
}
