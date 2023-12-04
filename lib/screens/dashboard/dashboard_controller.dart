import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllOrganizationModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/CreateSalesOrderModel.dart';
import 'package:erp/Model/RequestModel/invioce_model/Invoice.dart';
import 'package:erp/Model/StockQty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController with StateMixin {
  Rx<List<GetAllOrganization>?> getOrganizationList =
      (null as List<GetAllOrganization>?).obs;

  RxBool isLoading = false.obs;

  Rx<List<Invoice>?> getAllInvoiceList = (null as List<Invoice>?).obs;
  Rx<List<StockQty>?> getAllStockQtyList = (null as List<StockQty>?).obs;

  // Rx<List<SalesOrder>?> getSalesOrderList = (null as List<SalesOrder>?).obs;
  List<SalesOrder> getSalesOrderList = [];

  LoginUserModel? loginUserModel;

  organizationListGet() async {
    isLoading.value = true;
    await NetworkManager.get(url: HttpUrl.getOrganization, parameters: {})
        .then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getOrganizationList.value =
              (apiResponse.apiResponseModel!.data as List)
                  .map((e) => GetAllOrganization.fromJson(e))
                  .toList();
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel!.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  getAllInvoice() async {
    isLoading.value = true;

    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getInvoice,
      parameters: {
        'OrganizationId': "${loginUserModel?.orgId}",
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getAllInvoiceList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => Invoice.fromJson(e))
              .toList();
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

  getOrderList() async {
    isLoading.value = true;
    loginUserModel = await PreferenceHelper.getUserData();
    NetworkManager.get(url: HttpUrl.getSalesOrder, parameters: {
      'OrganizationId': '${loginUserModel?.orgId}',
    }).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            getSalesOrderList = (response.apiResponseModel!.data as List)
                .map((e) => SalesOrder.fromJson(e))
                .toList();
            change(getSalesOrderList);
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: response.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }).catchError(
      (error) {
        change(null, status: RxStatus.error());
        Get.showSnackbar(
          GetSnackBar(
            title: "ee",
            message: error.toString(),
            icon: const Icon(Icons.error),
            duration: const Duration(seconds: 3),
          ),
        );
      },
    );
  }

  getAllStock() async {
    loginUserModel = await PreferenceHelper.getUserData();
    isLoading.value = true;
    NetworkManager.get(
      url: HttpUrl.getProductStock,
      parameters: {
        'OrganizationId': "${loginUserModel?.orgId}",
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          getAllStockQtyList.value =
              (apiResponse.apiResponseModel!.result as List)
                  .map((e) => StockQty.fromJson(e))
                  .toList();
          change(getAllStockQtyList.value);
          change(null, status: RxStatus.success());
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
}
