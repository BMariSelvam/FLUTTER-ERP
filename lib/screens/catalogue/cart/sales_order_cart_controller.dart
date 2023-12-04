import 'dart:async';

import 'package:erp/Model/GetAllProductModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/invioce_model/Invoice.dart';
import 'package:erp/Model/TaxModel.dart';
import 'package:erp/screens/locator/cart_service.dart';
import 'package:erp/screens/locator/locator.dart';
import 'package:get/get.dart';

import '../../../../../Helper/NetworkManger.dart';
import '../../../../../Helper/api.dart';
import '../../../../../Helper/appRoute.dart';
import '../../../../../Helper/preferenceHelper.dart';
import '../../../../../Model/RequestModel/CreateSalesOrderModel.dart';
import '../../successfully_msg_screen.dart';

class SalesOrderCartController extends GetxController with StateMixin {
  final CatalogueProductListService productService =
      getIt<CatalogueProductListService>();

  bool isSumSelected = false;

  RxBool isLoading = false.obs;

  late SalesOrder createSalesOrder = SalesOrder();
  late Invoice createInvoice = Invoice();

  List<TaxModel> taxModel = [];
  double taxPercentage = 0.0;
  String tax = "";
  String taxName = "";
  List<GetAllProductModel> selectedItems = [];

  salesOrderApi() async {
    isLoading.value = true;
    int index = 1;
    createSalesOrder.salesOrderDetail?.forEach((element) {
      element.slNo = index;
      index += 1;
    });

    NetworkManager.post(
            URl: HttpUrl.postSalesOrder, params: createSalesOrder.toJson())
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          selectedItems.clear();
          productService.clearProductList();
          await Get.to(() => SuccessfullyMsgScreen(
              name: "Sales Order Created Successfully",
              filename: Get.offNamed(AppRoutes.dashBoardScreen)));
          Timer(const Duration(seconds: 3), () async {
            await PreferenceHelper.removeCartData()
                .then((value) => Get.offAndToNamed(AppRoutes.salesOrderList));
          });
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

  invoiceApi() async {
    isLoading.value = true;
    int index = 1;

    createInvoice.invoiceDetail?.forEach((element) {
      element.slNo = index;
      index += 1;
    });

    NetworkManager.post(
            URl: HttpUrl.postInvoice, params: createInvoice.toJson())
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          productService.catalogueProductSelectedListItems.clear();
          productService.clearProductList();
          await Get.to(() => SuccessfullyMsgScreen(
              name: "Invoice Created Successfully",
              filename: Get.offNamed(AppRoutes.bottomNavBarScreen)));
          Timer(const Duration(seconds: 5), () async {
            productService.clearProductList();
            productService.disposeProductList();

            await PreferenceHelper.removeCartData()
                .then((value) => Get.offAndToNamed(AppRoutes.allScreen));
          });
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

  Future<void> getTaxDetails(String? taxTypeId) async {
    print("taxValue==========");
    isLoading.value = true;
    LoginUserModel? loginUser = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());
    NetworkManager.get(
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
            print("controller.taxPercentage ============  ${taxPercentage}");
            print("taxValu==========${taxModel.first.taxName}");
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
    for (var product in selectedItems) {
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
