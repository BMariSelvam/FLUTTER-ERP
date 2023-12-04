import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllBranchModel.dart';
import 'package:erp/Model/GetAllOrganizationModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/NetworkManger.dart';
import '../../Helper/api.dart';
import '../../Helper/appRoute.dart';
import '../../Helper/colors.dart';

class LoginController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  RxBool isOrgLoading = false.obs;
  RxBool isBranchLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final loginKey = GlobalKey<FormState>();

  RxBool isPasswordVisible = false.obs;
  String? messages;

  GetAllOrganization? getOrganization;
  GetAllBranchModel? getBranch;

  String? companyBranch = "";
  String? companyName = "";
  String? companyBranchCode;

  Rx<List<GetAllOrganization>?> getOrganizationList =
      (null as List<GetAllOrganization>?).obs;
  Rx<List<GetAllBranchModel>?> getBranchList =
      (null as List<GetAllBranchModel>?).obs;

  onLoginTapped(String? companyBranch, int? orgId) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.post(URl: HttpUrl.login, params: {
      "Username": emailController.text,
      "Password": passwordController.text,
      "OrgId": "$orgId",
      "BranchCode": "$companyBranch"
    }).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null &&
            (apiResponse.apiResponseModel!.data as List).isNotEmpty) {
          change(null, status: RxStatus.success());
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.data! as List).first;
          if (customerJson != null) {
            await PreferenceHelper.saveUserData(customerJson)
                .then((value) async {
              print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
              print("BRANCH CODE >>>>>>> $companyBranch");
              print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
              print("ORGANIZATION ID >>>>>>>>> $orgId");
              print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
            });
            await PreferenceHelper.getUserData().then(
                (value) => print("CUSTOMER DATA ::::::::::::${value?.orgId}"));
            Get.toNamed(AppRoutes.bottomNavBarScreen);
          } else {
            change(null, status: RxStatus.error());
            Get.snackbar(
              "Error",
              colorText: MyColors.white,
              "Customer data is empty!",
              margin: const EdgeInsets.all(20),
              backgroundColor: MyColors.primaryCustom,
              icon: const Icon(
                Icons.error,
                color: MyColors.white,
              ),
              duration: const Duration(seconds: 3),
              snackPosition: SnackPosition.TOP,
            );
          }
        }
      } else {
        change(null, status: RxStatus.success());
        String? message = apiResponse.apiResponseModel?.message.toString();
        message = messages;
        print("API Response Message (Error): $message");
        Get.snackbar(
          margin: const EdgeInsets.all(20),
          backgroundColor: MyColors.primaryCustom,
          "Attention",
          message ?? "Your Username or Password are Incorrect",
          colorText: MyColors.white,
          icon: const Icon(
            Icons.error,
            color: MyColors.white,
          ),
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

  organizationListGet() async {
    isOrgLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.get(url: HttpUrl.getOrganization, parameters: {})
        .then((apiResponse) async {
      isOrgLoading.value = false;
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

  branchListGet(String orgId) async {
    isBranchLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
        url: HttpUrl.getBranches,
        parameters: {"OrganizationId": orgId}).then((apiResponse) async {
      isBranchLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getBranchList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetAllBranchModel.fromJson(e))
              .toList();
          if (getBranchList.value?.length == 1) {
            print("||||||||||||||||");
            getBranch = getBranchList.value?.first;
            companyBranch = getBranchList.value?.first.name;
            companyBranchCode = getBranchList.value?.first.code;
            print("||||||||||||||||");
            await PreferenceHelper.saveBanchCodeString("$companyBranchCode");
            await PreferenceHelper.saveBranchNameString("$companyBranch");
          }
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
