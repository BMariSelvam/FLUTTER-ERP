import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferenceHelper.dart';
import 'package:erp/Model/GetAllAutocompleteProduct.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/GetAllProductModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/invioce_model/Invoice.dart';
import 'package:erp/Model/RequestModel/invioce_model/InvoiceDetail.dart';
import 'package:erp/Model/TaxModel.dart';
import 'package:erp/screens/locator/cart_service.dart';
import 'package:erp/screens/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController with StateMixin {
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
  List<InvoiceDetail>? productList;
  List<InvoiceDetail>? addProductList;

  // Rx<List<GetAllProductModel>?> getProductList =
  //     (null as List<GetAllProductModel>?).obs;
  Rx<List<GetAllAutocompleteProduct>?> getProductList =
      (null as List<GetAllAutocompleteProduct>?).obs;

  RxList<Invoice> getInvoiceByCodeList = <Invoice>[].obs;
  RxList<GetAllProductModel> getProductListByCodeList =
      <GetAllProductModel>[].obs;

  final InvoiceProductListService invoiceProductListService =
      getIt<InvoiceProductListService>();

  List<TaxModel> taxModel = [];
  double taxPercentage = 0.0;
  String tax = "";
  String taxName = "";
  double? total;

  String? product = '';
  String? code = '';

  var summaryListCartPrice;
  var summaryListUnitPrice;
  late GetAllProductModel createGetAllProductModel = GetAllProductModel();

  bool isProductSelect = false;

  getAllInvoiceProductList() async {
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
          print("getProductList.length");
          print(getProductList.value?.length);
          print("getProductList.length???????????");
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

  getAllInvoiceProductListCode(String? productCode) async {
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

  invoiceByCodeList(String? transNo) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    loginUserModel = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.getInvoiceByCode,
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
            getInvoiceByCodeList.value =
                (apiResponse.apiResponseModel!.data as List)
                    .map((e) => Invoice.fromJson(e))
                    .toList();
            productList = getInvoiceByCodeList.value.first.invoiceDetail;
            print("productList?.length");
            print(productList?.length);
            change(getInvoiceByCodeList);
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
            print("controller.taxPercentage ============  $taxPercentage");
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
    getAllProductModel = null;
    productNameController.clear();
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
