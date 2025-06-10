import 'dart:async';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/controller/auth_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/new/sp_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:anycallmobile_trainingcenter/data/model/common_model/common_data_model.dart';
import 'package:anycallmobile_trainingcenter/data/model/new/quiz_answer_model.dart';
import 'package:anycallmobile_trainingcenter/data/model/new/quiz_course_list_model.dart';
import 'package:anycallmobile_trainingcenter/data/model/new/quiz_list_model.dart';
import 'package:anycallmobile_trainingcenter/data/model/new/quiz_question_model.dart';
import 'package:anycallmobile_trainingcenter/services/api_services.dart';
import 'package:anycallmobile_trainingcenter/utils/string.dart';
import 'package:anycallmobile_trainingcenter/utils/utility_function.dart';

class NewQuizController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();

  // final RxString quizSlugValue = RxString("");

  final Rx<QuizCourseModel?> quizCourseData = Rx<QuizCourseModel?>(null);
  final RxList<Course> quizCourseList = RxList<Course>([]);
  final RxBool isquizCourseLoading = RxBool(false);
  Future<void> getQuizCourseList() async {
    try {
      isquizCourseLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "user/course-list",
      ) as CommonDM;
      if (response.success != null) {
        quizCourseList.clear();
        quizCourseData.value = QuizCourseModel.fromJson(response.data);
        quizCourseList.addAll(quizCourseData.value!.courses!);
        isquizCourseLoading.value = false;
      } else {
        isquizCourseLoading.value = true;
      }
    } catch (e) {
      // Get.offAllNamed(RouteHelper.getSignInRoute(""));
      // Get.find<AuthController>().clearSharedData();
      isquizCourseLoading.value = false;
      ll('getQuizCourseList error: $e');
    }
  }

  final Rx<QuizListModel?> quizData = Rx<QuizListModel?>(null);
  final RxList<Quiz> quizList = RxList<Quiz>([]);
  final RxBool isQuizListLoading = RxBool(false);
  Future<void> getQuizList({required String slug}) async {
    try {
      isQuizListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "user/quiz-list/$slug",
      ) as CommonDM;
      if (response.success != null) {
        quizList.clear();
        quizData.value = QuizListModel.fromJson(response.data);
        quizList.addAll(quizData.value!.quizzes!);
        isQuizListLoading.value = false;
      } else {
        isQuizListLoading.value = true;
      }
    } catch (e) {
      // Get.offAllNamed(RouteHelper.getSignInRoute(""));
      // Get.find<AuthController>().clearSharedData();
      isQuizListLoading.value = false;
      ll('getQuizList error: $e');
    }
  }

  final Rx<QuizAnswerModel?> quizAnswerData = Rx<QuizAnswerModel?>(null);
  final RxList<Question> questionAnswerList = RxList<Question>([]);
  final RxBool isQuizAnswerLoading = RxBool(false);
  Future<void> getQuizAnswer({required String quizSlug}) async {
    try {
      isQuizAnswerLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "user/answers/$quizSlug",
      ) as CommonDM;
      if (response.success != null) {
        questionAnswerList.clear();
        quizAnswerData.value = QuizAnswerModel.fromJson(response.data);
        questionAnswerList.addAll(quizAnswerData.value!.quiz!.questions!);
        isQuizAnswerLoading.value = false;
      } else {
        isQuizAnswerLoading.value = true;
      }
    } catch (e) {
      isQuizAnswerLoading.value = false;
      ll('getQuizAnswer error: $e');
    }
  }

  //  final Rx<QuizQuestionModel?> quizQuestionData = Rx<QuizQuestionModel?>(null);
  // final RxList<Questiones> questionList = RxList<Questiones>([]);
  // final RxBool isQuestionListLoading = RxBool(false);
  // Future<void> getQuizQuestionList({
  //   required String quizId,
  // }) async {
  //   try {
  //     isQuestionListLoading.value = true;
  //     String? token = await spController.getBearerToken();
  //      Map<String, String> body = {
  //       "quiz_id": quizId.toString(),
  //     };
  //     var response = await apiServices.commonApiCall(
  //       requestMethod: post,
  //       token: token,
  //       body: body,
  //       url: "/api/user/my-quiz",
  //     ) as CommonDM;
  //     if (response.success != null) {
  //       questionList.clear();
  //       quizQuestionData.value = QuizQuestionModel.fromJson(response.data);
  //       questionList.addAll(quizQuestionData.value!.questions!);
  //       isQuestionListLoading.value = false;
  //     } else {
  //       isQuestionListLoading.value = true;
  //     }
  //   } catch (e) {
  //     Get.offAllNamed(RouteHelper.getSignInRoute(""));
  //     Get.find<AuthController>().clearSharedData();
  //     isQuestionListLoading.value = false;
  //     ll('getQuizQuestionList error: $e');
  //   }
  // }

  final Rx<QuizQuestionModel?> quizQuestionData = Rx<QuizQuestionModel?>(null);
  final RxList<Questiones> questionList = RxList<Questiones>([]);
  final RxBool isQuestionListLoading = RxBool(false);
  Future<void> getQuizQuestionList({
    required String quizSlug,
  }) async {
    try {
      isQuestionListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "user/my-quiz/$quizSlug",
      ) as CommonDM;
      if (response.success != null) {
        questionList.clear();
        quizQuestionData.value = QuizQuestionModel.fromJson(response.data);
        questionList.addAll(quizQuestionData.value!.quiz!.questions!);
        isQuestionListLoading.value = false;
      } else {
        isQuestionListLoading.value = true;
      }
    } catch (e) {
      Get.offAllNamed(RouteHelper.getSignInRoute(""));
      Get.find<AuthController>().clearSharedData();
      isQuestionListLoading.value = false;
      ll('getQuizQuestionList error: $e');
    }
  }

//   //!For Question Submission
  final RxList<Map<String, dynamic>> studentAnswerList =
      RxList<Map<String, dynamic>>([]);

  // void clearAnswersForQuestion(int questionIndex) {
  //   studentAnswerList.removeWhere(
  //       (answer) => answer["question_index"] == questionIndex.toString());
  // }

//   void addAnswer(int questionIndex, int answerIndex) {
//     Map<String, dynamic> studentAnswer = {
//       "question_index": questionIndex.toString(),
//       "answer_index": answerIndex.toString()
//     };
//     studentAnswerList.add(studentAnswer);
//   }

//   void removeAnswer(int questionIndex, int answerIndex) {
//     studentAnswerList.removeWhere((answer) =>
//         answer["question_index"] == questionIndex.toString() &&
//         answer["answer_index"] == answerIndex.toString());
//   }

//   bool isAnswerSelected(int questionIndex, int answerIndex) {
//     return studentAnswerList.any((answer) =>
//         answer["question_index"] == questionIndex.toString() &&
//         answer["answer_index"] == answerIndex.toString());
//   }

//   //!Timer

  RxInt remainingTimeInSeconds = 0.obs;

  Timer? _timer;
  void startTimer(int durationInMinutes) {
    remainingTimeInSeconds.value = durationInMinutes * 60;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (remainingTimeInSeconds.value > 0) {
        remainingTimeInSeconds.value--;
      } else {
        _timer?.cancel();
        // await submitQuiz();
      }
    });
  }

  String getFormattedTime() {
    int seconds = remainingTimeInSeconds.value;
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

//   //!Quiz Submit
  final RxMap<String, dynamic> studentAnswerMap = RxMap<String, dynamic>({});

// //!Default
  final RxList<Map<String, dynamic>> studentAllQuestionAnswer =
      RxList<Map<String, dynamic>>([]);

  void updateQuizData({
    required String questionId,
    required String questionType,
    required int correctAnswer,
    required int studentAnswer,
  }) {
    int questionIdInt = int.parse(questionId.split('_').last);

    Map<String, dynamic>? questionDataToUpdate;
    for (var questionData in studentAllQuestionAnswer) {
      if (questionData['questionId'] == questionIdInt.toString()) {
        questionDataToUpdate = questionData;
        break;
      }
    }

    if (questionDataToUpdate != null) {
      questionDataToUpdate["question_type_$questionId"] = questionType;
      questionDataToUpdate["correct_answer_$questionId"] = correctAnswer;
      questionDataToUpdate["student_answer_$questionId"] = studentAnswer;
      studentAllQuestionAnswer.removeWhere(
          (element) => element['questionId'] == questionIdInt.toString());
      studentAllQuestionAnswer.add(questionDataToUpdate);
    }
  }

  void updateStudentAnswerMcq(String questionId, int optionIndex) {
    List<int> currentAnswers = mcqDefaultAnswerMap[questionId] ?? [];

    if (currentAnswers.contains(optionIndex)) {
      currentAnswers.remove(optionIndex);
    } else {
      currentAnswers.add(optionIndex);
    }

    mcqDefaultAnswerMap[questionId] = currentAnswers;
  }

//   //! Submit Quiz Api implement
  final RxString quizId = RxString("");
  final RxList questionIdList = RxList([]);
  final RxList<Map<String, dynamic>> defaultQuizMap =
      RxList<Map<String, dynamic>>([]);
  RxBool isQuizSubmitLoading = RxBool(false);
  final RxString quizSlugValue = RxString("");

//   //!working
  Future<void> submitQuiz() async {
    try {
      isQuizSubmitLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        "quiz_id": quizId.value.toString(),
      };
      for (var index
          in List.generate(questionIdList.length, (index) => index)) {
        body["question_id[$index]"] = questionIdList[index].toString();
      }

      for (var questionData in studentAllQuestionAnswer) {
        String questionIdKey =
            questionData.keys.firstWhere((key) => key.contains("questionId"));
        String questionId = questionData[questionIdKey].toString();
        String correctAnswerKeyPrefix = "correct_answer_$questionId";
        String studentAnswerKeyPrefix = "student_answer_$questionId";
        questionData.forEach((key, value) {
          if (key.startsWith(correctAnswerKeyPrefix)) {
            body[key] = value?.toString() ?? '';
          }
        });

        questionData.forEach((key, value) {
          if (key.startsWith(studentAnswerKeyPrefix)) {
            body[key] = value?.toString() ?? '';
          }
        });
      }

      ll(body);

      var response = await apiServices.commonApiCall(
        requestMethod: post,
        url: "user/my-answer",
        body: body,
        token: token,
      );
      if (response is CommonDM) {
        if (response.statusCode == 200) {
          isQuizSubmitLoading.value = false;
          Get.toNamed(RouteHelper.quizExamResultScreen);
          await getQuizAnswer(quizSlug: quizSlugValue.value);
        } else {
          isQuizSubmitLoading.value = false;
        }
      } else {
        isQuizSubmitLoading.value = false;
        ll('Unexpected response type: $response');
      }
    } catch (e) {
      Get.offAllNamed(RouteHelper.getSignInRoute(""));
      Get.find<AuthController>().clearSharedData();
      isQuizSubmitLoading.value = false;
      ll('submitQuiz error: $e');
    }
  }

//   //! quiz answer state

  RxMap<String, dynamic> mcqDefaultAnswerMap = <String, dynamic>{}.obs;

  void updateStudentAnswer(String questionId, dynamic answer) {
    mcqDefaultAnswerMap[questionId] = answer;
  }

  void clearAllAnswers() {
    mcqDefaultAnswerMap.clear();
  }
}
