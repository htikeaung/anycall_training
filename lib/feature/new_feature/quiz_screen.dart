import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/loading_indicator.dart';
import 'package:anycallmobile_trainingcenter/controller/new/new_quiz_controller.dart';
import 'package:anycallmobile_trainingcenter/data/model/new/quiz_question_model.dart';
import 'package:anycallmobile_trainingcenter/feature/new_feature/quiz_exam_result_screen.dart';
import 'package:anycallmobile_trainingcenter/feature/quiz/widget/labeled_checkbox.dart';
import 'package:anycallmobile_trainingcenter/utils/colors.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/string.dart';
import 'package:anycallmobile_trainingcenter/widgets/custom_appbar.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});
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
            child: Obx(() => newQuizController.isQuestionListLoading.value
                ? const SizedBox()
                : CustomAppBar(
                    appBarColor: cWhiteColor,
                    title:
                        newQuizController.quizQuestionData.value?.quiz?.title ??
                            ksNA.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                  )),
          ),
          body: Obx(
            () => newQuizController.isQuestionListLoading.value
                ? const LoadingIndicator()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 24,
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
                                      Obx(() {
                                        final formattedTime = newQuizController
                                            .getFormattedTime();

                                        return QuizTopContainer(
                                          containerWidth:
                                              ((MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      84) /
                                                  3),
                                          titleText: "$formattedTime Min",
                                          subtitleText: "Your Time".tr,
                                        );
                                      }),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      QuizTopContainer(
                                        containerWidth: ((MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                84) /
                                            3),
                                        titleText:
                                            "${newQuizController.quizQuestionData.value!.quiz!.totalMarks!}",
                                        subtitleText: "Total Score".tr,
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
                                        titleText:
                                            "${newQuizController.quizQuestionData.value!.quiz!.passMarks!}",
                                        subtitleText: "Pass Mark".tr,
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
                            height: 30,
                          ),
                          const Divider(
                            thickness: 1,
                            color: cLineColor,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 16,
                                  ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: newQuizController.questionList.length,
                              itemBuilder: (context, index) {
                                //!needed
                                if (newQuizController
                                        .questionList[index].questionType
                                        .toString()
                                        .toLowerCase() ==
                                    "mcq") {
                                  return Obx(() => QuizQuestionAndAnswerWidget(
                                        questionNumber: "${index + 1}",
                                        correctAnswerList: newQuizController
                                            .questionList[index].answers!,
                                        questionId: newQuizController
                                            .questionList[index].id!
                                            .toString(),
                                        questionType: newQuizController
                                            .questionList[index].questionType!,
                                        questionTitle: newQuizController
                                            .questionList[index].question!,
                                        // isFlagged: newQuizController
                                        //     .questionList[index].isFlagged!.value,
                                        optionList: newQuizController
                                            .questionList[index].answers,
                                      ));
                                }
                                if (newQuizController
                                        .questionList[index].questionType
                                        .toString()
                                        .toLowerCase() ==
                                    "default") {
                                  return Obx(
                                    () => SingleChoiceQuizWidget(
                                      questionNumber: "${index + 1}",
                                      correctAnswerList: newQuizController
                                          .questionList[index].answers!,
                                      questionId: newQuizController
                                          .questionList[index].id!
                                          .toString(),
                                      questionType: newQuizController
                                          .questionList[index].questionType!,
                                      questionTitle: newQuizController
                                              .questionList[index].question ??
                                          "",
                                      optionList: newQuizController
                                          .questionList[index].answers,
                                    ),
                                  );
                                }
                              }),
                          const SizedBox(
                            height: 24,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Divider(
                            thickness: 1,
                            color: cLineColor,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CommonElevatedButton(
                            buttonWidth:
                                (MediaQuery.of(context).size.width) / 2.7,
                            buttonHeight: 34,
                            buttonText: "Finish Exam".tr,
                            buttonOnPressed: () async {
                              await newQuizController.submitQuiz();
                            },
                          ),
                          const SizedBox(
                            height: 56,
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

// //!Currently working for mcq

class QuizQuestionAndAnswerWidget extends StatelessWidget {
  QuizQuestionAndAnswerWidget({
    super.key,
    required this.questionTitle,
    required this.optionList,
    required this.questionType,
    required this.questionId,
    required this.correctAnswerList,
    required this.questionNumber,
  });

  final String questionTitle, questionNumber;
  final List<Answer>? optionList;
  final String questionType, questionId;
  final List correctAnswerList;

  final NewQuizController newQuizController = Get.find<NewQuizController>();

  @override
  Widget build(BuildContext context) {
    newQuizController.questionIdList.clear();
    for (int i = 0; i < newQuizController.questionList.length; i++) {
      newQuizController.questionIdList
          .add(newQuizController.questionList[i].id);
      // log("The question list ids are ${newQuizController.questionIdList[i]}");
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: cGreenColor,
              ),
              child: Center(
                child: Text(
                  questionNumber,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: cWhiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                questionTitle,
                style: TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                  fontWeight: FontWeight.w400,
                  color: cBlackColor,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 0.5, color: cLineColor),
        Obx(() {
          List<int> selectedAnswers =
              newQuizController.mcqDefaultAnswerMap[questionId] as List<int>? ??
                  [];

          return Column(
            children: List.generate(optionList!.length, (index) {
              final optionIndex = index + 1;
              final isChecked = selectedAnswers.contains(optionIndex);

              return CustomCheckBox(
                uncheckedColor: cBlackColor,
                label: optionList![index].answer!,
                value: isChecked,
                onChanged: (value) {
                  if (value) {
                    newQuizController.updateStudentAnswerMcq(
                        questionId, optionIndex);
                    if (!selectedAnswers.contains(optionIndex)) {
                      selectedAnswers.add(optionIndex);
                    }
                  } else {
                    newQuizController.updateStudentAnswerMcq(
                        questionId, optionIndex);
                    selectedAnswers.remove(optionIndex);
                  }

                  int existingIndex = newQuizController.studentAllQuestionAnswer
                      .indexWhere((entry) =>
                          entry["questionId"] == questionId.toString());

                  // Prepare the correct answer list
                  List<String> correctAnswerIndexList = [];
                  for (int i = 0; i < optionList!.length; i++) {
                    if (optionList![i].isCorrect == 1) {
                      correctAnswerIndexList.add("${i + 1}");
                    }
                  }

                  // Convert selectedAnswers to List<String>
                  List<String> selectedAnswerStringList =
                      selectedAnswers.map((e) => "$e").toList();

                  Map<String, dynamic> updatedEntry = {
                    "quizId": newQuizController.quizId.value,
                    "questionId": questionId.toString(),
                    "question_type_$questionId": questionType,
                    // "student_answer_$questionId": selectedAnswerStringList,
                    // "correct_answer_$questionId": correctAnswerIndexList,
                    "student_answer_$questionId": selectedAnswerStringList,
                    "correct_answer_$questionId": correctAnswerIndexList,
                  };
                  // ll(correctAnswerIndexList.runtimeType);
                  // ll(selectedAnswerStringList);

                  if (existingIndex != -1) {
                    newQuizController.studentAllQuestionAnswer[existingIndex] =
                        updatedEntry;
                  } else {
                    newQuizController.studentAllQuestionAnswer
                        .add(updatedEntry);
                  }

                  newQuizController.update();
                  log(newQuizController.studentAllQuestionAnswer.toString());
                },
              );
            }),
          );
        }),
        const SizedBox(height: 14),
      ],
    );
  }
}

class SingleChoiceQuizWidget extends StatelessWidget {
  SingleChoiceQuizWidget({
    super.key,
    required this.questionTitle,
    required this.optionList,
    required this.questionType,
    required this.questionId,
    required this.correctAnswerList,
    required this.questionNumber,
  });

  final String questionTitle, questionNumber;
  final List<Answer>? optionList;
  final String questionType, questionId;
  final List correctAnswerList;

  final NewQuizController newQuizController = Get.find<NewQuizController>();

  @override
  Widget build(BuildContext context) {
    newQuizController.questionIdList.clear();
    for (int i = 0; i < newQuizController.questionList.length; i++) {
      newQuizController.questionIdList
          .add(newQuizController.questionList[i].id);
      // log("The question list ids are ${newQuizController.questionIdList[i]}");
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: cGreenColor,
              ),
              child: Center(
                child: Text(
                  questionNumber,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: cWhiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                questionTitle,
                style: TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                  fontWeight: FontWeight.w400,
                  color: cBlackColor,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 0.5, color: cLineColor),
        Obx(() {
          // Retrieve the selected answer for the question
          int? selectedAnswer =
              newQuizController.mcqDefaultAnswerMap[questionId] as int?;

          return Column(
            children: List.generate(optionList!.length, (index) {
              final optionIndex = index + 1;
              final isChecked = selectedAnswer == optionIndex;

              return RadioListTile<int>(
                contentPadding: EdgeInsets.zero,
                activeColor: cGreenColor,
                title: Text(optionList![index].answer!),
                value: optionIndex,
                groupValue: selectedAnswer,
                onChanged: (value) {
                  if (value != null) {
                    newQuizController.updateStudentAnswer(questionId, value);
                    String correctAnswerIndex = "";
                    for (int i = 0; i < optionList!.length; i++) {
                      if (correctAnswerList[i].isCorrect == 1) {
                        correctAnswerIndex = "${i + 1}";
                        break;
                      }
                    }

                    int questionIdInt = int.parse(questionId);

                    int indexToUpdate = -1;
                    for (int i = 0;
                        i < newQuizController.studentAllQuestionAnswer.length;
                        i++) {
                      if (int.parse(newQuizController
                              .studentAllQuestionAnswer[i]["questionId"]) ==
                          questionIdInt) {
                        indexToUpdate = i;
                        break;
                      }
                    }

                    if (indexToUpdate != -1) {
                      Map<String, dynamic> updatedEntry = {
                        "quizId": newQuizController.quizId.value,
                        "questionId": "$questionIdInt",
                        "question_type_$questionId": questionType,
                        "correct_answer_$questionId": correctAnswerIndex,
                        "student_answer_$questionId": "$value",
                      };
                      newQuizController
                              .studentAllQuestionAnswer[indexToUpdate] =
                          updatedEntry;
                    } else {
                      Map<String, dynamic> newEntry = {
                        "quizId": newQuizController.quizId.value,
                        "questionId": "$questionIdInt",
                        "question_type_$questionId": questionType,
                        "correct_answer_$questionId": correctAnswerIndex,
                        "student_answer_$questionId": "$value",
                      };
                      newQuizController.studentAllQuestionAnswer.add(newEntry);
                    }

                    // Log the updated list
                    // log(newQuizController.studentAllQuestionAnswer);
                  } else {
                    newQuizController.updateStudentAnswer(questionId, null);
                  }
                },
              );
            }),
          );
        }),
        const SizedBox(height: 14),
      ],
    );
  }
}
