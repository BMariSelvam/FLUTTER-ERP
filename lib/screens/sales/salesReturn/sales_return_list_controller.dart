import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/RequestModel/CreateSalesOrderModel.dart';
import 'package:get/get.dart';

class SalesReturnListController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  Rx<List<SalesOrder>?> getSalesReturn =
      (null as List<SalesOrder>?).obs;

  salesReturnListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.get(url: HttpUrl.getSalesReturn, parameters: {
      'OrganizationId': '1',
    }).then((apiResponse) {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getSalesReturn.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => SalesOrder.fromJson(e))
              .toList();
          change(null, status: RxStatus.success());
          print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
          print(getSalesReturn.value?.length);
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
