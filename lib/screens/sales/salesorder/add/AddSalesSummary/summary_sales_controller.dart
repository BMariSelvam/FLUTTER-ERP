import 'dart:async';

import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/SalesOrderDetail.dart';
import 'package:erp/Model/TaxModel.dart';
import 'package:erp/screens/locator/cart_service.dart';
import 'package:erp/screens/locator/locator.dart';
import 'package:erp/screens/successfully_msg_screen.dart';
import 'package:get/get.dart';

import '../../../../../Helper/NetworkManger.dart';
import '../../../../../Helper/api.dart';
import '../../../../../Helper/appRoute.dart';
import '../../../../../Helper/preferenceHelper.dart';
import '../../../../../Model/RequestModel/CreateSalesOrderModel.dart';

class SummarySalesController extends GetxController with StateMixin {
  final SalesOrderDetailListService productService =
      getIt<SalesOrderDetailListService>();

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
  List<SalesOrderDetail>? productList;
  late SalesOrder createSalesOrder = SalesOrder();

  RxList<SalesOrder> getSalesOrderByCodeList = <SalesOrder>[].obs;

  salesOrderApi() async {
    isSaving.value = true;
    change(null, status: RxStatus.loading());
    int index = 1;

    createSalesOrder.salesOrderDetail?.forEach((element) {
      element.slNo = index;
      index += 1;
    });

    NetworkManager.post(
            URl: HttpUrl.postSalesOrder, params: createSalesOrder.toJson())
        .then((apiResponse) async {
      isSaving.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          productService.productListItems.clear();
          productService.clearProductList();
          await Get.to(SuccessfullyMsgScreen(
              name: "Sales Order Created Successfully",
              filename: Get.offAndToNamed(AppRoutes.salesOrderList)));
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

// salesOrderByCodeList(String? transNo) async {
//   isLoading.value = true;
//   change(null, status: RxStatus.loading());
//   loginUserModel = await PreferenceHelper.getUserData();
//   await NetworkManager.get(
//     url: HttpUrl.getSalesOrderByCode,
//     parameters: {
//       'OrganizationId': '${loginUserModel?.orgId}',
//       'TranNo': transNo
//     },
//   ).then((apiResponse) async {
//     // isLoading.value = false;
//     change(null, status: RxStatus.success());
//     if (apiResponse.apiResponseModel != null &&
//         apiResponse.apiResponseModel!.status) {
//       if (apiResponse.apiResponseModel!.data != null) {
//         // logic for api call success
//         List? resJson = apiResponse.apiResponseModel!.data!;
//         if (resJson != null) {
//           List<SalesOrder> list = resJson.map<SalesOrder>((value) {
//             return SalesOrder.fromJson(value);
//           }).toList();
//           getSalesOrderByCodeList.value =
//               (apiResponse.apiResponseModel!.data as List)
//                   .map((e) => SalesOrder.fromJson(e))
//                   .toList();
//           change(getSalesOrderByCodeList);
//         }
//         change(null, status: RxStatus.success());
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
}
