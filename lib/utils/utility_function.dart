import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/utils/string.dart';

void ll(message) {
  log(message.toString());
}

Widget imageLoadingBuilder(context, child, loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }
  return const CustomLoadingAnimation(
    isTextVisible: false,
  );
}

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({
    this.isTextVisible = true,
    super.key,
    this.radius,
  });

  final bool isTextVisible;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(radius: radius ?? 20),
          if (isTextVisible) Text('${ksLoading.tr}...'),
        ],
      ),
    );
  }
}
