import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/custom_app_bar.dart';
import 'package:anycallmobile_trainingcenter/controller/theme_controller.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/images.dart';
import 'package:anycallmobile_trainingcenter/utils/language_change.dart';
import 'package:anycallmobile_trainingcenter/utils/styles.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'setting'.tr,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color!,
        bgColor: Theme.of(context).cardColor,
      ),
      body: GetBuilder<ThemeController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Images.theme,
                          height: 16,
                          width: 16,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                        ),
                        const SizedBox(
                          width: Dimensions.paddingSizeDefault,
                        ),
                        Text('dark_mode'.tr,
                            style: robotoRegular.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!,
                                fontSize: Dimensions.fontSizeSmall)),
                      ],
                    ),
                    FlutterSwitch(
                      width: 40,
                      height: 20,
                      valueFontSize: 20,
                      toggleSize: 20,
                      borderRadius: 30,
                      padding: 1.0,
                      showOnOff: false,
                      toggleColor: Colors.white,
                      activeColor: const Color(0xffff0102),
                      inactiveColor: Colors.grey,
                      value: controller.darkTheme,
                      onToggle: (value) {
                        controller.toggleTheme();
                      },
                    )
                  ],
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Get.bottomSheet(const LanguageChange(),
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeSmall),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Images.languageChange,
                              height: 16,
                              width: 16,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.6),
                            ),
                            const SizedBox(
                              width: Dimensions.paddingSizeDefault,
                            ),
                            Text('language'.tr,
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!,
                                    fontSize: Dimensions.fontSizeSmall)),
                          ],
                        ),
                        Text("English",
                            style: robotoRegular.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!,
                                fontSize: Dimensions.fontSizeSmall))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
