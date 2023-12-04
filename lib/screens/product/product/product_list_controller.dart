import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllProductModel.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  Rx<List<GetAllProductModel>?> getProductList =
      (null as List<GetAllProductModel>?).obs;

  productListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getProduct,
      parameters: {
        'OrganizationId': '1',
      },
    ).then((apiResponse) async {
      print("=======================");
      print(apiResponse.apiResponseModel!.result);
      print("=======================");
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          getProductList.value = (apiResponse.apiResponseModel!.result as List)
              .map((e) => GetAllProductModel.fromJson(e))
              .toList();
          print("getProductList.length");
          print(getProductList.value?.length);
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
