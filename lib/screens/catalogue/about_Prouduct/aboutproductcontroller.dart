import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferenceHelper.dart';
import 'package:erp/Model/GetAllProductModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/TaxModel.dart';
import 'package:erp/screens/locator/cart_service.dart';
import 'package:erp/screens/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutProductController extends GetxController with StateMixin {
  RxBool isAbout = false.obs;
  RxBool isFavorite = false.obs;
  int counter = 0;

  PageController imageSwipeController = PageController();
  final loginKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  final CatalogueProductListService productService =
      getIt<CatalogueProductListService>();
  RxList<GetAllProductModel> productList = <GetAllProductModel>[].obs;
  List<TaxModel> taxModel = [];
  double taxPercentage = 0;
  String tax = "";
  String taxName = "";
  RxInt selectedIndex = 0.obs;

  Future<void> getTaxDetails(String? taxTypeId) async {
    isLoading.value = true;
    LoginUserModel? loginUser = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getTaxByCode,
      parameters: {
        "OrganizationId": loginUser?.orgId.toString(),
        "TaxCode": taxTypeId.toString(),
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            List<TaxModel> list = resJson.map<TaxModel>((value) {
              return TaxModel.fromJson(value);
            }).toList();
            taxModel = list;

            taxPercentage = taxModel.first.taxPercentage!;
            tax = taxModel.first.taxType!;
            taxName = taxModel.first.taxName!;
            print(
                " 111controller.taxPercentage ============  ${taxPercentage}");
            change(taxPercentage);
            change(null, status: RxStatus.success());

            return;
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

  void updateProductCount() {
    for (var product in productList) {
      productService.catalogueProductSelectedListItems
          .firstWhereOrNull((element) {
        if (element.productCode == product.productCode) {
          product.boxcountController.text = element.boxcount.toInt().toString();
          product.unitcountController.text =
              element.unitcount.toInt().toString();
          product.boxcount = element.boxcount;
          product.unitcount = element.unitcount;
          return true;
        } else {
          return false;
        }
      });
    }
  }
}
