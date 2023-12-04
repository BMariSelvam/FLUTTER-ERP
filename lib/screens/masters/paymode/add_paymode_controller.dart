import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Model/RequestModel/CreatePaymodeModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPaymodeController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  String? messages;
  final addPaymodeKey = GlobalKey<FormState>();
  late CreatePaymodeModel createPaymodeModel;
  bool selected = true;
  bool isPos = false;
  bool isB2B = false;
  bool isB2C = false;
  bool isERP = false;
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String currentTimeAndDate = "";

  @override
  void onInit() async {
    super.onInit();
    dateAndTimePicker();
  }

  dateAndTimePicker() {
    DateTime now = DateTime.now();
    print(now);
    String formattedDate = formatDate(now);
    currentTimeAndDate = formattedDate;
    print(currentTimeAndDate);
  }

  String formatDate(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
    return formatter.format(dateTime);
  }

  onSaved() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.post(
            URl: HttpUrl.postAddPaymode, params: createPaymodeModel.toJson())
        .then((apiResponse) {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null &&
            (apiResponse.apiResponseModel!.data).isNotEmpty) {
          change(null, status: RxStatus.success());
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.data as List).first;
          if (customerJson != null) {
            print(apiResponse.apiResponseModel!.data);
          } else {
            change(null, status: RxStatus.error());
            Get.snackbar(
              "Error",
              colorText: MyColors.white,
              "Customer data is empty!",
              margin: const EdgeInsets.all(20),
              backgroundColor: MyColors.red,
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
              snackPosition: SnackPosition.TOP,
            );
          }
        }
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message.toString();
        message = messages;
        print("API Response Message (Error): $message");
        Get.snackbar(
          margin: const EdgeInsets.all(20),
          backgroundColor: MyColors.red,
          "Attention",
          message ?? "Your Username or Password are Incorrect",
          icon: const Icon(Icons.emergency),
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }
}
