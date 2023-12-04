import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllPurchaseOrderModel.dart';
import 'package:get/get.dart';

class PurchaseOrderListController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  Rx<List<GetAllPurchaseOrderModel>?> getPurchaseOrder =
      (null as List<GetAllPurchaseOrderModel>?).obs;

  purchaseOrderListGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.get(url: HttpUrl.getPurchaseOrder, parameters: {
      'OrganizationId': '1',
    }).then((apiResponse) {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getPurchaseOrder.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetAllPurchaseOrderModel.fromJson(e))
              .toList();
          change(null, status: RxStatus.success());
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
