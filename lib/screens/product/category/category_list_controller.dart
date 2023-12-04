import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllCategory.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  GetAllCategory? getAllCategory;
  Rx<List<GetAllCategory>?> getCategoryList =
      (null as List<GetAllCategory>?).obs;
  String? category;

  categoryListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getCategory,
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
          print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
          getCategoryList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetAllCategory.fromJson(e))
              .toList();
          // print("getCustomerList.length");
          // print(getCategoryList.value?.length);
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
