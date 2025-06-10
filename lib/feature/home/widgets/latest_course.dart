import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/components/course_view_verticle.dart';
import 'package:anycallmobile_trainingcenter/components/paginated_list_view.dart';
import 'package:anycallmobile_trainingcenter/core/helper/help_me.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/styles.dart';

import '../../../controller/home_controller.dart';

class LatestCourseWidget extends GetView<HomeController> {
  final ScrollController scrollController;
  const LatestCourseWidget(this.scrollController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Text(
            'latest_courses'.tr,
            style:
                robotoSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),
          ),
        ),
        PaginatedListView(
          scrollController: scrollController,
          totalSize: 10,
          offset: 1,
          onPaginate: (int offset) {
            printLog("---pagination for latests course: offset=$offset");
            return controller.getLatestCourseList();
          },
          itemView: ServiceViewVertical(
            service: controller.latestCourseList!,
          ),
        ),
      ],
    );
  }
}
