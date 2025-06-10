import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/controller/home_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:anycallmobile_trainingcenter/data/model/home_data_model/home_data.dart';
import 'package:anycallmobile_trainingcenter/utils/colors.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/styles.dart';
import 'package:anycallmobile_trainingcenter/utils/utility_function.dart';

class MyBlogListWidget extends StatelessWidget {
  const MyBlogListWidget({
    super.key,
    required this.blogList,
    this.readMoreOnPressed,
  });
  final List<MyBlog> blogList;
  final VoidCallback? readMoreOnPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Knowledge",
            style:
                robotoSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.68,
            ),
            itemCount: blogList.length > 2 ? 2 : blogList.length,
            itemBuilder: (BuildContext context, int index) {
              return MyBlogWidget(
                courseImage: blogList[index].thumbnail ?? "",
                courseTitle: blogList[index].title ?? "",
                blogDate: blogList[index].publishedDate ?? "",
                authorName: blogList[index].author ?? "",
                commentCount: blogList[index].commentsCount.toString(),
                shortDescription: blogList[index].shortDescription ?? "",
                slugValue: blogList[index].slug ?? "",
                readMoreOnPressed: readMoreOnPressed ??
                    () async {
                      debugPrint("Slug: ${blogList[index].slug}");
                      await Get.find<HomeController>()
                          .getBlogDetailsData(slug: blogList[index].slug ?? "");
                      Get.toNamed(RouteHelper.blogDetailsScreen);
                      // Get.offNamedUntil(RouteHelper.blogDetailsScreen, ModalRoute.withName(RouteHelper.getMainRoute("0")));
                    },
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyBlogWidget extends StatelessWidget {
  const MyBlogWidget({
    super.key,
    required this.courseImage,
    required this.courseTitle,
    required this.blogDate,
    required this.authorName,
    required this.commentCount,
    required this.shortDescription,
    required this.slugValue,
    this.readMoreOnPressed,
  });
  final String courseImage,
      courseTitle,
      blogDate,
      authorName,
      commentCount,
      shortDescription,
      slugValue;
  final VoidCallback? readMoreOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ((MediaQuery.of(context).size.width) - 40) / 2,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            child: Image.network(
              courseImage,
              width: (MediaQuery.of(context).size.width - 30),
              loadingBuilder: imageLoadingBuilder,
              fit: BoxFit.cover,
              // height: 100,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 60) / 2,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                authorName,
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeExtraSmall,
                                    fontWeight: FontWeight.w400,
                                    color: cSmallBodyTextColor),
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.message,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                commentCount,
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeExtraSmall,
                                    fontWeight: FontWeight.w400,
                                    color: cSmallBodyTextColor),
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                blogDate,
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeExtraSmall,
                                    fontWeight: FontWeight.w400,
                                    color: cSmallBodyTextColor),
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   "Publish Date: $blogDate",
                    //   style: TextStyle(
                    //       fontSize: Dimensions.fontSizeSmall,
                    //       fontWeight: FontWeight.w400,
                    //       color: cSmallBodyTextColor),
                    //   overflow: TextOverflow.clip,
                    // ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              courseTitle.tr,
              style: TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                  fontWeight: FontWeight.w600,
                  color: cBlackColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              shortDescription,
              style: TextStyle(
                  fontSize: Dimensions.fontSizeSmall,
                  fontWeight: FontWeight.w400,
                  color: cSmallBodyTextColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: InkWell(
              onTap: readMoreOnPressed,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: cGreenColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        "Read More",
                        style: TextStyle(
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w600,
                          color: cWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
