import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/controller/on_board_pager_controller.dart';
import 'package:anycallmobile_trainingcenter/repository/on_board_repository.dart';

class OnBoardBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => OnBoardController(
        repository: OnBoardRepository(apiClient: Get.find())));
  }
}
