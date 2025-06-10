import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/controller/new/sp_controller.dart';
import 'package:anycallmobile_trainingcenter/data/model/common_model/common_data_model.dart';
import 'package:anycallmobile_trainingcenter/data/model/new/meeting_list_model.dart';
import 'package:anycallmobile_trainingcenter/services/api_services.dart';
import 'package:anycallmobile_trainingcenter/utils/string.dart';

class NewMeetingController extends GetxController {
  final ApiServices apiServices = ApiServices();
  final SpController spController = SpController();

  //*meeting api call
  final Rx<MeetingListModel?> meetingListData = Rx<MeetingListModel?>(null);
  final RxList<Course> courseList = RxList<Course>([]);

  final RxBool isMeetingListLoading = RxBool(false);
  Future<void> getMeetingList() async {
    try {
      isMeetingListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "user/meetings",
      ) as CommonDM;

      if (response.success != null) {
        courseList.clear();
        meetingListData.value = MeetingListModel.fromJson(response.data);
        courseList.addAll(meetingListData.value!.courses!);
        // Get.toNamed(RouteHelper.meetingScreen);
        isMeetingListLoading.value = false;
      } else {
        isMeetingListLoading.value = true;
      }
    } catch (e) {
      // Get.offAllNamed(RouteHelper.getSignInRoute(""));
      isMeetingListLoading.value = false;
      // Get.find<AuthController>().clearSharedData();
    }
  }
}
