import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/preferenceHelper.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/CreateReceiptModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiptPrintPreviewController extends GetxController with StateMixin {
  Rx<bool> getReceiptListCodeModelIsLoading = false.obs;

  LoginUserModel? loginUser;

  Rx<List<Receipt>?> receiptListCodeModel = (null as List<Receipt>?).obs;

  getReceiptListCode(tranNo) async {
    getReceiptListCodeModelIsLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    NetworkManager.get(
      url: HttpUrl.getReceiptByCode,
      parameters: {
        "OrganizationId": "${loginUser?.orgId}",
        "TranNo": "$tranNo",
      },
    ).then((apiResponse) {
      getReceiptListCodeModelIsLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            receiptListCodeModel.value =
                (apiResponse.apiResponseModel!.data as List)
                    .map((e) => Receipt.fromJson(e))
                    .toList();
            print(receiptListCodeModel);
            print(" receiptListCodeModel+++++++++++++++");
            change(receiptListCodeModel);
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.snackbar(
        "Attention",
        "Error",
        margin: const EdgeInsets.all(20),
        backgroundColor: MyColors.red,
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
      // PreferenceHelper.showSnackBar(context: Get.context!, msg: error);
    });
  }
}
