// class QuizQuestionModel {
//     final Quizes? quiz;
//     final List<Questiones>? questions;

//     QuizQuestionModel({
//         this.quiz,
//         this.questions,
//     });

//     factory QuizQuestionModel.fromJson(Map<String, dynamic> json) => QuizQuestionModel(
//         quiz: json["quiz"] == null ? null : Quizes.fromJson(json["quiz"]),
//         questions: json["questions"] == null ? [] : List<Questiones>.from(json["questions"]!.map((x) => Questiones.fromJson(x))),
//     );

// }

// class Questiones {
//     final String? question;
//     final String? questionType;
//     final List<Option>? option;
//     final List<int>? correctAnswerIndex;

//     Questiones({
//         this.question,
//         this.questionType,
//         this.option,
//         this.correctAnswerIndex,
//     });

//     factory Questiones.fromJson(Map<String, dynamic> json) => Questiones(
//         question: json["question"],
//         questionType: json["question_type"],
//         option: json["option"] == null ? [] : List<Option>.from(json["option"]!.map((x) => Option.fromJson(x))),
//         correctAnswerIndex: json["correct_answer_index"] == null ? [] : List<int>.from(json["correct_answer_index"]!.map((x) => x)),
//     );
// }

// class Option {
//     final String? answer;
//     final int? isCorrect;

//     Option({
//         this.answer,
//         this.isCorrect,
//     });

//     factory Option.fromJson(Map<String, dynamic> json) => Option(
//         answer: json["answer"],
//         isCorrect: json["is_correct"],
//     );
// }

// class Quizes {
//     final int? id;
//     final int? sectionId;
//     final String? title;
//     final String? slug;
//     final int? duration;
//     final int? totalMarks;
//     final int? passMarks;
//     final int? certificateIncluded;
//     final int? status;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;

//     Quizes({
//         this.id,
//         this.sectionId,
//         this.title,
//         this.slug,
//         this.duration,
//         this.totalMarks,
//         this.passMarks,
//         this.certificateIncluded,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory Quizes.fromJson(Map<String, dynamic> json) => Quizes(
//         id: json["id"],
//         sectionId: json["section_id"],
//         title: json["title"],
//         slug: json["slug"],
//         duration: json["duration"],
//         totalMarks: json["total_marks"],
//         passMarks: json["pass_marks"],
//         certificateIncluded: json["certificate_included"],
//         status: json["status"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );
// }

class QuizQuestionModel {
    final int? userId;
    final Quizess? quiz;

    QuizQuestionModel({
        this.userId,
        this.quiz,
    });

    factory QuizQuestionModel.fromJson(Map<String, dynamic> json) => QuizQuestionModel(
        userId: json["user_id"],
        quiz: json["quiz"] == null ? null : Quizess.fromJson(json["quiz"]),
    );
}

class Quizess {
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
    final List<Questiones>? questions;
    final Section? section;
    final dynamic result;

    Quizess({
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
        this.questions,
        this.section,
        this.result,
    });

    factory Quizess.fromJson(Map<String, dynamic> json) => Quizess(
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
        questions: json["questions"] == null ? [] : List<Questiones>.from(json["questions"]!.map((x) => Questiones.fromJson(x))),
        section: json["section"] == null ? null : Section.fromJson(json["section"]),
        result: json["result"],
    );
}

class Questiones {
    final int? id;
    final int? quizId;
    final String? questionType;
    final String? question;
    final List<Answer>? answers;
    final String? description;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Questiones({
        this.id,
        this.quizId,
        this.questionType,
        this.question,
        this.answers,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Questiones.fromJson(Map<String, dynamic> json) => Questiones(
        id: json["id"],
        quizId: json["quiz_id"],
        questionType: json["question_type"],
        question: json["question"],
        answers: json["answers"] == null ? [] : List<Answer>.from(json["answers"]!.map((x) => Answer.fromJson(x))),
        description: json["description"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}

class Answer {
    final String? answer;
    final int? isCorrect;

    Answer({
        this.answer,
        this.isCorrect,
    });

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        answer: json["answer"],
        isCorrect: json["is_correct"],
    );
}

class Section {
    final int? id;
    final String? title;
    final String? slug;
    final int? courseId;
    final int? orderNo;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Section({
        this.id,
        this.title,
        this.slug,
        this.courseId,
        this.orderNo,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        courseId: json["course_id"],
        orderNo: json["order_no"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}

