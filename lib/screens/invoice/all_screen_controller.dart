import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/invioce_model/Invoice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllScreenController extends GetxController with StateMixin {
  TextEditingController fromDatecontroller = TextEditingController();
  TextEditingController toDatecontroller = TextEditingController();
  TextEditingController customerCodecontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  bool isSelectedFilter = true;

  RxBool isLoading = false.obs;

  Rx<bool> getOrderCustomerListIsLoading = false.obs;
  Rx<List<Invoice>?> getAllInvoiceList = (null as List<Invoice>?).obs;
  DateTime selectedDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  GetCustomerModel? customerList;
  Rx<List<GetCustomerModel>?> customerListModel =
      (null as List<GetCustomerModel>?).obs;
  String? customerName;
  String? companyBranch;
  String date = "";
  String toDate = "";
  LoginUserModel? loginUserModel;
  bool isSearchFilter = false;
  Rx<bool> getOrderSearchListIsLoading = false.obs;
  getInvoiceCodeList(
      {customerCode,
      searchFromDate,
      searchToDate,
      required bool isSearch}) async {
    if (isSearch == false) {
      getOrderSearchListIsLoading.value = true;
    }
    if (isSearch == true) {
      isSearchFilter = true;
    }
    companyBranch = await PreferenceHelper.getBanchCodeString();
    loginUserModel = await PreferenceHelper.getUserData();

    NetworkManager.get(
      url: HttpUrl.getInvoiceHeaderSearch,
      parameters: {
        "searchModel.organisationId": "${loginUserModel?.orgId}",
        "searchModel.customerCode": "$customerCode" ?? "",
        "searchModel.fromdate": "$searchFromDate",
        "searchModel.todate": "$searchToDate",
        // "searchModel.status": 0,
      },
    ).then((apiResponse) {
      if (isSearch == false) {
        getOrderSearchListIsLoading.value = false;
      }
      if (isSearch == true) {
        isSearchFilter = false;
      }

      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          print(apiResponse.apiResponseModel!.data!);
          if (resJson != null) {
            print(apiResponse.apiResponseModel!.data!);
            print("--------------");
            getAllInvoiceList.value =
                (apiResponse.apiResponseModel!.data as List)
                    .map((e) => Invoice.fromJson(e))
                    .toList();
            print(getAllInvoiceList.value);
            print("getAllInvoiceList+++++++++++++++");
            change(getAllInvoiceList.value);
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
    }).catchError((error) {
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
    });
  }

  getOrderCustomerList() async {
    getOrderCustomerListIsLoading.value = true;
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getAllCustomerSearch,
      parameters: {
        "OrganizationId": "${loginUserModel?.orgId}",
        // "CustomerName": "$customerName",
      },
    ).then((apiResponse) {
      getOrderCustomerListIsLoading.value = false;
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

  clearData() {
    customerList = null;
    customerCodecontroller.clear();
    toDatecontroller.clear();
    fromDatecontroller.clear();
    searchcontroller.clear();
  }
}
