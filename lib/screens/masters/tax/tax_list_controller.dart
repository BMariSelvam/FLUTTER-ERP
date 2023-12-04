import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllTaxModel.dart';
import 'package:get/get.dart';

class TaxListController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  Rx<List<GetTaxModel>?> getTaxList = (null as List<GetTaxModel>?).obs;
  GetTaxModel? getTaxModel;
  String? tax;

  taxListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(url: HttpUrl.getTax, parameters: {
      'OrganizationId': '1',
    }).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getTaxList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetTaxModel.fromJson(e))
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
}
