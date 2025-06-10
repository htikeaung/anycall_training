import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/loading_indicator.dart';
import 'package:anycallmobile_trainingcenter/controller/home_controller.dart';
import 'package:anycallmobile_trainingcenter/core/helper/responsive_helper.dart';
import 'package:anycallmobile_trainingcenter/feature/common/all_courses_widget.dart';
import 'package:anycallmobile_trainingcenter/utils/colors.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/widgets/custom_appbar.dart';

class AllCoursesScreen extends StatelessWidget {
  AllCoursesScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.00),
        //* info:: appBar
        child: CustomAppBar(
          appBarColor: cWhiteColor,
          title: "All Courses".tr,
          hasBackButton: true,
          isCenterTitle: true,
          onBack: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => homeController.isAllCoursesListLoading.value
            ? const LoadingIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
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
                          crossAxisCount: ResponsiveHelper.isMobile(context)
                              ? 2
                              : ResponsiveHelper.isTab(context)
                                  ? 3
                                  : 5,
                        ),
                        itemCount: homeController.allCoursesList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return AllCoursesWidget(
                            course: homeController.allCoursesList[index],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
      ),
    );
  }
}
