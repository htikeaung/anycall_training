import 'package:get/get_connect/http/src/response/response.dart';
import 'package:anycallmobile_trainingcenter/data/provider/client_api.dart';
import 'package:anycallmobile_trainingcenter/utils/app_constants.dart';

class CategoryRepository {
  final ApiClient apiClient;
  CategoryRepository(this.apiClient);

  Future<Response?> getCategoryList() async {
    return apiClient.getData(AppConstants.courseCategories);
  }
}
