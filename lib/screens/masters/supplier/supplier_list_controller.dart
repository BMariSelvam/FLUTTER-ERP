import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllSupplierModel.dart';
import 'package:get/get.dart';

class SupplierListController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  Rx<List<GetSupplierModel>?> getSupplierList =
      (null as List<GetSupplierModel>?).obs;

  supplierListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(url: HttpUrl.getSupplier, parameters: {
      'OrganizationId': '1',
    }).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getSupplierList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetSupplierModel.fromJson(e))
              .toList();
          print('getSupplierList.length');
          print(getSupplierList.value!.length);
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
