import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/controller/new/sp_controller.dart';
import 'package:anycallmobile_trainingcenter/data/model/common_model/common_data_model.dart';
import 'package:anycallmobile_trainingcenter/data/model/new/all_courses_list_model.dart';
import 'package:anycallmobile_trainingcenter/data/model/new/blog_details_model.dart';
import 'package:anycallmobile_trainingcenter/services/api_services.dart';
import 'package:anycallmobile_trainingcenter/utils/string.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../components/custom_snackbar.dart';
import '../data/model/common/course.dart';
import '../data/model/common/latest_course_list/latest_course_list.dart';
import '../data/model/home_data_model/home_data_model.dart';
import '../repository/home_repository.dart';

class HomeController extends GetxController implements GetxService {
  HomeController({required this.homeRepository});
  final ApiServices apiServices = ApiServices();
  final SpController spController = SpController();

  final HomeRepository homeRepository;
  HomeDataModel? _homeModel;
  HomeDataModel? get homeModel => _homeModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? _currentIndex = 0;
  int? get currentIndex => _currentIndex;
  final List<Course> _latestCourseList = [];
  List<Course>? get latestCourseList => _latestCourseList;
  int _pageNumber = 1;
  int get pageNumber => _pageNumber;
  bool _isLoadingMoreData = false;
  bool get isLoadingMoreData => _isLoadingMoreData;

  @override
  void onInit() {
    getHomeData();
    getLatestCourseList();
    super.onInit();
  }

  Future<void> getHomeData() async {
    _isLoading = true;
    _homeModel == null;
    update();
    final response = await homeRepository.getHomeData();
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        HomeDataModel data = HomeDataModel.fromJson(response.body);
        _homeModel = data;
      } else {
        customSnackBar(response.body['message']);
      }
    } else {
      customSnackBar(response?.body?['message']);
    }
    _isLoading = false;
    update();
  }

  Future<void> getLatestCourseList() async {
    final response = await homeRepository.getLatestCourse(_pageNumber);
    if (response != null && response.statusCode == 200) {
      LatestCourseList list = LatestCourseList.fromJson(response.body);
      _latestCourseList.addAll(list.data!.courses!);
      if (list.data!.courses!.isNotEmpty) {
        _pageNumber++;
      }
      update();
    }
  }

  Future<void> paginate() async {
    _isLoadingMoreData = true;
    update();
    await getLatestCourseList();
    _isLoadingMoreData = false;
    update();
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }

  //* All cousrses list api implement
  final Rx<AllCoursesListModel?> allCoursesListData =
      Rx<AllCoursesListModel?>(null);
  final RxList<Courses> allCoursesList = RxList<Courses>([]);

  final RxBool isAllCoursesListLoading = RxBool(false);
  Future<void> getAllCoursesList() async {
    try {
      isAllCoursesListLoading.value = true;
      String? token = await spController.getBearerToken();
      debugPrint("Course Token: ${token}");
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "all-courses",
      ) as CommonDM;

      if (response.success != null) {
        allCoursesList.clear();
        allCoursesListData.value = AllCoursesListModel.fromJson(response.data);
        allCoursesList.addAll(allCoursesListData.value!.courses!);
        isAllCoursesListLoading.value = false;
      } else {
        isAllCoursesListLoading.value = true;
      }
    } catch (e) {
      isAllCoursesListLoading.value = false;
    }
  }

  //* All Blog list api implement
  final Rx<BlogDetailsModel?> blogDetailsData = Rx<BlogDetailsModel?>(null);
  final RxList<Blog> allBlogList = RxList<Blog>([]);
  final RxList<Blog> featuredBlogList = RxList<Blog>([]);

  final RxBool isBlogDetailsLoading = RxBool(false);
  Future<void> getBlogDetailsData({required String slug}) async {
    try {
      isBlogDetailsLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "blog/$slug",
      ) as CommonDM;

      if (response.success != null) {
        allBlogList.clear();
        featuredBlogList.clear();
        blogDetailsData.value = BlogDetailsModel.fromJson(response.data);
        allBlogList.addAll(blogDetailsData.value!.allBlogs!);
        featuredBlogList.addAll(blogDetailsData.value!.featuredBlogs!);
        isBlogDetailsLoading.value = false;
      } else {
        isBlogDetailsLoading.value = true;
      }
    } catch (e) {
      isBlogDetailsLoading.value = false;
    }
  }
  //*Home screen smart refresher controller
  //  final RefreshController refreshController = RefreshController();
}
