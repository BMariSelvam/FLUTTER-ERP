import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllCurrencyModel.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/GetCustomerByCodeModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTabBarController extends GetxController with StateMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController deliveryDateController = TextEditingController();
  TextEditingController creditLimitController = TextEditingController();
  TextEditingController outStandingController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController customerAddressLine1Controller =
      TextEditingController();
  TextEditingController customerAddressLine2Controller =
      TextEditingController();
  TextEditingController customerAddressLine3Controller =
      TextEditingController();

  RxBool isLoading = false.obs;

  DateTime selectedDate = DateTime.now();

  String? date;

  LoginUserModel? loginUserModel;

  GetCustomerModel? getCustomerModel;

  GetAllCurrencyModel? getCurrencyModel;

  String customer = "";

  String currency = "";

  Rx<List<GetAllCurrencyModel>?> getCurrencyList =
      (null as List<GetAllCurrencyModel>?).obs;

  Rx<List<GetCustomerModel>?> getCustomerList =
      (null as List<GetCustomerModel>?).obs;

  Rx<List<GetCustomerByCodeModel>?> getCustomerByCodeList =
      (null as List<GetCustomerByCodeModel>?).obs;

  getAllCustomerList() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getCustomer,
      parameters: {
        'OrganizationId': "${loginUserModel?.orgId}",
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getCustomerList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetCustomerModel.fromJson(e))
              .toList();
          print("getCustomerList.length");
          print(getCustomerList.value?.length);
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

  getAllCurrencyList() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getCurrency,
      parameters: {
        'OrganizationId': "${loginUserModel?.orgId}",
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getCurrencyList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetAllCurrencyModel.fromJson(e))
              .toList();
          print("getCustomerList.length");
          print(getCurrencyList.value?.length);
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

  getAllCustomerByCodeList(code) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getCustomerByCode,
      parameters: {
        'OrganizationId': "${loginUserModel?.orgId}",
        'CustomerCode': "$code",
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getCustomerByCodeList.value =
              (apiResponse.apiResponseModel!.data as List)
                  .map((e) => GetCustomerByCodeModel.fromJson(e))
                  .toList();
          customerNameController.text =
              getCustomerByCodeList.value?.first.name ?? "";
          customerAddressLine1Controller.text =
              getCustomerByCodeList.value?.first.addressLine1 ?? "";
          customerAddressLine2Controller.text =
              getCustomerByCodeList.value?.first.addressLine2 ?? "";
          customerAddressLine3Controller.text =
              getCustomerByCodeList.value?.first.addressLine3 ?? "";
          countryController.text =
              getCustomerByCodeList.value?.first.countryName ?? "";
          currencyController.text =
              getCustomerByCodeList.value?.first.currencyId ?? "";
          getCustomerByCodeList.value?.first.addressLine3 ?? "";
          postCodeController.text =
              getCustomerByCodeList.value?.first.postalCode ?? "";
          countryController.text =
              getCustomerByCodeList.value?.first.countryName ?? "";
          creditLimitController.text =
              (getCustomerByCodeList.value?.first.creditLimit ?? 0.00)
                  .toString();
          outStandingController.text =
              (getCustomerByCodeList.value?.first.outstandingAmount ?? 0.00)
                  .toString();

          print("getCustomerList.length");
          print(getCustomerByCodeList.value?.length);
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
}
