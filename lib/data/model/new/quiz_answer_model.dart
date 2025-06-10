class QuizAnswerModel {
    final Quizes? quiz;

    QuizAnswerModel({
        this.quiz,
    });

    factory QuizAnswerModel.fromJson(Map<String, dynamic> json) => QuizAnswerModel(
        quiz: json["quiz"] == null ? null : Quizes.fromJson(json["quiz"]),
    );
}

class Quizes {
    final String? title;
    final int? duration;
    final Result? result;
    final List<Question>? questions;

    Quizes({
        this.title,
        this.duration,
        this.result,
        this.questions,
    });

    factory Quizes.fromJson(Map<String, dynamic> json) => Quizes(
        title: json["title"],
        duration: json["duration"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
    );
}

class Question {
    final int? ansRight;
    final String? questions;
    final dynamic description;
    final String? questionType;
    final List<Option>? options;
    final dynamic studentAns;

    Question({
        this.ansRight,
        this.questions,
        this.description,
        this.questionType,
        this.options,
        this.studentAns,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        ansRight: json["ansRight"],
        questions: json["questions"],
        description: json["description"],
        questionType: json["question_type"],
        options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
        studentAns: json["student_ans"],
    );
}

class Option {
    final String? answer;
    final int? isCorrect;

    Option({
        this.answer,
        this.isCorrect,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        answer: json["answer"],
        isCorrect: json["is_correct"],
    );
}

class Result {
    final int? id;
    final int? userId;
    final int? quizId;
    final String? slug;
    final int? courseId;
    final int? totalMarks;
    final int? passMarks;
    final int? yourMarks;
    final int? isPassed;

    Result({
        this.id,
        this.userId,
        this.quizId,
        this.slug,
        this.courseId,
        this.totalMarks,
        this.passMarks,
        this.yourMarks,
        this.isPassed,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        quizId: json["quiz_id"],
        slug: json["slug"],
        courseId: json["course_id"],
        totalMarks: json["total_marks"],
        passMarks: json["pass_marks"],
        yourMarks: json["your_marks"],
        isPassed: json["is_passed"],
    );
}
