class MeetingListModel {
    final List<Course>? courses;
    final int? totalCourses;
    final int? totalResults;

    MeetingListModel({
        this.courses,
        this.totalCourses,
        this.totalResults,
    });

    factory MeetingListModel.fromJson(Map<String, dynamic> json) => MeetingListModel(
        courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
        totalCourses: json["total_courses"],
        totalResults: json["total_results"],
    );
}

class Course {
    final int? id;
    final String? thumbnail;
    final String? title;
    final String? meetingMethod;
    final String? meetingType;
    final String? meetingInterval;
    final List<dynamic>? days;
    final String? startDate;
    final String? startTime;
    final dynamic endTime;
    final int? duration;
    final String? joinLink;

    Course({
        this.id,
        this.thumbnail,
        this.title,
        this.meetingMethod,
        this.meetingType,
        this.meetingInterval,
        this.days,
        this.startDate,
        this.startTime,
        this.endTime,
        this.duration,
        this.joinLink,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        meetingMethod: json["meeting_method"],
        meetingType: json["meeting_type"],
        meetingInterval: json["meeting_interval"],
        days: json["days"] == null ? [] : List<dynamic>.from(json["days"]!.map((x) => x)),
        startDate: json["start_date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        duration: json["duration"],
        joinLink: json["join_link"],
    );
}
