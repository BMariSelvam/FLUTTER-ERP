import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllUomModel.dart';
import 'package:get/get.dart';

class UomListController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  Rx<List<GetAllUomModel>?> getUomList = (null as List<GetAllUomModel>?).obs;

  uomListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getUom,
      parameters: {
        'OrganizationId': '1',
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          // logic for api call success
          getUomList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetAllUomModel.fromJson(e))
              .toList();
          print("getUomList.length");
          print(getUomList.value?.length);
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
