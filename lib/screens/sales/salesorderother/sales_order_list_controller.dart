import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/CreateSalesOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesOrderListController extends GetxController with StateMixin {
  Rx<List<SalesOrder>?> getSalesOrderList = (null as List<SalesOrder>?).obs;
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController fromDatecontroller = TextEditingController();
  TextEditingController toDatecontroller = TextEditingController();
  TextEditingController customerCodecontroller = TextEditingController();
  Rx<List<SalesOrder>?> getSalesOrderByCodeList =
      (null as List<SalesOrder>?).obs;
  LoginUserModel? loginUserModel;
  bool isEdit = false;
  bool isSearchFilter = false;
  Rx<bool> getOrderSearchListIsLoading = false.obs;
  Rx<bool> getOrderCustomerListIsLoading = false.obs;
  RxBool isLoading = false.obs;
  bool isSelectedFilter = true;
  DateTime selectedDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  GetCustomerModel? customerList;
  Rx<List<GetCustomerModel>?> customerListModel =
      (null as List<GetCustomerModel>?).obs;
  String? customerName;
  String? companyBranch;
  String date = "";
  String toDate = "";
  // salesOrderListGet() async {
  //   isLoading.value = true;
  //   loginUserModel = await PreferenceHelper.getUserData();
  //   await NetworkManager.get(
  //     url: HttpUrl.getSalesOrder,
  //     parameters: {
  //       'OrganizationId': '${loginUserModel?.orgId}',
  //     },
  //   ).then((apiResponse) async {
  //     isLoading.value = false;
  //     change(null, status: RxStatus.success());
  //     if (apiResponse.apiResponseModel != null &&
  //         apiResponse.apiResponseModel!.status) {
  //       if (apiResponse.apiResponseModel!.data != null) {
  //         // logic for api call success
  //         List? resJson = apiResponse.apiResponseModel!.data!;
  //         if (resJson != null) {
  //           getSalesOrderList.value =
  //               (apiResponse.apiResponseModel!.data as List)
  //                   .map((e) => SalesOrder.fromJson(e))
  //                   .toList();
  //           change(getSalesOrderList.value);
  //           change(null, status: RxStatus.success());
  //         }
  //       } else {
  //         change(null, status: RxStatus.error());
  //         String? message = apiResponse.apiResponseModel?.message;
  //         PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
  //       }
  //     } else {
  //       change(null, status: RxStatus.error());
  //       PreferenceHelper.showSnackBar(
  //           context: Get.context!, msg: apiResponse.error);
  //     }
  //   });
  // }
  getOrderCustomerList(customerName) async {
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

  getOrderCodeList(
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
      url: HttpUrl.getSalesOrderHeaderSearch,
      parameters: {
        "searchModel.organisationId": "${loginUserModel?.orgId}",
        "searchModel.customerCode": "$customerCode",
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
            getSalesOrderList.value =
                (apiResponse.apiResponseModel!.data as List)
                    .map((e) => SalesOrder.fromJson(e))
                    .toList();
            print(getSalesOrderList.value);
            print("salesOrderCodeListModel+++++++++++++++");
            change(getSalesOrderList.value);
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

  salesOrderListGet() async {
    isLoading.value = true;
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getSalesOrderHeaderSearch,
      parameters: {
        'OrganizationId': '${loginUserModel?.orgId}',
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          // logic for api call success
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            getSalesOrderList.value =
                (apiResponse.apiResponseModel!.data as List)
                    .map((e) => SalesOrder.fromJson(e))
                    .toList();
            change(getSalesOrderList.value);
            change(null, status: RxStatus.success());
          }
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  void handleApiError(error) {
    change(null, status: RxStatus.error());
    Get.showSnackbar(
      GetSnackBar(
        title: "Error",
        message: error.toString(),
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 3),
      ),
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
