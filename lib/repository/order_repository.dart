import 'package:get/get_connect/http/src/response/response.dart';
import 'package:anycallmobile_trainingcenter/data/provider/client_api.dart';
import 'package:anycallmobile_trainingcenter/utils/app_constants.dart';

class OrderRepository {
  final ApiClient apiClient;

  OrderRepository(this.apiClient);

  Future<Response?> getOrderHistory(int page, String type) async {
    return await apiClient
        .getData("${AppConstants.orderHistory}?type=$type&page=$page");
  }
}
