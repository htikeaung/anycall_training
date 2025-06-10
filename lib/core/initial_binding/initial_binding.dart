import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/controller/assignment_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/auth_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/book_detail_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/book_store_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/cart_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/category_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/certificate_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/chat_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/classroom_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/course_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/course_detail_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/learning_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/localization_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/meeting_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/my_course_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/explore_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/home_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/html_view_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/language_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/new/new_meeting_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/new/new_quiz_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/notification_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/on_board_pager_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/order_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/payment_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/resource_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/search_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/splash_controller.dart';
import 'package:anycallmobile_trainingcenter/controller/theme_controller.dart';
import 'package:anycallmobile_trainingcenter/repository/auth_repo.dart';
import 'package:anycallmobile_trainingcenter/repository/my_course_repository.dart';
import 'package:anycallmobile_trainingcenter/repository/notification_repo.dart';
import 'package:anycallmobile_trainingcenter/repository/on_board_repository.dart';
import 'package:anycallmobile_trainingcenter/repository/search_repo.dart';
import 'package:anycallmobile_trainingcenter/repository/splash_repo.dart';
import '../../controller/coupon_controller.dart';
import '../../controller/instructor_controller.dart';
import '../../controller/my_audio_player_controller.dart';
import '../../controller/organization_controller.dart';
import '../../controller/quiz_controller.dart';
import '../../controller/video_player_controller.dart';
import '../../controller/wishlist_controller.dart';
import '../../repository/course_detail_repo.dart';
import '../../repository/explore_repository.dart';
import '../../repository/home_repository.dart';
import '../../repository/instructor_repository.dart';
import '../../repository/organization_repository.dart';
import '../../repository/quiz_repository.dart';
import '../../repository/wish_list_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    //common controller
    Get.lazyPut(() => SplashController(
        splashRepo:
            SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => AuthController(
        authRepo:
            AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
    Get.lazyPut(() => NotificationController(
        notificationRepo: NotificationRepo(
            apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() =>
        HomeController(homeRepository: HomeRepository(apiClient: Get.find())));
    Get.lazyPut(() => SearchController(
        searchRepo:
            SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => PaymentController(Get.find()));
    Get.lazyPut(() => OnBoardController(
        repository: OnBoardRepository(apiClient: Get.find())));
    Get.lazyPut(() => BookStoreController());
    Get.lazyPut(() => BookDetailController());
    //Get.lazyPut(() => ConversationController(
    //    conversationRepo: ConversationRepo(apiClient: Get.find())));
    Get.lazyPut(() => ExploreController(
        exploreRepository: ExploreRepository(apiClient: Get.find())));
    Get.lazyPut(() => CourseDetailController(
        courseDetailsRepository:
            CourseDetailsRepository(apiClient: Get.find())));
    Get.lazyPut(() => InstructorController(
        repository: InstructorRepository(apiClient: Get.find())));
    Get.lazyPut(() => OrganizationController(
        repository: OrganizationRepository(apiClient: Get.find())));
    Get.lazyPut(() => MyCourseController(
        repository: MyCourseRepository(apiClient: Get.find())));
    Get.lazyPut(() => WishListController(
        repository: WishListRepository(apiClient: Get.find())));
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => CouponController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => CourseController());
    // Get.lazyPut(() => CertificateController());
    Get.lazyPut(() => LearningController());
    Get.lazyPut(() => LocalizationController(
        sharedPreferences: Get.find(), apiClient: Get.find()));
    Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
    Get.lazyPut(() => ClassroomController());
    Get.lazyPut(() => MyVideoPlayerController());
    Get.lazyPut(() => MyAudioPlayerController());
    Get.lazyPut(() => MeetingController());
    Get.lazyPut(() => AssignmentController());
    Get.lazyPut(
        () => QuizController(quizRepo: QuizRepository(apiClient: Get.find())));
    Get.lazyPut(() => HtmlViewController(
        splashRepo:
            SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => ResourceController());
    Get.put<NewMeetingController>(NewMeetingController());
    Get.put<NewQuizController>(NewQuizController());
    Get.put<CertificateController>(CertificateController());
  }
}
