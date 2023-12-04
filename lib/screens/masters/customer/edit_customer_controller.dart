import 'package:erp/Model/GetAllCountry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCustomerController extends GetxController with StateMixin {
  late bool selected;
  String? country;
  GetAllCountry? getCountryModel;
  GlobalKey<FormState> editCustomerKey = GlobalKey<FormState>();
  TextEditingController customerCodeController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController taxTypeController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
}
