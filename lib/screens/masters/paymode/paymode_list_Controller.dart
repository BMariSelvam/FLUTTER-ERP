import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllPaymodeModel.dart';
import 'package:get/get.dart';

class PaymodeListController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;

  Rx<List<GetPaymodeModel>?> getPaymodeList =
      (null as List<GetPaymodeModel>?).obs;

  GetPaymodeModel? getPaymodeModel;
  String? paymode;

  paymodeListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(url: HttpUrl.getPaymode, parameters: {
      'OrganizationId': '1',
    }).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getPaymodeList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetPaymodeModel.fromJson(e))
              .toList();
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
