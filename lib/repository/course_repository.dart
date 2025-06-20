import 'package:get/get_connect/http/src/response/response.dart';
import 'package:anycallmobile_trainingcenter/data/provider/client_api.dart';
import 'package:anycallmobile_trainingcenter/utils/app_constants.dart';

class CourseRepository {
  final ApiClient apiClient;
  CourseRepository(this.apiClient);

  Future<Response?> getCategoryBasedCourseList(String courseID) async {
    return apiClient.getData("${AppConstants.categoryCourses}/$courseID");
  }
}
