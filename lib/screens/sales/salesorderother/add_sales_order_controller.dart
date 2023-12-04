import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllCurrencyModel.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/GetAllProductModel.dart';
import 'package:erp/Model/GetAllTaxModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/CreateSalesOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddSalesOrderController extends GetxController with StateMixin {
  TextEditingController soNumberController = TextEditingController();
  TextEditingController soDateController = TextEditingController();
  TextEditingController deliveryAddress = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController taxTypeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime orderDate = DateTime.now();
  DateTime deliveryDate = DateTime.now();

  String? messages;
  String? dates;

  bool selected = true;
  late SalesOrder createSalesOrder;
  RxBool isLoading = false.obs;
  RxBool isCurrencyLoading = false.obs;
  final addSalesOrderKey = GlobalKey<FormState>();

  String currentTimeAndDate = "";

  GetCustomerModel? getCustomer;
  String? selectCustomer = "";
  Rx<List<GetCustomerModel>?> getCustomerList =
      (null as List<GetCustomerModel>?).obs;
  LoginUserModel? loginUser;

  @override
  void onInit() async {
    super.onInit();
    dateAndTimePicker();
  }

  bool isGetCustomerLoading = false;

  Rx<List<GetAllCurrencyModel>?> getCurrencyList =
      (null as List<GetAllCurrencyModel>?).obs;

  GetAllCurrencyModel? getCurrencyModel;

  String? currency;

  dateAndTimePicker() {
    DateTime now = DateTime.now();
    // print(now);
    String formattedDate = formatDate(now);
    currentTimeAndDate = formattedDate;
    // print(currentTimeAndDate);
  }

  String formatDate(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
    return formatter.format(dateTime);
  }

  onSaved() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.post(
            URl: HttpUrl.postSalesOrder, params: createSalesOrder.toJson())
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

  customerListGet() async {
    isGetCustomerLoading = true;
    loginUser = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());

    await NetworkManager.get(
      url: HttpUrl.getCustomer,
      parameters: {
        "OrganizationId": "${loginUser?.orgId}",
        // 'OrganizationId': '1',
      },
    ).then((apiResponse) async {
      isGetCustomerLoading = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getCustomerList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetCustomerModel.fromJson(e))
              .toList();
          change(getCustomerList.value);
          print("getCustomerList.length");
          print(getCustomerList.value?.length);
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

  currencyListGet() async {
    isCurrencyLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());
    await NetworkManager.get(url: HttpUrl.getCurrency, parameters: {
      'OrganizationId': "${loginUser?.orgId}",
    }).then((apiResponse) async {
      isCurrencyLoading.value = false;

      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getCurrencyList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetAllCurrencyModel.fromJson(e))
              .toList();
          change(getCurrencyList.value);
          change(null, status: RxStatus.success());
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

  RxBool isTaxLoading = false.obs;
  Rx<List<GetTaxModel>?> getTaxList = (null as List<GetTaxModel>?).obs;
  GetTaxModel? getTaxModel;
  String? tax = "";

  taxListGet() async {
    isTaxLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());
    await NetworkManager.get(url: HttpUrl.getTax, parameters: {
      'OrganizationId': "${loginUser?.orgId}",
    }).then((apiResponse) async {
      isTaxLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getTaxList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetTaxModel.fromJson(e))
              .toList();
          change(getTaxList.value);
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

  RxBool isProductLoading = false.obs;
  Rx<List<GetAllProductModel>?> getProductList =
      (null as List<GetAllProductModel>?).obs;
  GetAllProductModel? getProductModel;
  String? product = "";

  productListGet() async {
    isProductLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getProduct,
      parameters: {
        'OrganizationId': "${loginUser?.orgId}",
      },
    ).then((apiResponse) async {
      print("=======================");
      print(apiResponse.apiResponseModel!.result);
      print("=======================");
      isProductLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          getProductList.value = (apiResponse.apiResponseModel!.result as List)
              .map((e) => GetAllProductModel.fromJson(e))
              .toList();
          change(getProductList.value);
          print("getProductList.length");
          print(getProductList.value?.length);
          change(null, status: RxStatus.success());
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
}
