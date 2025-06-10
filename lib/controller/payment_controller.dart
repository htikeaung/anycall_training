import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/controller/splash_controller.dart';
import '../config.dart';
import '../data/provider/client_api.dart';

class PaymentController extends GetxController implements GetxService {
  final ApiClient apiClient;
  PaymentController(this.apiClient);

  bool isLoading = true;
  bool isPaymentSuccess = false;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false),
    android: AndroidInAppWebViewOptions(useHybridComposition: true),
    ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
  );

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "https://www.linkedin.com/";
  double progress = 0;
  final urlController = TextEditingController();
  bool showButton = false;
  String langCode = "en";
  String currencyCode = "USD";

  @override
  void onInit() {
    super.onInit();
    langCode = "en";
    currencyCode = "USD";
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {},
        onHideContextMenu: () {},
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {});

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.purple,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  // URLRequest makePaymentRequest() {
  //   final appConfig = Get.find<SplashController>().configModel.data!.appConfig.defaultCurrency;

  //   return URLRequest(
  //       url: Uri.parse(
  //         "${Config.baseUrl}user/make-payment?currency_code=$appConfig",
  //       ),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         AppConstants.localizationKey: AppConstants.languages[0].languageCode!,
  //         'Authorization': 'Bearer ${apiClient.token}'
  //       });
  // }

  // URLRequest makePaymentRequest() {
  //   final appConfig = Get.find<SplashController>().configModel.data!.appConfig.defaultCurrency;

  //   return URLRequest(
  //       url: Uri.parse(
  //         "${Config.baseUrl}user/make-payment?currency_code=$appConfig",
  //       ),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         AppConstants.localizationKey: AppConstants.languages[0].languageCode!,
  //         'Authorization': 'Bearer ${apiClient.token}'
  //       });
  // }
  //!Changes
  URLRequest makePaymentRequest() {
    final appConfig = Get.find<SplashController>()
        .configModel
        .data!
        .appConfig
        .defaultCurrency;

    final webUri = WebUri(
      "${Config.baseUrl}user/make-payment?currency_code=$appConfig&payment_mode=api&token=${apiClient.token}", //!cahnge here - add this -> &payment_mode=api
    );

    return URLRequest(
      url: webUri,
      headers: {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'apiKey': 'spagreen_',
        // AppConstants.localizationKey: AppConstants.languages[0].languageCode!,
        'Authorization': 'Bearer ${apiClient.token}',
      },
    );
  }

  Uri successUri() {
    return Uri.parse("${Config.baseUrl}/complete-order");
  }

  progressUpdate(value) {
    progress = value;
    update();
  }

  isLoadingUpdate(value) {
    isLoading = value;
    update();
  }

  isPaymentSuccessUpdate(value) {
    isPaymentSuccess = value;
    update();
  }

  showButtonUpdate(value) {
    showButton = value;
    update();
  }
}
