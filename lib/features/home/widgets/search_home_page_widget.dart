import 'package:flutter/material.dart';
import 'package:da3em/localization/controllers/localization_controller.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:provider/provider.dart';

class SearchHomePageWidget extends StatelessWidget {
  const SearchHomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.homePagePadding,
          vertical: Dimensions.paddingSizeSmall),
      alignment: Alignment.center,
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 40,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Provider.of<ThemeController>(context, listen: false)
                        .darkTheme
                    ? Colors.transparent
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
              size: Dimensions.iconSizeSmall,
            ),
          ),
          Text(getTranslated('search_hint', context) ?? '',
              style: textRegular.copyWith(color: Theme.of(context).hintColor)),
        ]),
      ),
    );
  }
}
