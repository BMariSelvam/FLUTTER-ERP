import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferenceHelper.dart';
import 'package:erp/Model/GetAllCurrencyModel.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/screens/locator/cart_service.dart';
import 'package:erp/screens/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController with StateMixin {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerCodeController = TextEditingController();
  TextEditingController customerAddressLine1Controller =
      TextEditingController();
  TextEditingController customerAddressLine2Controller =
      TextEditingController();
  TextEditingController customerAddressLine3Controller =
      TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController deliveryDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController creditLimitController = TextEditingController();
  TextEditingController outstandingController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime delSelectedDate = DateTime.now();

  String? date;
  String? delDate;

  RxBool isLoading = false.obs;

  LoginUserModel? loginUserModel;

  GetCustomerModel? getCustomerModel;

  GetAllCurrencyModel? getAllCurrencyModel;

  GetCustomerModel? getCustomerByCodeModel;

  String customer = "";
  String currency = "";
  String currencyId = "";

  Rx<List<GetCustomerModel>?> getCustomerList =
      (null as List<GetCustomerModel>?).obs;

  Rx<List<GetCustomerModel>?> getCustomerByCodeList =
      (null as List<GetCustomerModel>?).obs;

  Rx<List<GetAllCurrencyModel>?> getAllCurrencyList =
      (null as List<GetAllCurrencyModel>?).obs;

  List<GetAllCurrencyModel>? curID = [];

  bool isCusSelected = false;

  bool isCurrencySelected = false;

  final ProductListService productService = getIt<ProductListService>();

  Rx<List<GetAllCurrencyModel>?> getByCodeCurrency =
      (null as List<GetAllCurrencyModel>?).obs;

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
                  .map((e) => GetCustomerModel.fromJson(e))
                  .toList();
          isCusSelected = true;
          getCustomerModel = getCustomerByCodeList.value?.first;
          getAllCurrencyModel = getAllCurrencyList.value?.first;
          customerNameController.text =
              getCustomerByCodeList.value?.first.name ?? "";
          customerCodeController.text =
              getCustomerByCodeList.value?.first.code ?? "";
          customerAddressLine1Controller.text =
              getCustomerByCodeList.value?.first.addressLine1 ?? "";
          customerAddressLine2Controller.text =
              getCustomerByCodeList.value?.first.addressLine2 ?? "";
          customerAddressLine3Controller.text =
              getCustomerByCodeList.value?.first.addressLine3 ?? "";
          countryController.text =
              getCustomerByCodeList.value?.first.countryName ?? "";

          currencyId =
              await getCustomerByCodeList.value?.first.currencyId ?? "";
          print('currencyId');
          print(currencyId);
          print('currencyId');
          await getCurrencyByCode(currencyId);
          await getAllCurrency();

          postCodeController.text =
              getCustomerByCodeList.value?.first.postalCode ?? "";
          creditLimitController.text =
              (getCustomerByCodeList.value?.first.creditLimit ?? 0.00)
                  .toString();
          outstandingController.text =
              (getCustomerByCodeList.value?.first.outstandingAmount ?? 0.00)
                  .toString();
          delDate = selectedDate.toString();
          delDate = delSelectedDate.toString();

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

  getAllCurrency() async {
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
          getAllCurrencyList.value =
              (apiResponse.apiResponseModel!.data as List)
                  .map((e) => GetAllCurrencyModel.fromJson(e))
                  .toList();
          curID = getAllCurrencyList.value
              ?.where((element) =>
                  element.code == getByCodeCurrency.value?.first.code)
              .toList();
          print(curID);
          print("Currency ID");
          change(null, status: RxStatus.success());
          print("getAllCurrencyList.length");
          print(getAllCurrencyList.value?.length);
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

  getCurrencyByCode(code) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getCurrencyByCode,
      parameters: {
        'OrganizationId': "${loginUserModel?.orgId}",
        'CurrencyCode': '$code'
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getByCodeCurrency.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetAllCurrencyModel.fromJson(e))
              .toList();
          print("getAllCurrencyList.length");
          print(getByCodeCurrency.value?.length);
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
