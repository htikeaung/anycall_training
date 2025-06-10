import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/custom_app_bar.dart';
import 'package:anycallmobile_trainingcenter/components/custom_button.dart';
import 'package:anycallmobile_trainingcenter/components/loading_indicator.dart';
import 'package:anycallmobile_trainingcenter/controller/classroom_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/new/new_quiz_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:anycallmobile_trainingcenter/data/model/common/lesson.dart';
import 'package:anycallmobile_trainingcenter/data/model/common/quiz.dart';
import 'package:anycallmobile_trainingcenter/feature/classRoom/widget/video_player.dart';
import 'package:anycallmobile_trainingcenter/feature/quiz/quiz_detail_page.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/images.dart';
import 'package:anycallmobile_trainingcenter/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/model/common/section.dart';

class LearningScreen extends StatefulWidget {
  final String courseTitle;
  final String courseID;

  const LearningScreen(
      {Key? key, required this.courseTitle, required this.courseID})
      : super(key: key);

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.courseTitle,
      ),
      body: GetBuilder<ClassroomController>(
          initState: (state) => Get.find<ClassroomController>()
              .getCourseSectionData(courseID: int.parse(widget.courseID)),
          builder: (controller) {
            return controller.isLoading
                ? const LoadingIndicator()
                : mainUI(context, controller.sectionList, controller);
          }),
    );
  }

  Column mainUI(BuildContext context, List<Section> sectionList,
      ClassroomController controller) {
    return Column(
      children: [
        controller.selectedVideoUrl != null && controller.playNewVideo == true
            ? Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                color: Colors.orange.withOpacity(0.2),
                child: CourseVideoPlayer(
                  videoUrl: controller.selectedVideoUrl!,
                ))
            : Container(color: Colors.black, height: 200),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Text(
                        widget.courseTitle,
                        style: robotoSemiBold.copyWith(
                            fontSize: Dimensions.fontSizeDefault),
                      ),
                    ),
                    CustomButton(
                        width: (MediaQuery.of(context).size.width) / 5,
                        height: 25,
                        onPressed: () {
                          Get.toNamed(
                              RouteHelper.getResourceScreen(widget.courseID));
                        },
                        buttonText: 'resource'.tr),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                Expanded(
                  //height: 400,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sectionList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Dimensions.paddingSizeSmall),
                              child: curriculumItem(
                                  context,
                                  controller,
                                  sectionList[index],
                                  int.parse(widget.courseID)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
      ],
    );
  }

  Widget curriculumItem(BuildContext context, ClassroomController controller,
      Section section, int courseID) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          width: 1,
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ),
        title: Text(
          section.title ?? '',
          style: robotoMedium.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: Dimensions.fontSizeDefault),
        ),
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: section.lessons != null || section.quizes != null
                ? Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: section.lessons?.length == null
                            ? 0
                            : (section.lessons!.length +
                                section.quizes!.length),
                        itemBuilder: (context, index) {
                          return index >= section.lessons!.length
                              // ? quizButton(
                              //     section.quizes![index - section.lessons!.length])
                              ? const SizedBox()
                              : _item(context, section.lessons![index],
                                  controller, courseID, section.id.toString());
                        },
                      ),
                      quizButton(),
                    ],
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget quizButton() => CustomButton(
      onPressed: () async {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => QuizDetailScreen(quiz: quiz),
        //   ));
        // await Get.find<NewQuizController>().getQuizList(slug: Get.find<ClassroomController>().sectionList);
        String slug = "";
        for (int i = 0;
            i <
                Get.find<ClassroomController>()
                    .classroomData!
                    .data!
                    .sections!
                    .length;
            i++) {
          log("The slug is ${Get.find<ClassroomController>().classroomData!.data!.sections![i].slug.toString()}");
          slug = Get.find<ClassroomController>()
              .classroomData!
              .data!
              .sections![i]
              .slug
              .toString();
        }
        Get.toNamed(RouteHelper.myQuizListScreen);
        await Get.find<NewQuizController>().getQuizList(slug: slug);
      },
      height: 25,
      buttonText: "quiz".tr); //!Previous -> "Quiz"

  Widget _item(BuildContext context, Lesson lesson,
      ClassroomController controller, int courseId, String sectionId) {
    return InkWell(
      onTap: () async {
        if (lesson.type == 'video') {
          controller.updateVideoUrl(
              url: lesson.link,
              courseID: courseId,
              lessonId: lesson.id.toString(),
              sectionId: sectionId);
        } else if (lesson.type == 'audio') {
          controller.openAudioPlayerDialog(lesson, courseId, sectionId);
        } else if (lesson.type == 'doc') {
          await launchUrl(Uri.parse(lesson.link),
              mode: LaunchMode.externalApplication);
        }
      },
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (lesson.type == 'video')
              SvgPicture.asset(Images.polygon,
                  color: Theme.of(context).primaryColor),
            if (lesson.type == 'audio')
              SvgPicture.asset(Images.microPhone,
                  color: Theme.of(context).primaryColor),
            if (lesson.type == 'doc')
              SvgPicture.asset(Images.document,
                  color: Theme.of(context).primaryColor),
            const SizedBox(width: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              child: Text(lesson.title,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                  style: robotoRegular.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.6),
                      fontSize: Dimensions.fontSizeSmall)),
            ),
            // Text("Free",
            //     style: robotoMedium.copyWith(
            //         color: Theme.of(context).primaryColor,
            //         fontSize: Dimensions.fontSizeExtraSmall)),
          ],
        ),
      ),
    );
  }
}
