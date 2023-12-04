import 'package:erp/Helper/NetworkManger.dart';
import 'package:erp/Helper/api.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:get/get.dart';

class CustomerListController extends GetxController with StateMixin {
  bool isLoading = false;
  Rx<List<GetCustomerModel>?> getCustomerList =
      (null as List<GetCustomerModel>?).obs;
  GetCustomerModel? getCustomerModel;
  String? customer;

  customerListGet() async {
    isLoading = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getCustomer,
      parameters: {
        'OrganizationId': '1',
      },
    ).then((apiResponse) async {
      isLoading = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          getCustomerList.value = (apiResponse.apiResponseModel!.data as List)
              .map((e) => GetCustomerModel.fromJson(e))
              .toList();
          print("getCustomerList.length");
          print(getCustomerList.value?.length);
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
