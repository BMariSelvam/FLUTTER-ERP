import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/CreateReceiptModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiptListController extends GetxController with StateMixin {
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController fromDatecontroller = TextEditingController();
  TextEditingController toDatecontroller = TextEditingController();
  TextEditingController customerCodecontroller = TextEditingController();
  RxBool isLoading = false.obs;
  Rx<List<Receipt>?> getReceiptList = (null as List<Receipt>?).obs;
  bool isSearchFilter = false;
  LoginUserModel? loginUserModel;
  String? companyBranch;
  bool isSelectedFilter = true;
  GetCustomerModel? customerList;
  Rx<List<GetCustomerModel>?> customerListModel =
      (null as List<GetCustomerModel>?).obs;
  DateTime selectedDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  String? customerName;
  String date = "";
  String toDate = "";

  getReceiptCustomerList(customerName) async {
    isLoading.value = true;
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getAllCustomerSearch,
      parameters: {
        "OrganizationId": "${loginUserModel?.orgId}",
        "CustomerName": "$customerName",
      },
    ).then((apiResponse) {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            customerListModel.value =
                (apiResponse.apiResponseModel!.data as List)
                    .map((e) => GetCustomerModel.fromJson(e))
                    .toList();
            print(customerListModel);
            print("customerListModel+++++++++++++++");
            change(customerListModel);
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

  receiptListGet(
      {customerCode,
      searchFromDate,
      searchToDate,
      required bool isSearch}) async {
    if (isSearch == false) {
      isLoading.value = true;
    }
    if (isSearch == true) {
      isSearchFilter = true;
    }
    companyBranch = await PreferenceHelper.getBanchCodeString();
    loginUserModel = await PreferenceHelper.getUserData();
    NetworkManager.get(
      url: HttpUrl.getReceiptHeaderSearch,
      parameters: {
        "searchModel.organisationId": "${loginUserModel?.orgId}",
        "searchModel.customerCode": "$customerCode",
        "searchModel.fromdate": "$searchFromDate",
        "searchModel.todate": "$searchToDate",
        // "searchModel.status": 0,
      },
    ).then(
      (apiResponse) {
        if (isSearch == false) {
          isLoading.value = false;
        }
        if (isSearch == true) {
          isSearchFilter = false;
        }
        if (apiResponse.apiResponseModel != null &&
            apiResponse.apiResponseModel!.status) {
          if (apiResponse.apiResponseModel!.data != null) {
            List? resJson = apiResponse.apiResponseModel!.data!;
            if (resJson != null) {
              getReceiptList.value =
                  (apiResponse.apiResponseModel!.data as List)
                      .map((e) => Receipt.fromJson(e))
                      .toList();
              change(getReceiptList.value);
            }
            change(null, status: RxStatus.success());
          } else {
            change(null, status: RxStatus.error());
            String? message = apiResponse.apiResponseModel?.message;
            PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
          }
        } else {
          isSearchFilter = false;
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      },
    ).catchError(
      (error) {
        change(null, status: RxStatus.error());
        Get.snackbar(
          "Attention",
          "msg",
          margin: const EdgeInsets.all(20),
          backgroundColor: MyColors.red,
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
        );
      },
    );
  }

  getReceiptDeleteList(transNo) async {
    isLoading.value = true;
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getReceiptRemove,
      parameters: {
        "OrganizationId": "${loginUserModel?.orgId}",
        "TranNo": "$transNo",
      },
    ).then(
      (apiResponse) async {
        isLoading.value = false;
        if (apiResponse.apiResponseModel != null &&
            apiResponse.apiResponseModel!.status) {
          if (apiResponse.apiResponseModel!.data != null &&
              (apiResponse.apiResponseModel!.data).isNotEmpty) {
            change(null, status: RxStatus.success());
            if (apiResponse.apiResponseModel!.data != null) {
              Get.showSnackbar(
                GetSnackBar(
                  margin: const EdgeInsets.all(10),
                  borderRadius: 10,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.TOP,
                  message:
                      "Receipt Successfully Deleted ${apiResponse.apiResponseModel!.data}",
                  icon: const Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
              await receiptListGet(
                  customerCode: "",
                  searchFromDate: "",
                  searchToDate: "",
                  isSearch: false);
            } else {
              change(null, status: RxStatus.error());
              String? message = apiResponse.apiResponseModel!.message;
              PreferenceHelper.showSnackBar(
                  context: Get.context!, msg: message);
            }
          }
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel!.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      },
    ).catchError(
      (error) {
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
      },
    );
  }

  clearData() {
    customerList = null;
    customerCodecontroller.clear();
    toDatecontroller.clear();
    fromDatecontroller.clear();
    searchcontroller.clear();
  }
}
