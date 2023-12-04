import 'package:erp/Model/GetAllAutocompleteProduct.dart';
import 'package:erp/Model/GetAllProductModel.dart';
import 'package:erp/Model/RequestModel/CreateSalesOrderModel.dart';
import 'package:erp/screens/locator/cart_service.dart';
import 'package:erp/screens/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Helper/NetworkManger.dart';
import '../../../../../Helper/api.dart';
import '../../../../../Helper/preferenceHelper.dart';
import '../../../../../Model/GetAllCustomerModel.dart';
import '../../../../../Model/LoginUserModel.dart';
import '../../../../../Model/RequestModel/SalesOrderDetail.dart';
import '../../../../../Model/TaxModel.dart';

class SalesProductController extends GetxController with StateMixin {
  TextEditingController barcodeController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController stockCartonController = TextEditingController();
  TextEditingController stockUnitController = TextEditingController();
  TextEditingController stockQtyController = TextEditingController();
  TextEditingController focCartonController = TextEditingController();
  TextEditingController focUnitController = TextEditingController();
  TextEditingController focQtyController = TextEditingController();
  TextEditingController exchangeCartonController = TextEditingController();
  TextEditingController exchangeUnitController = TextEditingController();
  TextEditingController exchangeQtyController = TextEditingController();
  TextEditingController cartonPcsCountController = TextEditingController();
  TextEditingController pcsPerCartonPrice = TextEditingController();
  TextEditingController pcsPerUnitPrice = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController sellingCostController = TextEditingController();

  RxBool isLoading = false.obs;

  RxDouble totalPrice = 0.00.obs;

  RxDouble taxPrice = 0.00.obs;

  RxDouble netTotal = 0.00.obs;

  String? tranNumbar = "";

  RxInt selectedIndex = 0.obs;

  LoginUserModel? loginUserModel;

  GetCustomerModel? getAllCustomer;

  // GetAllProductModel? getAllProductModel;
  GetAllAutocompleteProduct? getAllProductModel;
  GetAllProductModel? getAllProductModelCode;
  String? customer = "";
  List<SalesOrderDetail>? productList;
  List<SalesOrderDetail>? addProductList;

  // Rx<List<GetAllProductModel>?> getProductList =
  //     (null as List<GetAllProductModel>?).obs;
  Rx<List<GetAllAutocompleteProduct>?> getProductList =
      (null as List<GetAllAutocompleteProduct>?).obs;

  RxList<SalesOrder> getSalesOrderByCodeList = <SalesOrder>[].obs;
  RxList<GetAllProductModel> getProductListByCodeList =
      <GetAllProductModel>[].obs;

  final SalesOrderDetailListService productService =
  getIt<SalesOrderDetailListService>();

  List<TaxModel> taxModel = [];
  double taxPercentage = 0.0;
  String tax = "";
  String taxName = "";
  double? total;

  String? product = '';
  String? code = '';

  var summaryListCartPrice;
  var summaryListUnitPrice;
  var summaryWeightPrice;
  late GetAllProductModel createGetAllProductModel = GetAllProductModel();

  bool isProductSelect = false;

  bool isWeight = false;

  getAllSalesOrderProductList() async {
    // isLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getAllAutocompleteProduct,
      parameters: {
        'OrganizationId': "${loginUserModel?.orgId}",
        "Type": "P",
      },
    ).then((apiResponse) async {
      // isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getProductList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetAllAutocompleteProduct.fromJson(e))
              .toList();
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

  getAllSalesOrderProductListCode(String? productCode) async {
    // isLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getProductByCode,
      parameters: {
        'OrganizationId': '${loginUserModel?.orgId}',
        'ProductCode': productCode
      },
    ).then((apiResponse) async {
      // isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          // logic for api call success
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            getProductListByCodeList.value =
                resJson.map((e) => GetAllProductModel.fromJson(e)).toList();
            cartonPcsCountController.text =
                '${getProductListByCodeList.first.pcsPerCarton}' ?? "";
            pcsPerCartonPrice.text =
                '${getProductListByCodeList.first.cartonPrice}' ?? "";
            pcsPerUnitPrice.text =
                '${getProductListByCodeList.first.unitCost}' ?? "";
            isWeight = getProductListByCodeList.first.isWeight ?? false;
            sellingCostController.text =
                '${getProductListByCodeList.first.sellingCost}' ?? "";

            print('sellingCostController.text');
            print(sellingCostController.text);
            stockCartonController.clear();
            stockUnitController.clear();
            stockQtyController.clear();
            exchangeQtyController.clear();
            exchangeUnitController.clear();
            exchangeCartonController.clear();
            focQtyController.clear();
            focUnitController.clear();
            focCartonController.clear();
            // controller.cartonPcsCountController.clear();
            // controller.pcsPerCartonPrice.clear();
            // controller.pcsPerUnitPrice.clear();
            change(getProductListByCodeList);
          }
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

  salesOrderByCodeList(String? transNo) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getSalesOrderByCode,
      parameters: {
        'OrganizationId': '${loginUserModel?.orgId}',
        'TranNo': transNo
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          // logic for api call success
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            getSalesOrderByCodeList.value =
                (apiResponse.apiResponseModel!.data as List)
                    .map((e) => SalesOrder.fromJson(e))
                    .toList();
            productList = getSalesOrderByCodeList.value.first.salesOrderDetail;
            print("productList?.length");
            print(productList?.length);
            change(getSalesOrderByCodeList);
          }
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

  Future<void> getTaxDetails(String? taxTypeId) async {
    print("taxValue==========");
    // isLoading.value = true;
    LoginUserModel? loginUser = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());
    NetworkManager.get(
      url: HttpUrl.getTaxByCode,
      parameters: {
        "OrganizationId": loginUser?.orgId.toString(),
        "TaxCode": taxTypeId.toString(),
      },
    ).then((apiResponse) async {
      // isLoading.value = false;
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

  void clearData() {
    //todo
    print("1234567890-");
    getAllProductModel = null;
    productNameController.clear();
    // customer = '';
    barcodeController.clear();
    exchangeQtyController.clear();
    exchangeUnitController.clear();
    exchangeCartonController.clear();
    focQtyController.clear();
    focUnitController.clear();
    focCartonController.clear();
    stockQtyController.clear();
    stockUnitController.clear();
    stockCartonController.clear();
    cartonPcsCountController.clear();
    pcsPerCartonPrice.clear();
    pcsPerUnitPrice.clear();
  }
}
