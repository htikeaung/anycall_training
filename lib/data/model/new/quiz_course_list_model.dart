class QuizCourseModel {
    final List<Course>? courses;
    final int? totalCourses;
    final int? totalResults;

    QuizCourseModel({
        this.courses,
        this.totalCourses,
        this.totalResults,
    });

    factory QuizCourseModel.fromJson(Map<String, dynamic> json) => QuizCourseModel(
        courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
        totalCourses: json["total_courses"],
        totalResults: json["total_results"],
    );
}

class Course {
    final int? id;
    final String? thumbnail;
    final String? title;
    final String? slug;
    final int? totalLessons;
    final int? totalEnrolls;
    final bool? isFree;
    final String? totalRating;
    final String? price;
    final bool? isDiscounted;
    final String? discountType;
    final String? discountedPrice;
    final String? status;

    Course({
        this.id,
        this.thumbnail,
        this.title,
        this.slug,
        this.totalLessons,
        this.totalEnrolls,
        this.isFree,
        this.totalRating,
        this.price,
        this.isDiscounted,
        this.discountType,
        this.discountedPrice,
        this.status,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        slug: json["slug"],
        totalLessons: json["total_lessons"],
        totalEnrolls: json["total_enrolls"],
        isFree: json["is_free"],
        totalRating: json["total_rating"],
        price: json["price"],
        isDiscounted: json["is_discounted"],
        discountType: json["discount_type"],
        discountedPrice: json["discounted_price"],
        status: json["status"],
    );
}
