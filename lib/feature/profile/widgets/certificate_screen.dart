//!Previous

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:anycallmobile_trainingcenter/components/custom_app_bar.dart';
// import 'package:anycallmobile_trainingcenter/controller/certificate_controller.dart';
// import 'package:anycallmobile_trainingcenter/data/model/common/course.dart';
// import 'package:anycallmobile_trainingcenter/feature/profile/widgets/certificate_dialog.dart';
// import 'package:anycallmobile_trainingcenter/feature/root/view/no_data_screen.dart';
// import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
// import 'package:anycallmobile_trainingcenter/utils/images.dart';

// class CertificateScreen extends StatelessWidget {
//   const CertificateScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'certificates'.tr,
//         bgColor: Theme.of(context).cardColor,
//         titleColor: Theme.of(context).textTheme.bodyLarge!.color,
//       ),
//       body: GetBuilder<CertificateController>(
//         initState: (state) async {
//           await Get.find<CertificateController>()
//               .getCourseBasedOnCertificate(1, true);
//         },
//         builder: (certificateController) {
//           List<Course>? courseList = certificateController.courseList;
//           if (courseList == null) {
//             return const Center(child: CircularProgressIndicator());
//           }else{
//             return  courseList.isNotEmpty ? Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 200,
//                     childAspectRatio: 3 / 2,
//                     crossAxisSpacing: 15,
//                     mainAxisSpacing: 15
//                 ),
//                 itemCount: courseList.length,
//                 itemBuilder: (BuildContext ctx, index) {
//                   return InkWell(
//                     onTap: (){
//                       Get.dialog(CertificateDialog(course: courseList.elementAt(index),));
//                     },
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(Dimensions.radiusSmall),
//                           ),
//                           child: Image.asset(
//                             Images.demoCertificate,
//                             fit: BoxFit.cover,
//                           ),
//                         ),

//                       ],
//                     ),
//                   );
//                 },
//               ),
//             )
//           : NoDataScreen(text: 'no_certificate_found'.tr,type: NoDataType.certificate,);
//           }
//         },
//       ),
//     );
//   }
// }

//!Changes

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/loading_indicator.dart';
import 'package:anycallmobile_trainingcenter/controller/certificate_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:anycallmobile_trainingcenter/feature/new_feature/quiz_course_screen.dart';
import 'package:anycallmobile_trainingcenter/feature/root/view/no_data_screen.dart';
import 'package:anycallmobile_trainingcenter/utils/colors.dart';
import 'package:anycallmobile_trainingcenter/utils/string.dart';
import 'package:anycallmobile_trainingcenter/widgets/custom_appbar.dart';

class CertificateScreen extends StatelessWidget {
  CertificateScreen({super.key});
  final CertificateController certificateController =
      Get.find<CertificateController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.00),
              //* info:: appBar
              child: CustomAppBar(
                appBarColor: cWhiteColor,
                title: "Certificate".tr,
                hasBackButton: true,
                isCenterTitle: true,
                onBack: () {
                  Get.back();
                },
              )),
          body: Obx(
            () => certificateController.isCourseBasedCertificateLoading.value
                ? const LoadingIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        // certificateController.courseList?.length!=0 ?
                        if (certificateController.courseList?.isEmpty ?? true)
                          NoDataScreen(
                            text: 'no_certificate_found'.tr,
                            type: NoDataType.certificate,
                          ),
                        if (certificateController.courseList?.isNotEmpty ??
                            true)
                          Column(
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    certificateController.courseList?.length ??
                                        0,
                                separatorBuilder: (context, index) =>
                                    const Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: cLineColor,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                                itemBuilder: (context, index) {
                                  return QuizCourseContainerWidget(
                                    courseImage: certificateController
                                            .courseList?[index].thumbnail ??
                                        "",
                                    courseTitle: certificateController
                                            .courseList?[index].title ??
                                        ksNA.tr,
                                    buttonText: "Certificate".tr,
                                    onPressed: () async {
                                      await certificateController
                                          .getCertificateDataShow(
                                              courseId: certificateController
                                                  .courseList![index].id!
                                                  .toString());
                                      Get.toNamed(RouteHelper.photoView);
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
