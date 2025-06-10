class QuizListModel {
    final List<Quiz>? quizzes;

    QuizListModel({
        this.quizzes,
    });

    factory QuizListModel.fromJson(Map<String, dynamic> json) => QuizListModel(
        quizzes: json["quizzes"] == null ? [] : List<Quiz>.from(json["quizzes"]!.map((x) => Quiz.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "quizzes": quizzes == null ? [] : List<dynamic>.from(quizzes!.map((x) => x.toJson())),
    };
}

class Quiz {
    final int? id;
    final int? sectionId;
    final String? title;
    final String? slug;
    final int? duration;
    final int? totalMarks;
    final int? passMarks;
    final int? certificateIncluded;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<QuizAnswer>? quizAnswer;

    Quiz({
        this.id,
        this.sectionId,
        this.title,
        this.slug,
        this.duration,
        this.totalMarks,
        this.passMarks,
        this.certificateIncluded,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.quizAnswer,
    });

    factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        sectionId: json["section_id"],
        title: json["title"],
        slug: json["slug"],
        duration: json["duration"],
        totalMarks: json["total_marks"],
        passMarks: json["pass_marks"],
        certificateIncluded: json["certificate_included"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        quizAnswer: json["quiz_answer"] == null ? [] : List<QuizAnswer>.from(json["quiz_answer"]!.map((x) => QuizAnswer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "section_id": sectionId,
        "title": title,
        "slug": slug,
        "duration": duration,
        "total_marks": totalMarks,
        "pass_marks": passMarks,
        "certificate_included": certificateIncluded,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "quiz_answer": quizAnswer == null ? [] : List<dynamic>.from(quizAnswer!.map((x) => x.toJson())),
    };
}

class QuizAnswer {
    final int? id;
    final int? userId;
    final int? quizQuestionId;
    final int? quizId;
    final dynamic answers;
    final dynamic correctAnswer;
    final int? isCorrect;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    QuizAnswer({
        this.id,
        this.userId,
        this.quizQuestionId,
        this.quizId,
        this.answers,
        this.correctAnswer,
        this.isCorrect,
        this.createdAt,
        this.updatedAt,
    });

    factory QuizAnswer.fromJson(Map<String, dynamic> json) => QuizAnswer(
        id: json["id"],
        userId: json["user_id"],
        quizQuestionId: json["quiz_question_id"],
        quizId: json["quiz_id"],
        answers: json["answers"],
        correctAnswer: json["correct_answer"],
        isCorrect: json["is_correct"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "quiz_question_id": quizQuestionId,
        "quiz_id": quizId,
        "answers": answers,
        "correct_answer": correctAnswer,
        "is_correct": isCorrect,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
