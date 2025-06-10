import 'package:anycallmobile_trainingcenter/data/model/common/quiz.dart';

import 'lesson.dart';

class Section {
  int? id;
  String? title;
  String? slug;
  List<Lesson>? lessons;
  List<Quiz>? quizes;

  Section({this.id, this.title, this.slug, this.lessons, this.quizes});

  factory Section.fromJson(Map<String, Object?> json) => Section(
        id: json['id'] as int?,
        title: json['title'] as String?,
        slug: json["slug"] as String?,
        lessons: (json['lessons'] as List<dynamic>?)
            ?.map((e) => Lesson.fromJson(e as Map<String, Object?>))
            .toList(),
        quizes: (json['quizzes'] as List<dynamic>?)
            ?.map((e) => Quiz.fromJson(e as Map<String, Object?>))
            .toList(),
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'title': title,
        'lessons': lessons?.map((e) => e.toJson()).toList(),
        'quizzes': quizes?.map((e) => e.toJson()).toList(),
      };
}
