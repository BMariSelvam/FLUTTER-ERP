import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllCountry.dart';
import 'package:erp/Model/RequestModel/CreateCustomerModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../successfully_msg_screen.dart';

class AddCustomerController extends GetxController with StateMixin {
  String? messages;

  late String currentTimeandDate = "";

  final addCustomerKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  late CreateCustomerModel createCustomerModel;

  Rx<List<GetAllCountry>?> getCountryList = (null as List<GetAllCountry>?).obs;
  GetAllCountry? getCountryModel;
  String? country;

  bool selected = true;
  TextEditingController customerCodeController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController taxTypeController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    dateAndTimePicker();
  }

  dateAndTimePicker() {
    DateTime now = DateTime.now();
    print(now);
    String formattedDate = formatDate(now);
    currentTimeandDate = formattedDate;
    print(currentTimeandDate);
  }

  String formatDate(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
    return formatter.format(dateTime);
  }

  onSaved() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.post(
            URl: HttpUrl.postCustomer, params: createCustomerModel.toJson())
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null &&
            (apiResponse.apiResponseModel!.data).isNotEmpty) {
          change(null, status: RxStatus.success());
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.data!);
          if (customerJson != null) {
            Get.to(SuccessfullyMsgScreen(
                name: 'Customer Saved Successfully..!',
                filename: Get.toNamed(AppRoutes.customerList)));
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

  countryListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getCountry,
      parameters: {
        'OrganizationId': '1',
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getCountryList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetAllCountry.fromJson(e))
              .toList();
          print("getCountryList.length");
          print(getCountryList.value?.length);
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
