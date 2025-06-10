import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:anycallmobile_trainingcenter/utils/colors.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/widgets/custom_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.action,
    this.hasBackButton = true,
    required this.onBack,
    this.iconColor,
    this.titleColor,
    this.appBarColor,
    this.isCenterTitle,
    this.systemUiOverlayStyle,
    this.leadingWidget,
    this.leadingWidth,
    this.titleSpacing,
  });

  final dynamic title;
  final List<Widget>? action;
  final Function()? onBack;
  final bool hasBackButton;
  final bool? isCenterTitle;
  final Color? iconColor;
  final Color? titleColor;
  final Color? appBarColor;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final Widget? leadingWidget;
  final double? leadingWidth, titleSpacing;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: systemUiOverlayStyle ?? SystemUiOverlayStyle.dark,
      centerTitle: isCenterTitle ?? true,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: appBarColor ?? cWhiteColor,
      leadingWidth: leadingWidth ?? 50,
      titleSpacing: titleSpacing ?? 16,
      title: (title is String)
          ? Text(title.toString(),
              style: TextStyle(
                  fontSize: Dimensions.fontSizeBig,
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? cBlackColor))
          : title,
      leading: hasBackButton
          ? Center(
              child: CustomIconButton(
                onPress: onBack,
                iconColor: iconColor ?? cBlackColor,
                icon: Icons.arrow_back,
                size: 20,
              ),
            )
          : leadingWidget,
      actions: action,
    );
  }
}
