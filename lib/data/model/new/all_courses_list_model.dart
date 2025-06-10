class AllCoursesListModel {
    final List<Courses>? courses;

    AllCoursesListModel({
        this.courses,
    });

    factory AllCoursesListModel.fromJson(Map<String, dynamic> json) => AllCoursesListModel(
        courses: json["courses"] == null ? [] : List<Courses>.from(json["courses"]!.map((x) => Courses.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
    };
}

class Courses {
    final int? id;
    final String? thumbnail;
    final String? title;
    final String? slug;
    final dynamic totalLessons;
    final dynamic totalEnrolls;
    final bool? isFree;
    final String? totalRating;
    final String? price;
    final bool? isDiscounted;
    final String? discountType;
    final String? discountedPrice;
    final String? status;

    Courses({
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

    factory Courses.fromJson(Map<String, dynamic> json) => Courses(
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

    Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "title": title,
        "slug": slug,
        "total_lessons": totalLessons,
        "total_enrolls": totalEnrolls,
        "is_free": isFree,
        "total_rating": totalRating,
        "price": price,
        "is_discounted": isDiscounted,
        "discount_type": discountType,
        "discounted_price": discountedPrice,
        "status": status,
    };
}
