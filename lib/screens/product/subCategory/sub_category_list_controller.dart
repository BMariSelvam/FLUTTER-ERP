import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllSubCategory.dart';
import 'package:get/get.dart';

class SubCategoryListController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  Rx<List<GetAllSubCategory>?> getSubCategoryList =
      (null as List<GetAllSubCategory>?).obs;

  subCategoryListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getSubCategory,
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
          getSubCategoryList.value =
              (apiResponse.apiResponseModel!.data as List)
                  .map((e) => GetAllSubCategory.fromJson(e))
                  .toList();
          print("getSubCategoryList.length");
          print(getSubCategoryList.value?.length);
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
