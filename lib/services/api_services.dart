import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:anycallmobile_trainingcenter/core/helper/route_helper.dart';
import 'package:anycallmobile_trainingcenter/data/model/common_model/common_data_model.dart';
import 'package:anycallmobile_trainingcenter/utils/constant/environment.dart';
import 'package:anycallmobile_trainingcenter/utils/string.dart';
import 'package:anycallmobile_trainingcenter/utils/utility_function.dart';

class ApiServices {
  CommonDM convertToCommonObject(apiResponse) {
    return CommonDM.fromJson(apiResponse);
  }

  void timeOutFunction() {
    String error = ksConnectionTimeoutMessage;
    if (!Get.isSnackbarOpen) {
      // showSnackBar(title: ksError, message: error, color: cRedColor);
      ll(error);
    }
  }

  Future<http.Response> methodBasedResponse({
    required String method,
    required String? token,
    Map<String, dynamic>? body,
    required Uri uri,
    int? timer,
    required http.Client client,
  }) async {
    if (method == get) {
      return await client.get(
        uri,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          // 'apiKey': 'spagreen_',
          // 'base_url': 'https://facultytest.spagreen.net',
          'apiKey': 'spagreen_',
          // 'token': 'https://facultytest.spagreen.net',

          // "Content-Type": "multipart/form-data",
        },
      ).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          timeOutFunction();
          throw TimeoutException(ksConnectionTimeoutMessage.tr);
        },
      );
    } else if (method == post) {
      return await client.post(
        uri,
        body: body,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'apiKey': 'spagreen_',
          // 'token': 'https://facultytest.spagreen.net',
          // "Content-Type": "multipart/form-data",
        },
      ).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          timeOutFunction();
          throw TimeoutException(ksConnectionTimeoutMessage.tr);
        },
      );
    } else if (method == put) {
      return await client.post(
        uri,
        body: body,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          timeOutFunction();
          throw TimeoutException(ksConnectionTimeoutMessage.tr);
        },
      );
    } else {
      return await client.delete(
        uri,
        body: body,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          timeOutFunction();
          throw TimeoutException(ksConnectionTimeoutMessage.tr);
        },
      );
    }
  }

  //* Common Api call
  Future<dynamic> commonApiCall({
    String? token,
    required String url,
    Map<String, dynamic>? body,
    required String requestMethod,
    int? timer,
  }) async {
    ll("Url : $url");
    final http.Client client = http.Client();
    final Uri uri = Uri.parse(Environment.apiUrl + url);
    ll("uri : $uri");
    ll('body: $body');
    http.Response response;
    String error = ksSomethingWentWrong.tr;

    try {
      response = await methodBasedResponse(
        method: requestMethod,
        token: token,
        body: body,
        uri: uri,
        timer: timer,
        client: client,
      );
      ll("response statusCode : ${response.statusCode}");
      if (response.statusCode == 200) {
        final object = json.decode(response.body.toString());
        final prettyString = const JsonEncoder.withIndent('  ').convert(object);
        ll("Response : $prettyString");
        CommonDM cm = convertToCommonObject(jsonDecode(response.body));
        return cm;
        // return jsonDecode(response.body);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // await SpController().onLogout();
        // Get.offAllNamed(krHome);
        // showSnackBar(title: ksError.tr, message: ksUnAuthorizedError.tr, color: cRedColor);
        return null;
      } else {
        if (!Get.isSnackbarOpen) {
          // showSnackBar(title: "${response.statusCode} ${ksError.tr}", message: error, color: cRedColor);
        }
        return null;
      }
    } on SocketException {
      error = ksNoInternetConnectionMessage.tr;
      if (!Get.isSnackbarOpen) {
        // showSnackBar(title: ksError.tr, message: error, color: cRedColor);
      }
      return null;
    } catch (e) {
      ll(e.toString());
      if (!Get.isSnackbarOpen) {
        // showSnackBar(title: ksError.tr, message: error, color: cRedColor);
      }
      return null;
    } finally {
      client.close();
    }
  }

  // dio post type of request
  // Future<dynamic> commonPostDio({
  //   required String url,
  //   required String? token,
  //   required body,
  //   int? timer,
  // }) async {
  //   ll("Url : $url");
  //   Dio dio = Dio();
  //   dio.options.headers['content-Type'] = 'application/json';
  //   dio.options.headers["authorization"] = "Bearer $token";
  //   String error = ksSomethingWentWrong.tr;
  //   try {
  //     var response = await dio.post(Environment.apiUrl + url, data: body).timeout(Duration(seconds: timer ?? 60), onTimeout: () {
  //       error = ksConnectionTimeoutMessage.tr;
  //       // showSnackBar(title: ksError.tr, message: error, color: cRedColor);
  //       throw TimeoutException(ksConnectionTimeoutMessage.tr);
  //     });
  //     ll("response statusCode : ${response.statusCode}");
  //     if (response.statusCode == 200) {
  //       final object = json.decode(response.toString());
  //       final prettyString = const JsonEncoder.withIndent('  ').convert(object);
  //       ll("Response : $prettyString");
  //       CommonDM cm = convertToCommonObject(response.data);
  //       return cm;
  //     } else if (response.statusCode == 401 || response.statusCode == 403) {
  //       // await SpController().onLogout();
  //       // Get.offAllNamed(krHome);
  //       // showSnackBar(title: ksError.tr, message: ksUnAuthorizedError.tr, color: cRedColor);
  //       return null;
  //     } else {
  //       if (!Get.isSnackbarOpen) {
  //         // showSnackBar(title: "${ksError.tr}${response.statusCode}", message: error, color: cRedColor);
  //       }
  //       return null;
  //     }
  //   } on DioException catch (e) {
  //     if (e.error is SocketException) {
  //       error = ksNoInternetConnectionMessage.tr;
  //       // showSnackBar(title: ksError.tr, message: error, color: cRedColor);

  //       return null;
  //     } else {
  //       ll(e.toString());
  //       // showSnackBar(title: ksError.tr, message: error, color: cRedColor);
  //       return null;
  //     }
  //   } finally {
  //     dio.close();
  //   }
  // }
}
