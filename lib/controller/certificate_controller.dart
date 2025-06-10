import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/config.dart';
import 'package:anycallmobile_trainingcenter/controller/new/sp_controller.dart';
import 'package:anycallmobile_trainingcenter/data/model/common/course.dart';
import 'package:anycallmobile_trainingcenter/data/model/common_model/common_data_model.dart';
import 'package:anycallmobile_trainingcenter/data/model/new/certificate_show_model.dart';
import 'package:anycallmobile_trainingcenter/data/provider/checker_api.dart';
import 'package:anycallmobile_trainingcenter/repository/certificate_repository.dart';
import 'package:anycallmobile_trainingcenter/services/api_services.dart';
import 'package:anycallmobile_trainingcenter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/string.dart';

class CertificateController extends GetxController implements GetxService {
  final ApiServices apiServices = ApiServices();
  final SpController spController = SpController();
  bool isCartDataLoading = false;
  List<Course>? _courseList;
  List<Course>? get courseList => _courseList;
  String? _certificateDownloadUrl;
  String? get certificateDownloadUrl => _certificateDownloadUrl;

  final RxBool isCourseBasedCertificateLoading = RxBool(false);
  Future<void> getCourseBasedOnCertificate(int offset, bool reload) async {
    isCourseBasedCertificateLoading.value = true;
    if (reload) {
      _courseList = null;
    }
    final response =
        await CertificateRepository(Get.find()).getCertificateBasedCourseList();
    if (response != null && response.statusCode == 200) {
      if (_courseList != null && offset != 1) {
        response.body['data']['courses'].forEach((category) {
          _courseList!.add(Course.fromJson(category));
        });
        isCourseBasedCertificateLoading.value = false;
      } else {
        _courseList = [];
        response.body['data']['courses'].forEach((category) {
          _courseList!.add(Course.fromJson(category));
          isCourseBasedCertificateLoading.value = false;
        });
      }
    } else {
      ApiChecker.checkApi(response!);
      isCourseBasedCertificateLoading.value = false;
    }
    update();
  }

  getCertificateDownloadLink(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstants.token);
    _certificateDownloadUrl =
        "${Config.baseUrl}${AppConstants.certificateDownload}/$id?token=$token";
    update();
  }

  //!meeting api call
  final Rx<CertificateShowModel?> certificateShowData =
      Rx<CertificateShowModel?>(null);
  final Rx<Certificate?> certificateShow = Rx<Certificate?>(null);

  final RxBool isCertificateShowLoading = RxBool(false);
  Future<void> getCertificateDataShow({required String courseId}) async {
    try {
      isCertificateShowLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "user/certificates/${courseId.toString()}",
      ) as CommonDM;

      if (response.success != null) {
        // courseList.clear();
        certificateShowData.value =
            CertificateShowModel.fromJson(response.data);
        certificateShow.value = certificateShowData.value!.certificate;
        // courseList.addAll(meetingListData.value!.courses!);
        // Get.toNamed(RouteHelper.meetingScreen);
        isCertificateShowLoading.value = false;
      } else {
        isCertificateShowLoading.value = true;
      }
    } catch (e) {
      // Get.offAllNamed(RouteHelper.getSignInRoute(""));
      isCertificateShowLoading.value = false;
      // Get.find<AuthController>().clearSharedData();
    }
  }
}
