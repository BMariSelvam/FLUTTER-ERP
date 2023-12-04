import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/preferenceHelper.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/invioce_model/Invoice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoicePrintPreviewController extends GetxController with StateMixin {
  Rx<bool> getOrderInvoiceListCodeModelIsLoading = false.obs;

  LoginUserModel? loginUser;

  Rx<List<Invoice>?> invoiceListCodeModel = (null as List<Invoice>?).obs;

  getInvoiceListCode(tranNo) async {
    getOrderInvoiceListCodeModelIsLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    NetworkManager.get(
      url: HttpUrl.getInvoiceByCode,
      parameters: {
        "OrganizationId": "${loginUser?.orgId}",
        "TranNo": "$tranNo",
      },
    ).then((apiResponse) {
      getOrderInvoiceListCodeModelIsLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            invoiceListCodeModel.value =
                (apiResponse.apiResponseModel!.data as List)
                    .map((e) => Invoice.fromJson(e))
                    .toList();
            print(invoiceListCodeModel.value);
            print("invoiceListCodeModel+++++++++++++++");
            change(invoiceListCodeModel.value);
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
