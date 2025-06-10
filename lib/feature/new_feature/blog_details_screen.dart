import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/loading_indicator.dart';
import 'package:anycallmobile_trainingcenter/controller/home_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:anycallmobile_trainingcenter/feature/common/my_blog_list_widget.dart';
import 'package:anycallmobile_trainingcenter/utils/colors.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/utility_function.dart';
import 'package:anycallmobile_trainingcenter/widgets/custom_appbar.dart';

class BlogDetailsScreen extends StatelessWidget {
  BlogDetailsScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cWhiteColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.00),
          //* info:: appBar
          child: CustomAppBar(
            appBarColor: cWhiteColor,
            title: "Blog Details".tr,
            hasBackButton: true,
            isCenterTitle: true,
            onBack: () {
              Get.back();
            },
          ),
        ),
        body: Obx(
          () => homeController.isBlogDetailsLoading.value
              ? const LoadingIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 60) /
                                          2,
                                  child: Row(
                                    children: [
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
                                            homeController.blogDetailsData.value
                                                    ?.blog?.publishedDate
                                                    .toString() ??
                                                "",
                                            style: TextStyle(
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: cSmallBodyTextColor),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
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
                                            homeController.blogDetailsData.value
                                                    ?.blog?.author ??
                                                "",
                                            style: TextStyle(
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: cSmallBodyTextColor),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    homeController.blogDetailsData.value?.blog
                                            ?.thumbnail ??
                                        "",
                                    width: (MediaQuery.of(context).size.width -
                                        30),
                                    loadingBuilder: imageLoadingBuilder,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          homeController.blogDetailsData.value?.blog?.title ??
                              "",
                          style: TextStyle(
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w600,
                              color: cBlackColor),
                          overflow: TextOverflow.clip,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          homeController
                                  .blogDetailsData.value?.blog?.description ??
                              "",
                          style: TextStyle(
                              fontSize: Dimensions.fontSizeSmall,
                              fontWeight: FontWeight.w400,
                              color: cSmallBodyTextColor),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          "You May Also Like",
                          style: TextStyle(
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w600,
                              color: cBlackColor),
                          overflow: TextOverflow.clip,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.68,
                          ),
                          itemCount: homeController.allBlogList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = homeController.allBlogList;
                            return MyBlogWidget(
                              courseImage: item[index].thumbnail ?? "",
                              courseTitle: item[index].title ?? "",
                              blogDate: item[index].publishedDate ?? "",
                              authorName: item[index].author ?? "",
                              commentCount:
                                  item[index].commentsCount.toString(),
                              shortDescription:
                                  item[index].shortDescription ?? "",
                              slugValue: item[index].slug ?? "",
                              readMoreOnPressed: () async {
                                Get.toNamed(RouteHelper.blogDetailsScreen);
                                await Get.find<HomeController>()
                                    .getBlogDetailsData(
                                        slug: item[index].slug ?? "");
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          "Featured Blog",
                          style: TextStyle(
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w600,
                              color: cBlackColor),
                          overflow: TextOverflow.clip,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.68,
                          ),
                          itemCount: homeController.featuredBlogList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = homeController.featuredBlogList;
                            return MyBlogWidget(
                              courseImage: item[index].thumbnail ?? "",
                              courseTitle: item[index].title ?? "",
                              blogDate: item[index].publishedDate ?? "",
                              authorName: item[index].author ?? "",
                              commentCount:
                                  item[index].commentsCount.toString(),
                              shortDescription:
                                  item[index].shortDescription ?? "",
                              slugValue: item[index].slug ?? "",
                              readMoreOnPressed: () async {
                                Get.toNamed(RouteHelper.blogDetailsScreen);
                                await Get.find<HomeController>()
                                    .getBlogDetailsData(
                                        slug: item[index].slug ?? "");
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
