import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferenceHelper.dart';
import 'package:erp/Model/GetAllCategory.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/GetAllProductModel.dart';
import 'package:erp/Model/GetAllSubCategory.dart';
import 'package:erp/Model/GetCustomerByCodeModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/screens/locator/cart_service.dart';
import 'package:erp/screens/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogueController extends GetxController with StateMixin {
  // RxInt counter = 0.obs;
  RxInt category = 0.obs;
  RxInt subcategory = 0.obs;
  Rx<List<GetAllCategory>?> categoryList = (null as List<GetAllCategory>?).obs;

  Rx<List<GetAllSubCategory>?> subCategoryList =
      (null as List<GetAllSubCategory>?).obs;

  RxBool isLoading = false.obs;
  RxBool isCusLoading = false.obs;

  // List<TaxModel> taxModel = [];
  double taxPercentage = 0;
  String tax = "";
  String taxName = "";
  String customer = "";

  // RxInt counter = 0.obs;
  String selectedCategoryId = "";
  int totalPages = 1;
  int currentPage = 1;
  RxList<GetAllProductModel> productList = <GetAllProductModel>[].obs;
  RxList<GetAllProductModel> cartAddedProduct = <GetAllProductModel>[].obs;
  RxInt selectedIndex = 0.obs;
  final CatalogueProductListService cartService =
      getIt<CatalogueProductListService>();
  Rx<List<GetCustomerModel>?> getCustomerList =
      (null as List<GetCustomerModel>?).obs;
  Rx<List<GetCustomerByCodeModel>?> getCustomerByCodeList =
      (null as List<GetCustomerByCodeModel>?).obs;
  LoginUserModel? loginUserModel;

  GetCustomerModel? getCustomerModel;
  GetCustomerByCodeModel? getCustomerByCodeModel;
  // @override
  // onInit() async {
  //   // getTaxDetails();
  //   super.onInit();
  // }

  Future<void> getCategoryList() async {
    isLoading.value = true;
    loginUserModel = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());
    await NetworkManager.get(url: HttpUrl.getAllCategory, parameters: {
      'OrganizationId': "${loginUserModel?.orgId}",
    }).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<GetAllCategory> list = resJson.map<GetAllCategory>((value) {
              return GetAllCategory.fromJson(value);
            }).toList();
            list.insert(0, GetAllCategory(name: "All"));
            categoryList.value = list;
            change(categoryList.value);
            return;
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
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
    // Similar usage for POST, PUT, and DELETE requests
  }

  Future<void> getSubCategoryList({required String categoryId}) async {
    isLoading.value = true;
    loginUserModel = await PreferenceHelper.getUserData();

    change(null, status: RxStatus.loading());
    await NetworkManager.get(
        url: HttpUrl.getSubCategoryByCategoryCode,
        parameters: {
          'OrganizationId': "${loginUserModel?.orgId}",
          "CategoryCode": categoryId,
        }).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<GetAllSubCategory> list =
                resJson.map<GetAllSubCategory>((value) {
              return GetAllSubCategory.fromJson(value);
            }).toList();
            list.insert(0, GetAllSubCategory(name: "All"));
            subCategoryList.value = list;
            change(subCategoryList.value);
            return;
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          subCategoryList.value = null;
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: response.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        change(null, status: RxStatus.error());
        subCategoryList.value = null;
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      subCategoryList.value = null;
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
    // Similar usage for POST, PUT, and DELETE requests
  }

  Future<void> getProductByCategoryId(
      {required String categoryId,
      required String subCategoryId,
      required bool isPagination}) async {
    loginUserModel = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loadingMore());
    await NetworkManager.get(
      url: HttpUrl.getProductWithImage,
      parameters: {
        'OrganizationId': "${loginUserModel?.orgId}",
        "Category": categoryId ?? "",
        "SubCategory": subCategoryId ?? "",
        "pageNo": "$currentPage",
        "pageSize": "10"
      },
    ).then((response) {
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.result != null) {
          List? resJson = response.apiResponseModel!.result!;
          if (resJson != null) {
            List<GetAllProductModel> list =
                resJson.map<GetAllProductModel>((value) {
              return GetAllProductModel.fromJson(value);
            }).toList();
            if (!isPagination) {
              productList.clear();
            }
            productList.addAll(list);
            updateProductCount();
            totalPages = response.apiResponseModel?.totalNumberOfPages ?? 1;
            currentPage++;
            change(productList);
          }
          change(null, status: RxStatus.success());
        } else {
          productList.value = [];
          currentPage = 1;
          change(null, status: RxStatus.error());
          // Get.showSnackbar(
          //   GetSnackBar(
          //     title: "Error",
          //     message: response.apiResponseModel!.message ?? '',
          //     icon: const Icon(Icons.error),
          //     duration: const Duration(seconds: 3),
          //   ),
          // );
        }
      } else {
        productList.value = [];
        currentPage = 1;
        change(null, status: RxStatus.error());
        String? message = response.apiResponseModel?.message;
        PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  getAllCustomerList() async {
    isCusLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getCustomer,
      parameters: {
        'OrganizationId': "${loginUserModel?.orgId}",
      },
    ).then((apiResponse) async {
      isCusLoading.value = false;
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
                  .map((e) => GetCustomerByCodeModel.fromJson(e))
                  .toList();
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
  // Future<void> getTaxDetails() async {
  //   print("taxValu==========");
  //   isLoading.value = true;
  //    loginUserModel = await PreferenceHelper.getUserData();
  //   change(null, status: RxStatus.loading());
  //   await NetworkService.get(
  //     url: HttpUrl.taxGetApi,
  //     parameters: {
  //     'OrganizationId': "${loginUserModel?.orgId}",
  //       "TaxCode": loginUser?.taxTypeId,
  //     },
  //   ).then((apiResponse) async {
  //     isLoading.value = false;
  //     change(null, status: RxStatus.success());
  //     if (apiResponse.apiResponseModel != null &&
  //         apiResponse.apiResponseModel!.status) {
  //       if (apiResponse.apiResponseModel!.data != null) {
  //         List? resJson = apiResponse.apiResponseModel!.data!;
  //         if (resJson != null) {
  //           List<TaxModel> list = resJson.map<TaxModel>((value) {
  //             return TaxModel.fromJson(value);
  //           }).toList();
  //           taxModel = list;
  //
  //           taxPercentage = taxModel.first.taxPercentage!;
  //           tax = taxModel.first.taxType!;
  //           taxName = taxModel.first.taxName!;
  //           print(
  //               " 111controller.taxPercentage ============  ${taxPercentage}");
  //           print("taxValu==========${taxModel.first.taxName}");
  //           change(taxPercentage);
  //           change(null, status: RxStatus.success());
  //
  //           return;
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

  void updateProductCount() {
    for (var product in productList) {
      cartService.catalogueProductSelectedListItems.firstWhereOrNull((element) {
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
