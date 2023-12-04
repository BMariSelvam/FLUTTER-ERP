import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllCurrencyModel.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/GetAllPaymodeModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/CreateReceiptModel.dart';
import 'package:erp/Model/RequestModel/receipt_model/GetTranforPayment.dart';
import 'package:erp/screens/successfully_msg_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Helper/appRoute.dart';
import '../../../Model/GetAllBankModel.dart';

class AddReceiptController extends GetxController with StateMixin {
  RxBool isLoading3 = false.obs;
  final addReceiptKey = GlobalKey<FormState>();
  String? messages;
  bool selected = true;
  bool isCheque = false;
  Rx<List<GetAllCurrencyModel>?> getCurrencyList =
      (null as List<GetAllCurrencyModel>?).obs;
  List<GetTranforPayment> selectedItems = [];
  late Receipt createReceiptModel = Receipt();
  LoginUserModel? loginUserModel;

  String? customerCode;
  String? customerAddress;

  TextEditingController recNoController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController payModeController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController totalPaidController = TextEditingController();
  TextEditingController selectedAmtController = TextEditingController();
  TextEditingController differenceController = TextEditingController();
  TextEditingController writeOffController = TextEditingController();
  TextEditingController chqNoController = TextEditingController();
  TextEditingController chqDateController = TextEditingController();
  TextEditingController bankInDateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? date;

  GetAllCurrencyModel? getCurrencyModel;

  String? currency;

  String currentTimeAndDate = "";

  bool isCheckedSelectAll = false;

  double selectedAmt = 0.00;
  double creditAmt = 0.00;
  double? credit;

  @override
  void onInit() async {
    super.onInit();
    dateAndTimePicker();
  }

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

  receiptApi(context) async {
    isLoading3.value = true;
    change(null, status: RxStatus.loading());

    NetworkManager.post(
            URl: HttpUrl.postReceipt, params: createReceiptModel.toJson())
        .then((apiResponse) {
      isLoading3.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          SuccessfullyMsgScreen(
              name: "Receipt Saved Successfully..!",
              filename: Get.offAndToNamed(AppRoutes.receiptList));
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  currencyListGet() async {
    isLoading3.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(url: HttpUrl.getCurrency, parameters: {
      'OrganizationId': "${loginUserModel?.orgId}",
    }).then((apiResponse) async {
      isLoading3.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getCurrencyList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetAllCurrencyModel.fromJson(e))
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

  RxBool isLoading = false.obs;

  Rx<List<GetPaymodeModel>?> getPaymodeList =
      (null as List<GetPaymodeModel>?).obs;

  GetPaymodeModel? getPaymodeModel;
  String? paymode;

  paymodeListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(url: HttpUrl.getPaymode, parameters: {
      'OrganizationId': "${loginUserModel?.orgId}",
    }).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getPaymodeList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetPaymodeModel.fromJson(e))
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

  Rx<List<GetCustomerModel>?> getCustomerList =
      (null as List<GetCustomerModel>?).obs;
  GetCustomerModel? getCustomerModel;
  String? customer;

  customerListGet() async {
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

  Rx<List<GetTranforPayment>?> getTranDetail =
      (null as List<GetTranforPayment>?).obs;

  receiptInvoiceListGet({required String customerCode}) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    NetworkManager.get(
      url: HttpUrl.getTranforPayment,
      parameters: {
        "OrganizationId": "${loginUserModel?.orgId}",
        "CustomerCode": customerCode,
      },
    ).then((apiResponse) {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          print(apiResponse.apiResponseModel!.data!);
          if (resJson != null) {
            print(apiResponse.apiResponseModel!.data!);
            getTranDetail.value = (apiResponse.apiResponseModel!.data as List)
                .map((e) => GetTranforPayment.fromJson(e))
                .toList();
            print(getTranDetail.value);
            print("getTranDetail+++++++++++++++");
            change(getTranDetail.value);
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
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

  Rx<List<GetBankModel>?> getBankList = (null as List<GetBankModel>?).obs;
  GetBankModel? getBankModel;
  String? bank;

  bankListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(url: HttpUrl.getBank, parameters: {
      'OrganizationId': "${loginUserModel?.orgId}",
    }).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getBankList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetBankModel.fromJson(e))
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
}
