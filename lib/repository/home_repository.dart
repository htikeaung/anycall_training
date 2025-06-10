import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/controller/splash_controller.dart';

import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';

class HomeRepository {
  final ApiClient apiClient;
  HomeRepository({required this.apiClient});

  Future<Response?> getHomeData() async {
    return apiClient.getData(AppConstants.homeScreen);
  }

  Future<Response?> getLatestCourse(int page) async {
    final splashController = Get.find<SplashController>();
    final configModel = splashController.configModel;
    final data = configModel?.data;
    final appConfig = data?.appConfig;
    final currency = appConfig?.defaultCurrency;

    if (currency == null) {
      // Optionally log or show a message here
      return null;
    }

    return apiClient
        .getData("${AppConstants.latestCourse}?page=$page&currency=$currency");
  }
}
