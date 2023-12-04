import 'dart:convert';

import 'package:erp/Helper/preferencehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'apiresponsemodel.dart';

class NetworkManager {
  static Map<String, String> headers = {'Content-Type': 'application/json'};

  static Future<ApiResponse> get(
      {required String url, required Map<String, dynamic> parameters}) async {
    var uri = Uri.parse(url);
    print("+++++++++++url: $url");
    if (parameters != null) {
      // parameters["OrganizationId"] = "1";
      print("+++++++++++params: $parameters");
      uri = Uri.http(uri.authority, uri.path, parameters);
    }
    var response = await http.get(uri);
    return _handleResponse(response);
  }

  static Future<ApiResponse> post(
      {required String URl, required Map<String, dynamic>? params}) async {
    final url = Uri.parse(URl);
    print("+++++++++++url: $url");
    print("+++++++++++params: $params");
    final response = await http.post(url,
        body: json.encode(params),
        headers: {"Content-Type": "application/json"});
    return _handleResponse(response);
  }

  static Future<ApiResponse> put(String path,
      {Map<String, String>? headers, dynamic body}) async {
    final url = Uri.parse('$path');
    final response =
        await http.put(url, headers: headers, body: json.encode(body));
    return _handleResponse(response);
  }

  static Future<ApiResponse> delete(String path,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$path');
    final response = await http.delete(url, headers: headers);
    return _handleResponse(response);
  }

  static Future<ApiResponse> _handleResponse(http.Response response) async {
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      var data = json.decode(response.body);
      print(data);

      if (data != null && data is Map<String, dynamic>) {
        return ApiResponse(
            apiResponseModel: ApiResponseModel.fromJson(data), error: null);
      } else {
        PreferenceHelper.log("******Response Error*****");
        PreferenceHelper.log(data);
        return ApiResponse(apiResponseModel: null, error: "Response Error");
      }
    } else {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: statusCode.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
      throw Exception('Error: $statusCode');
    }
  }
}

class ApiResponse {
  ApiResponseModel? apiResponseModel;
  String? error;

  ApiResponse({required this.apiResponseModel, required this.error});
}
