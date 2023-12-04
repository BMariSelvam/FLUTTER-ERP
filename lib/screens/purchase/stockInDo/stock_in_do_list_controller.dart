import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllStockInDoModel.dart';
import 'package:get/get.dart';

class StockInDoListController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  Rx<List<GetAllStockInDoModel>?> getStockInDo =
      (null as List<GetAllStockInDoModel>?).obs;

  stockInDoListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.get(url: HttpUrl.getStockInDo, parameters: {
      'OrganizationId': '1',
    }).then((apiResponse) {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getStockInDo.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetAllStockInDoModel.fromJson(e))
              .toList();
          change(null, status: RxStatus.success());
          print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
          print(getStockInDo.value?.length);
        } else {
          change(null, status: RxStatus.error());
          String? msg = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: msg);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }
}
