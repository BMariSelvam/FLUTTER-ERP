import 'dart:async';

import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/preferenceHelper.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/invioce_model/Invoice.dart';
import 'package:erp/Model/RequestModel/invioce_model/InvoiceDetail.dart';
import 'package:erp/Model/TaxModel.dart';
import 'package:erp/screens/locator/cart_service.dart';
import 'package:erp/screens/locator/locator.dart';
import 'package:erp/screens/successfully_msg_screen.dart';
import 'package:get/get.dart';

class SummaryController extends GetxController with StateMixin {
  final InvoiceProductListService productService =
      getIt<InvoiceProductListService>();

  bool isSumSelected = false;

  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;
  LoginUserModel? loginUserModel;

  List<TaxModel> taxModel = [];
  double taxPercentage = 0.0;
  String tax = "";
  String taxName = "";
  double summaryListUnitPrice = 0;
  double summaryListCartPrice = 0;
  double total = 0;
  List<InvoiceDetail>? productList;
  late Invoice createInvoice = Invoice();

  RxList<Invoice> getInvoiceByCodeList = <Invoice>[].obs;

  invoiceApi() async {
    isSaving.value = true;
    int index = 1;

    createInvoice.invoiceDetail?.forEach((element) {
      element.slNo = index;
      index += 1;
    });

    NetworkManager.post(
            URl: HttpUrl.postInvoice, params: createInvoice.toJson())
        .then((apiResponse) async {
      isSaving.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          productService.productListItems.clear();
          productService.clearProductList();
          await Get.to(() => SuccessfullyMsgScreen(
              name: "Invoice Created Successfully",
              filename: Get.offAndToNamed(AppRoutes.tabBarScreen)));
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
}
