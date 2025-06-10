import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/data/provider/client_api.dart';

import '../utils/app_constants.dart';

class BookDetailRepository {
  final ApiClient apiClient;
  BookDetailRepository(this.apiClient);

  Future<Response?> getBookDetail(int id) async {
    return apiClient.getData("${AppConstants.bookDetail}/$id");
  }

  Future<Response?> getReviews(int id, int pageNumber) async {
    return apiClient
        .getData("${AppConstants.reviews}?id=$id&type=book&page=$pageNumber");
  }

  Future<Response?> writeReview(Map<String, dynamic> body) async {
    return apiClient.postData(AppConstants.writeReviews, body);
  }

  Future<Response?> getRelatedBooks(int pageNumber) async {
    return apiClient.getData("${AppConstants.latestBooks}?page=$pageNumber");
  }
}
