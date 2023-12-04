import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Model/RequestModel/CreateBankModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddBankController extends GetxController with StateMixin {
  RxBool isPasswordVisible = false.obs;
  String? messages;

  late CreateBankModel createBankModel;
  String currentTimeAndDate = "";

  final addBankKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  bool selected = false;
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
    await NetworkManager.post(
            URl: HttpUrl.postAddBank, params: createBankModel.toJson())
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null &&
            (apiResponse.apiResponseModel!.data).isNotEmpty) {
          change(null, status: RxStatus.success());
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.data!).first;
          if (customerJson != null) {
            Get.toNamed(AppRoutes.bottomNavBarScreen);
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
