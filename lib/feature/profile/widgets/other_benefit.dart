import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/confirmation_dialog.dart';
import 'package:anycallmobile_trainingcenter/controller/certificate_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/new/new_meeting_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/new/new_quiz_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/user_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:anycallmobile_trainingcenter/feature/profile/widgets/user_logout.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/images.dart';
import 'package:anycallmobile_trainingcenter/utils/styles.dart';

class OtherBenefit extends StatelessWidget {
  OtherBenefit({super.key});

  final List list = [
    {"icon": Images.certificates, "title": 'certificates'.tr},
    // {"icon": Images.books, "title": 'books'.tr},
    {"icon": Images.profileNotification, "title": 'notification'.tr},
    // {"icon": Images.orderHistory, "title": 'orderHistory'.tr},
    // {"icon": Images.voucher, "title": 'voucher'.tr},
    // {"icon": Images.quiz, "title": 'Quiz'.tr},
    // {"icon": Images.meeting, "title": 'meeting'.tr},
    // {"icon": Images.myAssignment, "title": 'my_assignment'.tr},
    {"icon": Images.profileLogout, "title": 'logout'.tr},
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Text(
              'otherBenefit'.tr,
              style:
                  robotoSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: list.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          if (index == 0) {
                            Get.toNamed(RouteHelper.certificateScreen);
                            await Get.find<CertificateController>()
                                .getCourseBasedOnCertificate(1, true);
                          } else if (index == 1) {
                            Get.toNamed(RouteHelper.notificationScreen);
                          } else if (index == 2) {
                            Get.toNamed(RouteHelper.orderHistoryScreen);
                          } else if (index == 3) {
                            Get.toNamed(RouteHelper.couponScreen);
                          } else if (index == 4) {
                            await Get.find<NewQuizController>()
                                .getQuizCourseList();
                            Get.toNamed(RouteHelper.quizCourseScreen);
                          } else if (index == 5) {
                            await Get.find<NewMeetingController>()
                                .getMeetingList();
                            Get.toNamed(RouteHelper.meetingScreen);
                          } else if (index == 6) {
                            Get.toNamed(RouteHelper.myAssignmentScreen);
                          } else if (index == 7) {
                            Get.bottomSheet(const UserLogout(),
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeRadius),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeDefault),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  list[index]['icon'],
                                  height: 14,
                                  width: 12,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  list[index]['title'],
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      (index + 1) == (list.length)
                          ? const SizedBox()
                          : Divider(
                              thickness: 1,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                            ),
                      (index + 1) == (list.length)
                          // delete user button
                          ? Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Get.dialog(
                                      ConfirmationDialog(
                                          icon: Images.logout,
                                          description:
                                              'are_you_sure_to_delete'.tr,
                                          isLogOut: true,
                                          onYesPressed: () {
                                            Get.find<UserController>()
                                                .removeUser();
                                          }),
                                      useSafeArea: false);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeSmall,
                                    vertical: Dimensions.paddingSizeExtraSmall,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(Images.deleteAccount),
                                      const SizedBox(
                                        width: Dimensions.paddingSizeExtraSmall,
                                      ),
                                      Text('deleteYourAccount'.tr,
                                          style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error)),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
