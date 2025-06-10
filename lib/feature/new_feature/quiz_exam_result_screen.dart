import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/loading_indicator.dart';
import 'package:anycallmobile_trainingcenter/controller/new/new_quiz_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:anycallmobile_trainingcenter/utils/colors.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/images.dart';
import 'package:anycallmobile_trainingcenter/utils/string.dart';
import 'package:anycallmobile_trainingcenter/widgets/custom_appbar.dart';

class QuizExamResultScreen extends StatelessWidget {
  QuizExamResultScreen({super.key});
  final NewQuizController newQuizController = Get.find<NewQuizController>();
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
              title: newQuizController.quizAnswerData.value?.quiz?.title ?? "",
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () async {
                Get.offNamedUntil(RouteHelper.quizCourseScreen,
                    ModalRoute.withName(RouteHelper.profile));
                //    Get.offNamedUntil(RouteHelper.getLearningScreen(
                //  newQuizController.quizAnswerData.value!.course!.id.toString(),
                //   newQuizController.quizAnswerData.value!.course!.title!
                // ),ModalRoute.withName((RouteHelper.getMainRoute("0"))));
                // Get.back();

                //                      Get.offNamedUntil(
                //   RouteHelper.getLearningScreen(
                //     newQuizController.quizAnswerData.value!.course!.id.toString(),
                //     newQuizController.quizAnswerData.value!.course!.title!
                //   ),
                //   ModalRoute.withName(RouteHelper.getMainRoute("0"))
                // );
                // await  Get.find<ClassroomController>().getCourseSectionData(courseID: int.parse(newQuizController.quizAnswerData.value!.course!.id!.toString()));
              },
            ),
          ),
          body: Obx(
            () => newQuizController.isQuizAnswerLoading.value
                ? const LoadingIndicator()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width - 30),
                            decoration: BoxDecoration(
                              color: cWhiteColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1, color: cLineColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${newQuizController.quizAnswerData.value?.quiz!.result!.isPassed == 1 ? "Congratulations" : "Sorry"}! You Have ${newQuizController.quizAnswerData.value!.quiz!.result!.isPassed == 1 ? "Pass" : "Fail"} this quiz exam"
                                          .tr,
                                      style: TextStyle(
                                        fontSize: Dimensions.fontSizeDefault,
                                        fontWeight: FontWeight.w600,
                                        color: newQuizController
                                                    .quizAnswerData
                                                    .value!
                                                    .quiz!
                                                    .result!
                                                    .isPassed ==
                                                1
                                            ? cGreenColor
                                            : cRedColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      QuizTopContainer(
                                        containerWidth: ((MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                84) /
                                            3),
                                        titleText:
                                            "${newQuizController.quizAnswerData.value!.quiz!.duration}"
                                                .tr,
                                        subtitleText: "Your Time".tr,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      QuizTopContainer(
                                        containerWidth: ((MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                84) /
                                            3),
                                        titleText: newQuizController
                                            .quizAnswerData
                                            .value!
                                            .quiz!
                                            .result!
                                            .yourMarks!
                                            .toStringAsFixed(0),
                                        subtitleText: "Your Score".tr,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      QuizTopContainer(
                                        containerWidth: ((MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                84) /
                                            3),
                                        titleText: newQuizController
                                                    .quizAnswerData
                                                    .value!
                                                    .quiz!
                                                    .result!
                                                    .isPassed ==
                                                1
                                            ? "Pass".tr
                                            : "Fail".tr,
                                        titleTextColor: newQuizController
                                                    .quizAnswerData
                                                    .value!
                                                    .quiz!
                                                    .result!
                                                    .isPassed ==
                                                1
                                            ? cGreenColor
                                            : cRedColor,
                                        subtitleText: "Your Result".tr,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            newQuizController
                                    .quizAnswerData.value!.quiz?.title ??
                                "",
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeDefault,
                                fontWeight: FontWeight.w600,
                                color: cBlackColor),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 16,
                                  ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  newQuizController.questionAnswerList.length,
                              itemBuilder: (context, index) {
                                if (newQuizController
                                        .questionAnswerList[index].questionType
                                        .toString()
                                        .toLowerCase() ==
                                    "default") {
                                  return QuizResultContainer(
                                    questionText: newQuizController
                                            .questionAnswerList[index]
                                            .questions ??
                                        ksNA.tr,
                                    description: newQuizController
                                            .questionAnswerList[index]
                                            .description ??
                                        "",
                                    isCorrect: newQuizController
                                            .questionAnswerList[index]
                                            .ansRight ??
                                        0,
                                    optionList: newQuizController
                                            .questionAnswerList[index]
                                            .options ??
                                        [],
                                    questionType: newQuizController
                                        .questionAnswerList[index].questionType
                                        .toString()
                                        .toLowerCase(),
                                    studentAnswer: (newQuizController
                                                .questionAnswerList[index]
                                                .studentAns is String &&
                                            newQuizController
                                                .questionAnswerList[index]
                                                .studentAns!
                                                .trim()
                                                .startsWith('[') &&
                                            newQuizController
                                                .questionAnswerList[index]
                                                .studentAns!
                                                .trim()
                                                .endsWith(']'))
                                        ? (jsonDecode(newQuizController
                                                .questionAnswerList[index]
                                                .studentAns!) as List)
                                            .map((e) => e.toString())
                                            .join(' ')
                                        : newQuizController
                                            .questionAnswerList[index]
                                            .studentAns
                                            .toString(),
                                    questionNumber: "${index + 1}",
                                    containerColor: newQuizController
                                                .questionAnswerList[index]
                                                .ansRight ==
                                            1
                                        ? cGreenColor
                                        : cRedColor.withOpacity(0.2),
                                    questionNumberTextColor: newQuizController
                                                .questionAnswerList[index]
                                                .ansRight ==
                                            1
                                        ? cWhiteColor
                                        : cRedColor,
                                    actionColor: cGreenColor,
                                  );
                                }
                                if (newQuizController
                                        .questionAnswerList[index].questionType
                                        .toString()
                                        .toLowerCase() ==
                                    "mcq") {
                                  return McqQuestionResult(
                                    questionText: newQuizController
                                            .questionAnswerList[index]
                                            .questions ??
                                        ksNA.tr,
                                    questionNumber: "${index + 1}",
                                    containerColor: newQuizController
                                                .questionAnswerList[index]
                                                .ansRight ==
                                            1
                                        ? cGreenColor
                                        : cRedColor.withOpacity(0.2),
                                    questionNumberTextColor: newQuizController
                                                .questionAnswerList[index]
                                                .ansRight ==
                                            1
                                        ? cWhiteColor
                                        : cRedColor,
                                    actionColor: cGreenColor,
                                    optionList: newQuizController
                                            .questionAnswerList[index]
                                            .options ??
                                        [],
                                    description: newQuizController
                                            .questionAnswerList[index]
                                            .description ??
                                        "",
                                    isCorrect: newQuizController
                                            .questionAnswerList[index]
                                            .ansRight ??
                                        0,
                                    studentAnswer: newQuizController
                                        .questionAnswerList[index].studentAns,
                                  );
                                }
                                return const SizedBox();
                              }),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class McqQuestionResult extends StatelessWidget {
  const McqQuestionResult({
    super.key,
    required this.questionText,
    required this.questionNumber,
    required this.containerColor,
    required this.questionNumberTextColor,
    required this.actionColor,
    required this.optionList,
    this.description,
    required this.isCorrect,
    this.studentAnswer,
  });

  final String questionText, questionNumber;
  final Color containerColor, questionNumberTextColor, actionColor;
  final List optionList;
  final String? description;
  final int isCorrect;
  final dynamic studentAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 16, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: containerColor,
                  ),
                  child: Center(
                    child: Text(
                      questionNumber,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: questionNumberTextColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    questionText,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: cBlackColor,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 1, color: cLineColor),
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: optionList.length,
              itemBuilder: (context, index) {
                bool isCorrectAnswer = optionList[index].isCorrect == 1;
                bool isStudentAnswer = false;

                List<int>? formattedStudentAnswer;
                if (studentAnswer is String) {
                  formattedStudentAnswer = _parseStringToList(studentAnswer);
                } else if (studentAnswer is List) {
                  if (studentAnswer.every((element) => element is int)) {
                    formattedStudentAnswer = studentAnswer.cast<int>();
                  } else {
                    formattedStudentAnswer = (studentAnswer as List<dynamic>)
                        .map((e) => int.parse(e.toString()))
                        .toList();
                  }
                }

                if (formattedStudentAnswer != null &&
                    formattedStudentAnswer.isNotEmpty) {
                  isStudentAnswer = formattedStudentAnswer.contains(index + 1);
                }
                return Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey),
                        color:
                            isStudentAnswer ? Colors.transparent : Colors.white,
                      ),
                      child: Center(
                        child: isCorrectAnswer
                            ? SvgPicture.asset(
                                Images.rightSvg,
                                width: 8,
                                height: 8,
                              )
                            : isStudentAnswer
                                ? SvgPicture.asset(
                                    Images.wrongSvg,
                                    width: 8,
                                    height: 8,
                                  )
                                : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        optionList[index].answer,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            if (isCorrect != 1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explanation".tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: cBlackColor,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: cLineColor),
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$description",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: cBlackColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
          ],
        ),
      ),
    );
  }

  List<int> _parseStringToList(String studentAnswer) {
    List<int> result = [];
    for (var char in studentAnswer.split(',')) {
      result.add(int.parse(char.trim()));
    }
    return result;
  }
}

class QuizResultContainer extends StatelessWidget {
  const QuizResultContainer({
    super.key,
    required this.questionText,
    required this.questionNumber,
    required this.containerColor,
    required this.questionNumberTextColor,
    required this.actionColor,
    required this.optionList,
    this.description,
    required this.isCorrect,
    this.studentAnswer,
    required this.questionType,
  });

  final String questionText, questionNumber;
  final Color containerColor, questionNumberTextColor, actionColor;
  final List optionList;
  final String? description;
  final int isCorrect;
  final dynamic studentAnswer;
  final String questionType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 16, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: containerColor,
                  ),
                  child: Center(
                    child: Text(
                      questionNumber,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: questionNumberTextColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    questionText,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: cBlackColor,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 1, color: cLineColor),
            if (optionList.isNotEmpty)
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: optionList.length,
                itemBuilder: (context, index) {
                  bool isCorrectAnswer = optionList[index].isCorrect == 1;
                  bool isStudentAnswer = false;

                  if (studentAnswer is List) {
                    isStudentAnswer = (studentAnswer.contains(index + 1));
                  } else if (studentAnswer is String) {
                    isStudentAnswer = (studentAnswer == (index + 1).toString());
                  }
                  return Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          color: isStudentAnswer
                              ? Colors.transparent
                              : Colors.white,
                        ),
                        child: Center(
                          child: isCorrectAnswer
                              ? SvgPicture.asset(
                                  Images.rightSvg,
                                  width: 8,
                                  height: 8,
                                )
                              : isStudentAnswer
                                  ? SvgPicture.asset(
                                      Images.wrongSvg,
                                      width: 8,
                                      height: 8,
                                    )
                                  : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          optionList[index].answer,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            const SizedBox(height: 10),
            if (isCorrect != 1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explanation".tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: cBlackColor,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: cLineColor),
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$description",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: cBlackColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class QuizTopContainer extends StatelessWidget {
  const QuizTopContainer(
      {super.key,
      required this.titleText,
      required this.subtitleText,
      this.containerWidth,
      this.containerColor,
      this.borderColor,
      this.titleTextColor,
      this.subtitleTextColor});
  final String titleText, subtitleText;
  final double? containerWidth;
  final Color? containerColor, borderColor, titleTextColor, subtitleTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth ?? (MediaQuery.of(context).size.width - 40) / 2,
      decoration: BoxDecoration(
        color: borderColor ?? cGreenColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            width: 1, color: containerColor ?? cGreenColor.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleText,
              style: TextStyle(
                  fontSize: Dimensions.fontSizeBig,
                  fontWeight: FontWeight.w600,
                  color: titleTextColor ?? cGreenColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              subtitleText,
              style: TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                  fontWeight: FontWeight.w400,
                  color: subtitleTextColor ?? cBlackColor),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonElevatedButton extends StatelessWidget {
  const CommonElevatedButton(
      {super.key,
      required this.buttonText,
      this.buttonOnPressed,
      this.buttonWidth,
      this.buttonHeight});
  final String buttonText;
  final VoidCallback? buttonOnPressed;
  final double? buttonWidth, buttonHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight ?? 42,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: cGreenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), // make it not circular
          ),
        ),
        onPressed: buttonOnPressed,
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: Dimensions.fontSizeDefault,
              fontWeight: FontWeight.w600,
              color: cWhiteColor),
        ),
      ),
    );
  }
}
