import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anycallmobile_trainingcenter/controller/certificate_controller.dart';
import 'package:anycallmobile_trainingcenter/utils/colors.dart';
import 'package:anycallmobile_trainingcenter/utils/dimensions.dart';
import 'package:anycallmobile_trainingcenter/utils/styles.dart';
import 'package:anycallmobile_trainingcenter/utils/utility_function.dart';
import 'package:anycallmobile_trainingcenter/widgets/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoView extends StatelessWidget {
  PhotoView({super.key});

  final CertificateController certificateController =
      Get.find<CertificateController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(44),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: Colors.white,
              hasBackButton: true,
              iconColor: Colors.black,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                      onTap: () async {
                        await certificateController.getCertificateDownloadLink(
                            certificateController.certificateShow.value!.id!
                                .toString());
                        try {
                          await launchUrl(
                              Uri.parse(certificateController
                                  .certificateDownloadUrl!),
                              mode: LaunchMode.externalApplication);
                        } catch (e) {
                          Get.showSnackbar(const GetSnackBar(
                            backgroundColor: Colors.red,
                            message: "Can't open link.",
                            maxWidth: 200,
                            duration: Duration(seconds: 3),
                            snackStyle: SnackStyle.FLOATING,
                            margin: EdgeInsets.all(10),
                            borderRadius: 5,
                            isDismissible: true,
                            dismissDirection: DismissDirection.horizontal,
                          ));
                        }
                      },
                      child: const Icon(
                        Icons.download,
                        color: Colors.black,
                        size: 20,
                      )),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        certificateController
                                .certificateShow.value?.certificateBorder ??
                            "",
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 32,
                            ),
                          );
                        },
                        loadingBuilder: imageLoadingBuilder,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.4,
                left: MediaQuery.of(context).size.width * 0.4,
                top: MediaQuery.of(context).size.height * 0.32,
                child: Image.network(
                  certificateController.certificateShow.value?.certificateTop ??
                      "",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.06,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 32,
                      ),
                    );
                  },
                  loadingBuilder: imageLoadingBuilder,
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.35,
                top: MediaQuery.of(context).size.height * 0.385,
                child: Text(
                  certificateController.certificateShow.value?.title ?? "",
                  style:
                      robotoSemiBold.copyWith(fontSize: 8, color: Colors.black),
                ),
              ),
              //  Positioned(
              //    left: MediaQuery.of(context).size.width*0.12,
              //      top: MediaQuery.of(context).size.height*0.42,
              //   child: Text(certificateController.certificateShow.value?.body??"",overflow: TextOverflow.clip, style: robotoRegular.copyWith(fontSize: 4, color: Colors.black),),

              //                ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.12,
                top: MediaQuery.of(context).size.height * 0.41,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.76,
                  child: Text(
                    certificateController.certificateShow.value?.body ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 9,
                    style: robotoRegular.copyWith(
                        fontSize: 6, color: Colors.black.withOpacity(0.9)),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.12,
                bottom: MediaQuery.of(context).size.height * 0.342,
                child: Image.network(
                  certificateController
                          .certificateShow.value?.administratorSignature ??
                      "",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: MediaQuery.of(context).size.height * 0.02,
                  loadingBuilder: imageLoadingBuilder,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 32,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.12,
                bottom: MediaQuery.of(context).size.height * 0.336,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: 0.5,
                  color: Colors.black,
                ),
              ),

              Positioned(
                left: MediaQuery.of(context).size.width * 0.12,
                bottom: MediaQuery.of(context).size.height * 0.323,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: Text(
                      "Administrator Signature",
                      style: robotoSemiBold.copyWith(
                          fontSize: 7, color: Colors.black),
                      textAlign: TextAlign.left,
                    )),
              ),

              Positioned(
                left: MediaQuery.of(context).size.width * 0.4,
                right: MediaQuery.of(context).size.width * 0.4,
                bottom: MediaQuery.of(context).size.height * 0.325,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Container(
                    width: 36,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        certificateController.certificateShow.value?.logo ?? "",
                        width: 36,
                        height: 32,
                        fit: BoxFit.fill,
                        loadingBuilder: imageLoadingBuilder,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 32,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                right: MediaQuery.of(context).size.width * 0.12,
                bottom: MediaQuery.of(context).size.height * 0.342,
                child: Image.network(
                  certificateController
                          .certificateShow.value?.instructorSignature ??
                      "",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: MediaQuery.of(context).size.height * 0.02,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 32,
                      ),
                    );
                  },
                  loadingBuilder: imageLoadingBuilder,
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.12,
                bottom: MediaQuery.of(context).size.height * 0.336,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: 0.5,
                  color: Colors.black,
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.12,
                bottom: MediaQuery.of(context).size.height * 0.323,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    // color: cRedColor,
                    child: Text(
                      "Instructor Signature",
                      style: robotoSemiBold.copyWith(
                          fontSize: 7, color: Colors.black),
                      textAlign: TextAlign.left,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
