// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:anycallmobile_trainingcenter/components/custom_app_bar.dart';
// import 'package:anycallmobile_trainingcenter/components/loading_indicator.dart';
// import 'package:anycallmobile_trainingcenter/controller/meeting_controller.dart';
// import 'package:anycallmobile_trainingcenter/core/helper/help_me.dart';
// import 'package:anycallmobile_trainingcenter/utils/colors.dart';
// import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
// import 'package:anycallmobile_trainingcenter/utils/styles.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MeetingScreen extends StatelessWidget {
//   const MeetingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'meeting_list'.tr,
//         bgColor: Theme.of(context).cardColor,
//         titleColor: Theme.of(context).textTheme.bodyLarge!.color,
//       ),
//       body: GetBuilder<MeetingController>(
//         initState: (state) => Get.find<MeetingController>().getMeetingList(),
//         builder: (controller) {
//           return controller.isMeetingListLoading ? const LoadingIndicator()
//               : controller.meetingList.isEmpty  ?
//           Center(
//                 child: Text('you_dont_have_any_meeting_yet'.tr),
//               ): mainUI(controller);
//         },
//       ),
//     );
//   }

//   Widget mainUI(MeetingController meetingController){

//     return ListView.builder(
//         itemCount: meetingController.meetingList.length,
//         itemBuilder: (context, index) {
//           DateTime dateTime = DateTime.parse(meetingController.meetingList.elementAt(index).startAt ?? DateTime.now().toString());

//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//             child: Container(
//               height: 70,
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
//                 border: Border.all(color: Theme.of(context).primaryColorLight),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
//                       child: CircleAvatar(
//                         backgroundColor: randomColorPicker(),
//                         radius: 20,
//                         child: Text(meetingController.meetingList.elementAt(index).title!.substring(0,1)),
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 meetingController.meetingList.elementAt(index).title!,
//                                 style: robotoMedium.copyWith(
//                                     color: Theme.of(context).textTheme.bodyLarge!.color,
//                                     fontSize: Dimensions.fontSizeDefault),
//                               ),
//                               Text(
//                                 DateFormat.yMMMMd().format(dateTime),
//                                 style: robotoRegular.copyWith(
//                                     color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
//                                     fontSize: Dimensions.fontSizeExtraSmall),
//                               ),
//                             ],
//                           ),
//                           InkWell(
//                             onTap: (){
//                               _launchUrl(Uri.parse(meetingController.meetingList.elementAt(index).meetingLink!));
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context).primaryColor,
//                                 borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: Dimensions.paddingSizeSmall,
//                                     vertical: Dimensions.paddingSizeMint),
//                                 child: Text(
//                                   "join".tr,
//                                   style: robotoRegular.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeSmall),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   Future<void> _launchUrl(Uri url) async {
//     if (!await launchUrl(url)) {
//       throw 'Could not launch $url';
//     }
//   }

// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/controller/new/new_meeting_controller.dart';
import 'package:anycallmobile_trainingcenter/utils/colors.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/string.dart';
import 'package:anycallmobile_trainingcenter/utils/utility_function.dart';
// import 'package:anycallmobile_trainingcenter/utils/utility_function.dart';
// import 'package:anycallmobile_trainingcenter/utils/string.dart';
import 'package:anycallmobile_trainingcenter/widgets/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});
  final NewMeetingController newMeetingController =
      Get.find<NewMeetingController>();

  @override
  Widget build(BuildContext context) {
    // ll("The original image url is ${newMeetingController.courseList[0].image?.originalImage}");
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.00),
        //* info:: appBar
        child: CustomAppBar(
          appBarColor: cWhiteColor,
          title: "Meeting List".tr,
          hasBackButton: true,
          isCenterTitle: true,
          onBack: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Live Class".tr,
                    style: TextStyle(
                        fontSize: Dimensions.fontSizeLarge,
                        fontWeight: FontWeight.w600,
                        color: cBlackColor),
                  ),
                  Text(
                    "showing ${newMeetingController.meetingListData.value?.totalCourses} of ${newMeetingController.meetingListData.value?.totalResults} result"
                        .tr,
                    style: TextStyle(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        fontWeight: FontWeight.w400,
                        color: cSmallBodyTextColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
                color: cLineColor,
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: newMeetingController.courseList.length,
                separatorBuilder: (context, index) => const Column(
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
                  return MeetingContainerWidget(
                    courseImage:
                        newMeetingController.courseList[index].thumbnail ?? "",
                    courseTitle:
                        newMeetingController.courseList[index].title ?? ksNA.tr,
                    meetingDate:
                        newMeetingController.courseList[index].startDate ?? "",
                    meetingTime:
                        newMeetingController.courseList[index].startTime ?? "",
                    meetingUrl:
                        newMeetingController.courseList[index].joinLink ?? "",
                    meetingType:
                        newMeetingController.courseList[index].meetingMethod ??
                            "",
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeetingContainerWidget extends StatelessWidget {
  const MeetingContainerWidget(
      {super.key,
      required this.courseImage,
      required this.courseTitle,
      required this.meetingDate,
      required this.meetingTime,
      required this.meetingUrl,
      required this.meetingType});
  final String courseImage,
      courseTitle,
      meetingDate,
      meetingTime,
      meetingUrl,
      meetingType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            child: Image.network(
              courseImage,
              width: (MediaQuery.of(context).size.width - 30),
              loadingBuilder: imageLoadingBuilder,
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              courseTitle.tr,
              style: TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                  fontWeight: FontWeight.w600,
                  color: cBlackColor),
              overflow: TextOverflow.clip,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Starting Date: $meetingDate",
                      style: TextStyle(
                          fontSize: Dimensions.fontSizeSmall,
                          fontWeight: FontWeight.w400,
                          color: cSmallBodyTextColor),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Time: $meetingTime",
                      style: TextStyle(
                          fontSize: Dimensions.fontSizeSmall,
                          fontWeight: FontWeight.w400,
                          color: cSmallBodyTextColor),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    String url = meetingUrl;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: cGreenColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          meetingType.toString().toLowerCase() == "zoom"
                              ? "Join Zoom"
                              : "Join Meet",
                          style: TextStyle(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                            color: cWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
