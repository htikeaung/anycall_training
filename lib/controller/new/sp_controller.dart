import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kBearerToken = 'kBearerToken';

class SpController {
  //* save Bearer Token
  Future<void> saveBearerToken(token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kBearerToken, token.toString());
  }

  Future<String?> getBearerToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kBearerToken);
  }

  //* on logout
  Future<void> onLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(kBearerToken);
    Get.offAllNamed(RouteHelper.getSignInRoute(""));
  }
}
