import '../common/category.dart';
import '../common/course.dart';
import '../common/instructor.dart';
import '../common/my_course.dart';
import 'slider.dart';

class HomeData {
  String? sectionType;
  List<Slider>? sliders;
  List<MyCourse>? myCourses;
  List<Category>? categories;
  List<Course>? topCourses;
  List<Instructor>? instructors;
  List<Course>? featuredCourses;
  List<Course>? offerCourses;
  final List<MyBlog>? myBlog;

  HomeData({
    this.sectionType,
    this.sliders,
    this.myCourses,
    this.categories,
    this.topCourses,
    this.instructors,
    this.featuredCourses,
    this.offerCourses,
    this.myBlog,
  });

  factory HomeData.fromJson(Map<String, Object?> json) => HomeData(
        sectionType: json['section_type'] as String?,
        sliders: (json['sliders'] as List<dynamic>?)
            ?.map((e) => Slider.fromJson(e as Map<String, Object?>))
            .toList(),
        myCourses: (json['my_courses'] as List<dynamic>?)
            ?.map((e) => MyCourse.fromJson(e as Map<String, Object?>))
            .toList(),
        categories: (json['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e as Map<String, Object?>))
            .toList(),
        topCourses: (json['top_courses'] as List<dynamic>?)
            ?.map((e) => Course.fromJson(e as Map<String, Object?>))
            .toList(),
        instructors: (json['instructors'] as List<dynamic>?)
            ?.map((e) => Instructor.fromJson(e as Map<String, Object?>))
            .toList(),
        featuredCourses: (json['featured_courses'] as List<dynamic>?)
            ?.map((e) => Course.fromJson(e as Map<String, Object?>))
            .toList(),
        offerCourses: (json['offer_courses'] as List<dynamic>?)
            ?.map((e) => Course.fromJson(e as Map<String, Object?>))
            .toList(),
             myBlog:  (json['my_blog'] as List<dynamic>?)
            ?.map((e) => MyBlog.fromJson(e as Map<String, Object?>))
            .toList(),
              // json["my_blog"] == null ? [] : List<MyBlog>.from(json["my_blog"]!.map((x) => MyBlog.fromJson(x))),
      );

  Map<String, Object?> toJson() => {
        'section_type': sectionType,
        'sliders': sliders?.map((e) => e.toJson()).toList(),
        'my_courses': myCourses?.map((e) => e.toJson()).toList(),
        'categories': categories?.map((e) => e.toJson()).toList(),
        'top_courses': topCourses?.map((e) => e.toJson()).toList(),
        'instructors': instructors?.map((e) => e.toJson()).toList(),
        'featured_courses': featuredCourses?.map((e) => e.toJson()).toList(),
        'offer_courses': offerCourses?.map((e) => e.toJson()).toList(),
      };
}
class MyBlog {
    final int? id;
    final String? thumbnail;
    final String? title;
    final String? slug;
    final String? shortDescription;
    final String? description;
    final int? commentsCount;
    final String? author;
    final String? publishedDate;

    MyBlog({
        this.id,
        this.thumbnail,
        this.title,
        this.slug,
        this.shortDescription,
        this.description,
        this.commentsCount,
        this.author,
        this.publishedDate,
    });

    factory MyBlog.fromJson(Map<String, dynamic> json) => MyBlog(
        id: json["id"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        slug: json["slug"],
        shortDescription: json["short_description"],
        description: json["description"],
        commentsCount: json["comments_count"],
        author: json["author"],
        publishedDate: json["published_date"],
    );
}
