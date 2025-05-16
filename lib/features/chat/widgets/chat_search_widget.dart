import 'package:flutter/material.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/features/chat/controllers/chat_controller.dart';
import 'package:da3em/localization/controllers/localization_controller.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/common/basewidget/inbox_search_widget.dart';
import 'package:da3em/features/chat/widgets/chat_type_button_widget.dart';
import 'package:provider/provider.dart';


class ChatSearchWidget extends StatefulWidget {
  const ChatSearchWidget({super.key});

  @override
  State<ChatSearchWidget> createState() => _ChatSearchWidgetState();
}

class _ChatSearchWidgetState extends State<ChatSearchWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
        builder: (context, chat, _) {
          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Container(height: 48,
                decoration: BoxDecoration(color: Provider.of<ThemeController>(context).darkTheme ?
                Theme.of(context).canvasColor :Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(Dimensions.topSpace)),

                child: Stack(children: [
                  Positioned(child: Align(alignment: Alignment.centerRight,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal, children: [
                          ChatTypeButtonWidget(text: getTranslated('seller', context), index: 0),
                        ChatTypeButtonWidget(text: getTranslated('delivery-man', context), index: 1)]))),

                    InboxSearchWidget(width: MediaQuery.of(context).size.width,
                      textController: _textEditingController,
                      onSuffixTap: () {},
                      color: Theme.of(context).cardColor,
                      helpText: "Search Text...",
                      autoFocus: true,

                      style: textRegular.copyWith(color: Provider.of<ThemeController>(context).darkTheme ? Colors.white : Colors.black),
                      closeSearchOnSuffixTap: true,
                      onChanged: (value){
                        if(value != null){
                          //chat.searchChat(context, value, 0);
                        }
                      },
                      animationDurationInMilli: 200,
                      rtl: !Provider.of<LocalizationController>(context).isLtr,
                    ),
                  ],
                )),
          );
        }
    );
  }
}
