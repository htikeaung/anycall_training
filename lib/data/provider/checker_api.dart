import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/custom_snackbar.dart';
import 'package:anycallmobile_trainingcenter/controller/auth_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode != 200) {
      Get.find<AuthController>().clearSharedData();
      Get.offAllNamed(RouteHelper.getSignInRoute('splash'));
    } else {
      customSnackBar("${response.statusCode!}".tr);
    }
  }
}
