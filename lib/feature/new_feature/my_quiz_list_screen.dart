import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/loading_indicator.dart';
import 'package:anycallmobile_trainingcenter/controller/new/new_quiz_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:anycallmobile_trainingcenter/utils/colors.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/string.dart';
import 'package:anycallmobile_trainingcenter/utils/styles.dart';
import 'package:anycallmobile_trainingcenter/widgets/custom_appbar.dart';

class MyQuizListScreen extends StatelessWidget {
  MyQuizListScreen({super.key});
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
              title: "My Quiz List".tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          //            body: GetBuilder<QuizController>(
          //   initState: (state) =>
          //       Get.find<QuizController>().getFinalExamQuizData(),
          //   builder: (controller) {
          //     return controller.isDataLoading == true &&
          //             controller.finalExamQuizModel == null
          //         ? const LoadingIndicator()
          //         : myQuizListMainUi(context, controller.finalExamQuizModel!);
          //   },
          // ),
          body: Obx(() => newQuizController.isQuizListLoading.value
              ? const LoadingIndicator()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      if (newQuizController.quizList.isNotEmpty)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 16,
                                        ),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        newQuizController.quizList.length,
                                    itemBuilder: (context, index) {
                                      // var item = NewQuizHelper().quizOrFinalQuizList(
                                      //   quizOrFinalQuizIndexValue: newQuizController.quizOrFinalQuizIndexValue.value,
                                      // );
                                      var item = newQuizController.quizList;
                                      return ExamListCourseContainer(
                                        topText: item[index].title ?? ksNA.tr,
                                        // sectionText: item[index].section ?? ksNA.tr,
                                        duration:
                                            item[index].duration.toString(),
                                        marksText:
                                            item[index].totalMarks.toString(),
                                        passMark:
                                            item[index].passMarks.toString(),
                                        buttonText:
                                            item[index].quizAnswer!.isEmpty
                                                ? ksGoForExam.tr
                                                : ksDetails.tr,
                                        buttonOnPressed: () async {
                                          // if (item[index].examAns == 0) {
                                          //   if (newQuizController.quizOrFinalQuizIndexValue.value == 1) {
                                          //     Get.toNamed(RouteHelper.quizFirstPage);
                                          //     await newQuizController.getQuizAlert(quizSlug: item[index].slug);
                                          //   }
                                          //   if (newQuizController.quizOrFinalQuizIndexValue.value == 2) {
                                          //     Get.toNamed(RouteHelper.quizFirstPage);
                                          //     await newQuizController.getFinalExamAlert(finalExamSlug: item[index].slug);
                                          //   }
                                          // }
                                          // if (item[index].examAns == 1) {
                                          //    Get.toNamed(RouteHelper.quizExamResult);
                                          //   await newQuizController.getQuizAnswerList(quizSlug: item[index].slug);
                                          // }
                                          if (item[index]
                                              .quizAnswer!
                                              .isNotEmpty) {
                                            Get.toNamed(RouteHelper
                                                .quizExamResultScreen);
                                            await newQuizController
                                                .getQuizAnswer(
                                                    quizSlug:
                                                        item[index].slug!);
                                          } else {
                                            newQuizController.studentAnswerList
                                                .clear();
                                            newQuizController.quizId.value =
                                                item[index].id.toString();
                                            newQuizController
                                                    .quizSlugValue.value =
                                                item[index].slug.toString();
                                            Get.toNamed(RouteHelper.quizScreen);
                                            newQuizController.startTimer(
                                                item[index].duration!);
                                            await newQuizController
                                                .getQuizQuestionList(
                                                    quizSlug:
                                                        item[index].slug!);
                                          }
                                        },
                                      );
                                    }),
                                const SizedBox(
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (newQuizController.quizList.isEmpty)
                        SizedBox(
                            height: (MediaQuery.of(context).size.height -
                                (50 +
                                    MediaQuery.of(context).padding.top +
                                    MediaQuery.of(context).padding.bottom +
                                    64)),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: Text(
                              "No quiz available yet!",
                              style: robotoSemiBold.copyWith(
                                  fontSize: 14,
                                  color: cSmallBodyTextColor,
                                  fontWeight: FontWeight.w500),
                            ))),
                    ],
                  ),
                )),
        ),
      ),
    );
  }
}

//   Widget myQuizListMainUi(BuildContext context, FinalExamQuizModel finalExamQuizModel) {
//         // List<FinalExam> finalExamQuizList = finalExamQuizModel.data.finalExam!;
//     return  SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 16,),
//                           // for(int i=0;i<finalExamQuizList.length;i++)
//                           // Padding(
//                           //   padding: const EdgeInsets.only(top: 16),
//                           //   child: ExamListCourseContainer(topText: finalExamQuizList[i].title??"",sectionText: finalExamQuizList[i].examTitle??"",titleText: finalExamQuizList[i].examTitle??"",marksText: finalExamQuizList[i].totalMarks.toString(),buttonText: "Go For Exam",buttonOnPressed: (){
//                           //     Get.toNamed(RouteHelper.quizFirstPage);
//                           //   },),
//                           // ),
//                           //  const SizedBox(height: 16,),
//                           //  ExamListCourseContainer(topText: "Mathematics with animated lesson official deferent moilit",sectionText: "Chapter - 1",titleText: "Exam - 1",marksText: "100",buttonText: "Details",buttonOnPressed: (){
//                           //     Get.toNamed(RouteHelper.quizExamResult);
//                           //  },),
//                           //  const SizedBox(height: 16,),
//                           //  ExamListCourseContainer(topText: "Mathematics with animated lesson official deferent moilit",sectionText: "Chapter - 1",titleText: "Exam - 1",marksText: "100",buttonText: "Go For Exam",buttonOnPressed: (){
//                           //    Get.toNamed(RouteHelper.quizFirstPage);
//                           //  },),
//                           //  const SizedBox(height: 16,),
//                           //  ExamListCourseContainer(topText: "Mathematics with animated lesson official deferent moilit",sectionText: "Chapter - 1",titleText: "Exam - 1",marksText: "100",buttonText: "Details",buttonOnPressed: (){
//                           //      Get.toNamed(RouteHelper.quizExamResult);
//                           //  },),
//                            const SizedBox(height: 16,),
//                         ],
//                       ),
//                     ),
//                   );
// }

// class MyQuizListContainerWidget extends StatelessWidget {
//   const MyQuizListContainerWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 16,),

//                           // Padding(
//                           //   padding: const EdgeInsets.only(top: 16),
//                           //   child: ExamListCourseContainer(topText: finalExamQuizList[i].title??"",sectionText: finalExamQuizList[i].examTitle??"",titleText: finalExamQuizList[i].examTitle??"",marksText: finalExamQuizList[i].totalMarks.toString(),buttonText: "Go For Exam",buttonOnPressed: (){
//                           //     Get.toNamed(RouteHelper.quizFirstPage);
//                           //   },),
//                           // ),
//                           //  const SizedBox(height: 16,),
//                           //  ExamListCourseContainer(topText: "Mathematics with animated lesson official deferent moilit",sectionText: "Chapter - 1",titleText: "Exam - 1",marksText: "100",buttonText: "Details",buttonOnPressed: (){
//                           //     Get.toNamed(RouteHelper.quizExamResult);
//                           //  },),
//                           //  const SizedBox(height: 16,),
//                           //  ExamListCourseContainer(topText: "Mathematics with animated lesson official deferent moilit",sectionText: "Chapter - 1",titleText: "Exam - 1",marksText: "100",buttonText: "Go For Exam",buttonOnPressed: (){
//                           //    Get.toNamed(RouteHelper.quizFirstPage);
//                           //  },),
//                           //  const SizedBox(height: 16,),
//                           //  ExamListCourseContainer(topText: "Mathematics with animated lesson official deferent moilit",sectionText: "Chapter - 1",titleText: "Exam - 1",marksText: "100",buttonText: "Details",buttonOnPressed: (){
//                           //      Get.toNamed(RouteHelper.quizExamResult);
//                           //  },),
//                            const SizedBox(height: 16,),
//                         ],
//                       ),
//                     ),
//                   );
//   }
// }

class ExamListCourseContainer extends StatelessWidget {
  const ExamListCourseContainer(
      {super.key,
      required this.topText,
      required this.duration,
      required this.marksText,
      required this.buttonText,
      required this.passMark,
      this.buttonOnPressed});
  final String topText, duration, marksText, passMark, buttonText;
  final VoidCallback? buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        color: cWhiteColor,
        border: Border.all(width: 1, color: cLineColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                topText,
                style: TextStyle(
                    fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.w600,
                    color: cBlackColor),
              ),
            ),
            const Divider(
              color: cLineColor,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Marks".tr,
                  style: TextStyle(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w600,
                      color: cBlackColor),
                ),
                Text(
                  "Duration".tr,
                  style: TextStyle(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w600,
                      color: cBlackColor),
                ),
                Text(
                  "Pass Marks".tr,
                  style: TextStyle(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w600,
                      color: cBlackColor),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  marksText,
                  style: TextStyle(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w400,
                      color: cSmallBodyTextColor),
                ),
                Text(
                  passMark,
                  style: TextStyle(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w400,
                      color: cSmallBodyTextColor),
                ),
                Text(
                  duration,
                  style: TextStyle(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w400,
                      color: cSmallBodyTextColor),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              height: 42,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: cGreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
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
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
