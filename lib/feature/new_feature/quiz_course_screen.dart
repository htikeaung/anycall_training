import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/controller/new/new_quiz_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:anycallmobile_trainingcenter/utils/colors.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/string.dart';
import 'package:anycallmobile_trainingcenter/widgets/custom_appbar.dart';

class QuizCourseScreen extends StatelessWidget {
  QuizCourseScreen({super.key});
  final NewQuizController newQuizController = Get.find<NewQuizController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cWhiteColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.00),
          //* info:: appBar
          child: CustomAppBar(
            appBarColor: cWhiteColor,
            title: "My Course".tr,
            hasBackButton: true,
            isCenterTitle: true,
            onBack: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newQuizController.quizCourseList.length,
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
                    return QuizCourseContainerWidget(
                      courseImage:
                          newQuizController.quizCourseList[index].thumbnail ??
                              "",
                      courseTitle:
                          newQuizController.quizCourseList[index].title ??
                              ksNA.tr,
                      buttonText: "Quiz List".tr,
                      onPressed: () async {
                        Get.toNamed(RouteHelper.myQuizListScreen);
                        await newQuizController.getQuizList(
                            slug: newQuizController.quizCourseList[index].slug
                                .toString());
                      },
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
      ),
    );
  }
}

class QuizCourseContainerWidget extends StatelessWidget {
  const QuizCourseContainerWidget({
    super.key,
    required this.courseImage,
    required this.courseTitle,
    required this.onPressed,
    required this.buttonText,
  });
  final String courseImage, courseTitle, buttonText;
  final VoidCallback onPressed;

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
            child: InkWell(
              onTap: onPressed,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: cGreenColor,
                ),
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w600,
                      color: cWhiteColor,
                    ),
                  ),
                ),
              ),
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
