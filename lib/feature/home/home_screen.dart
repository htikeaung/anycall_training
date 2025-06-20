import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/loading_indicator.dart';
import 'package:anycallmobile_trainingcenter/controller/home_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:anycallmobile_trainingcenter/data/model/home_data_model/home_data.dart';
import 'package:anycallmobile_trainingcenter/feature/common/course_instructor.dart';
import 'package:anycallmobile_trainingcenter/feature/common/course_widget.dart';
import 'package:anycallmobile_trainingcenter/feature/common/my_blog_list_widget.dart';
import 'package:anycallmobile_trainingcenter/feature/home/widgets/home_app_bar.dart';
import 'package:anycallmobile_trainingcenter/feature/home/widgets/my_course_widget.dart';
import 'package:anycallmobile_trainingcenter/feature/home/widgets/top_courses_widget.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../core/helper/responsive_helper.dart';
import '../../utils/styles.dart';
import '../common/explore_by_category.dart';
import '../common/featured_courses_widget.dart';
import '../common/offer_courses.dart';
import 'widgets/banner_view.dart';

class HomeScreen extends StatefulWidget {
  final Function() callback;
  const HomeScreen({Key? key, required this.callback}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Get.find<HomeController>().paginate();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        backButton: false,
      ),
      body: SafeArea(
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return controller.isLoading == true
                ? const LoadingIndicator()
                : mainUI(controller, context);
          },
        ),
      ),
    );
  }

  Widget mainUI(HomeController controller, BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          if (controller.homeModel != null)
            SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.homeModel?.data?.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        //top: Dimensions.paddingSizeExtraLarge,
                        //bottom: Dimensions.paddingSizeExtraLarge,
                        ),
                    child: itemBuilderByCategory(
                      context,
                      index,
                      controller.homeModel!.data!,
                    ),
                  );
                },
              ),
            ),
          if (controller.latestCourseList!.isNotEmpty)
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // 'latest_courses'.tr,
                          "Courses",
                          style: robotoSemiBold.copyWith(
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                        InkWell(
                          onTap: () async {
                            Get.toNamed(RouteHelper.allCoursesScreen);
                            await Get.find<HomeController>()
                                .getAllCoursesList();
                          },
                          child: Text(
                            'view_all'.tr,
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeExtraSmall,
                                color: Get.isDarkMode
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color
                                    : Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: Dimensions.paddingSizeDefault,
                        mainAxisSpacing: Dimensions.paddingSizeDefault,
                        childAspectRatio:
                            ResponsiveHelper.isTab(context) ? .9 : .63,
                        mainAxisExtent:
                            ResponsiveHelper.isMobile(context) ? 225 : 260,
                        crossAxisCount: controller.latestCourseList!.length > 2
                            ? 2
                            : controller.latestCourseList!.length,
                      ),
                      itemCount: controller.latestCourseList?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return CourseWidget(
                            course: controller.latestCourseList![index]);
                      },
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  if (controller.isLoadingMoreData == true)
                    const Padding(
                      padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Center(child: LoadingIndicator()),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget itemBuilderByCategory(
      BuildContext context, int index, List<HomeData> data) {
    switch (data[index].sectionType) {
      case "sliders":
        return BannerView(bannerIndex: index);
      case 'my_courses':
        return data[index].myCourses!.isNotEmpty
            ? MyCourseWidget(
                myCourseList: data[index].myCourses, callback: widget.callback)
            : const SizedBox();
      case 'categories':
        return data[index].categories!.isNotEmpty
            ? ExploreByCategoryWidget(
                title: 'categories', categoryList: data[index].categories!)
            : const SizedBox();
      case 'top_courses':
        return TopCourseWidget(list: data[index].topCourses!);
      case 'instructors':
        return CourseInstructor(
            title: 'instructor', instructors: data[index].instructors!);
      case 'offer_courses':
        return OfferCourses(offeredCourses: data[index].offerCourses!);
      case 'featured_courses':
        return data[index].featuredCourses!.isNotEmpty
            ? FeaturedCourse(courseList: data[index].featuredCourses!)
            : const SizedBox();
      case 'blog':
        return data[index].myBlog!.isNotEmpty
            ? MyBlogListWidget(
                blogList: data[index].myBlog!,
              )
            : const SizedBox();
      // case 'blog':
      //   return const SizedBox();
      default:
        return const SizedBox();
    }
  }
}
