import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/config.dart';
import 'package:anycallmobile_trainingcenter/controller/auth_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/localization_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/splash_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/theme_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/user_controller.dart';
import 'package:anycallmobile_trainingcenter/data/model/response/language_model.dart';
import 'package:anycallmobile_trainingcenter/data/provider/client_api.dart';
import 'package:anycallmobile_trainingcenter/repository/auth_repo.dart';
import 'package:anycallmobile_trainingcenter/repository/splash_repo.dart';
import 'package:anycallmobile_trainingcenter/repository/user_repo.dart';
import 'package:anycallmobile_trainingcenter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  //those binding are used before called GetMaterial app
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() =>
      ApiClient(appBaseUrl: Config.baseUrl, sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(
      splashRepo:
          SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  Get.lazyPut(() => LocalizationController(
      sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthController(
      authRepo:
          AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
  Get.lazyPut(() => UserController(
          userRepo: UserRepo(
        sharedPreferences: Get.find(),
        apiClient: Get.find(),
      )));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/languages/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
