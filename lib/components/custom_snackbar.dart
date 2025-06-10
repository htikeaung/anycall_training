import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';

void customSnackBar(String? message, {bool isError = true}) {
  if (message != null && message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : const Color(0xffff0102),
      message: message,
      maxWidth: Get.width,
      duration: const Duration(seconds: 2),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      borderRadius: Dimensions.radiusSmall,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}
