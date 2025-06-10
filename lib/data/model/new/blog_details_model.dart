class BlogDetailsModel {
    final Blog? blog;
    final List<Blog>? allBlogs;
    final List<Blog>? featuredBlogs;
    final int? comment;

    BlogDetailsModel({
        this.blog,
        this.allBlogs,
        this.featuredBlogs,
        this.comment,
    });

    factory BlogDetailsModel.fromJson(Map<String, dynamic> json) => BlogDetailsModel(
        blog: json["blog"] == null ? null : Blog.fromJson(json["blog"]),
        allBlogs: json["all_blogs"] == null ? [] : List<Blog>.from(json["all_blogs"]!.map((x) => Blog.fromJson(x))),
        featuredBlogs: json["featured_blogs"] == null ? [] : List<Blog>.from(json["featured_blogs"]!.map((x) => Blog.fromJson(x))),
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "blog": blog?.toJson(),
        "all_blogs": allBlogs == null ? [] : List<dynamic>.from(allBlogs!.map((x) => x.toJson())),
        "featured_blogs": featuredBlogs == null ? [] : List<dynamic>.from(featuredBlogs!.map((x) => x.toJson())),
        "comment": comment,
    };
}

class Blog {
    final int? id;
    final String? thumbnail;
    final String? title;
    final String? slug;
    final String? shortDescription;
    final String? description;
    final int? commentsCount;
    final String? author;
    final String? publishedDate;

    Blog({
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

    factory Blog.fromJson(Map<String, dynamic> json) => Blog(
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

    Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "title": title,
        "slug": slug,
        "short_description": shortDescription,
        "description": description,
        "comments_count": commentsCount,
        "author": author,
        "published_date": publishedDate,
    };
}