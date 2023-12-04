import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Model/GetAllCurrencyModel.dart';
import 'package:erp/Model/RequestModel/CreateSalesOrderModel.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../Model/GetAllCustomerModel.dart';
import '../../../../../widgets/search_dropdown_textfield2.dart';
import 'customersalescontroller.dart';

class CustomerSales extends StatefulWidget {
  const CustomerSales({
    super.key,
  });

  @override
  State<CustomerSales> createState() => _CustomerSalesState();
}

class _CustomerSalesState extends State<CustomerSales> {
  late CustomerSalesController controller;
  String code = "";

  SalesOrder? salesOrderModel;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CustomerSalesController());
    if (controller.customerNameController.text.isEmpty) {
      controller.getCurrencyByCode("SGD");
    } else {
      return;
    }
    controller.getAllCustomerList();
    controller.getAllCurrency();
    SalesOrder? customerCodePassing = Get.arguments as SalesOrder?;
    controller.dateController.text = controller.orderDate.toString();
    controller.deliveryDateController.text = controller.deliveryDate.toString();
    controller.dateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now());
    controller.deliveryDateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now());

    controller.countryController.text = "SINGAPORE";

    initialFunc();
    if (customerCodePassing != null) {
      controller.getAllCustomerByCodeList(customerCodePassing.customerId);

      customerCodePassing.salesOrderDetail?.first.productName;
    }
  }

  initialFunc() {
    if (controller.customerNameController.text.isNotEmpty) {
      controller.isCusSelected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerSalesController>(builder: (logic) {
      if (logic.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CustomGradient(child: CircularProgressIndicator()),
          ),
        );
      }
      return Scaffold(
          backgroundColor: MyColors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Obx(() {
                    return SearchDropdownTextField2<GetCustomerModel>(
                        labelText: 'Select Customer',
                        suffixIcon: CustomGradient(
                          child: Icon(
                            Icons.expand_circle_down_outlined,
                            color: MyColors.black.withOpacity(0.4),
                          ),
                        ),
                        items: controller.getCustomerList.value,
                        color: Colors.black54,
                        selectedItem: controller.getCustomerModel ??
                            controller.getCustomerByCodeList.value?.first,
                        isValidator: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please select Customer Name');
                            return 'Please select Customer Name';
                          }
                        },
                        onAddPressed: () {
                          setState(() {
                            controller.customer = "";
                            controller.getCustomerModel = null;
                          });
                        },
                        onChanged: (value) async {
                          FocusScope.of(context).unfocus();
                          controller.getCustomerModel = value;
                          controller.customer = value.name ?? "";
                          // controller.isCusSelected = true;

                          setState(() {
                            code = value.code ?? "";
                            controller.getAllCustomerByCodeList(code);
                          });
                        });
                  }),
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: const OutlineInputBorder(),
                  controller: controller.customerCodeController,
                  labelText: "Customer Code",
                  onTap: () {
                    if (controller.getCustomerModel == null &&
                        controller.getCustomerByCodeList.value?.first == null &&
                        controller.customer == "") {
                      Get.showSnackbar(
                        const GetSnackBar(
                          margin: EdgeInsets.all(10),
                          borderRadius: 10,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.TOP,
                          message: "Please Select Customer",
                          icon: Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: const OutlineInputBorder(),
                  controller: controller.customerAddressLine1Controller,
                  labelText: "Address",
                  onTap: () {
                    if (controller.getCustomerModel == null &&
                        controller.getCustomerByCodeList.value?.first == null &&
                        controller.customer == "") {
                      Get.showSnackbar(
                        const GetSnackBar(
                          margin: EdgeInsets.all(10),
                          borderRadius: 10,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.TOP,
                          message: "Please Select Customer",
                          icon: Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: const OutlineInputBorder(),
                  controller: controller.customerAddressLine2Controller,
                  // labelText: "Address",
                  onTap: () {
                    if (controller.getCustomerModel == null &&
                        controller.getCustomerByCodeList.value?.first == null &&
                        controller.customer == "") {
                      Get.showSnackbar(
                        const GetSnackBar(
                          margin: EdgeInsets.all(10),
                          borderRadius: 10,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.TOP,
                          message: "Please Select Customer",
                          icon: Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: const OutlineInputBorder(),
                  controller: controller.customerAddressLine3Controller,
                  // labelText: "Address",
                  onTap: () {
                    if (controller.getCustomerModel == null &&
                        controller.getCustomerByCodeList.value?.first == null &&
                        controller.customer == "") {
                      Get.showSnackbar(
                        const GetSnackBar(
                          margin: EdgeInsets.all(10),
                          borderRadius: 10,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.TOP,
                          message: "Please Select Customer",
                          icon: Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: const OutlineInputBorder(),
                  controller: controller.countryController,
                  labelText: "Country",
                  onTap: () {
                    if (controller.getCustomerModel == null &&
                        controller.getCustomerByCodeList.value?.first == null &&
                        controller.customer == "") {
                      Get.showSnackbar(
                        const GetSnackBar(
                          margin: EdgeInsets.all(10),
                          borderRadius: 10,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.TOP,
                          message: "Please Select Customer",
                          icon: Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: const OutlineInputBorder(),
                  controller: controller.postCodeController,
                  labelText: "Postal Code",
                  onTap: () {
                    if (controller.getCustomerModel == null &&
                        controller.getCustomerByCodeList.value?.first == null &&
                        controller.customer == "") {
                      Get.showSnackbar(
                        const GetSnackBar(
                          margin: EdgeInsets.all(10),
                          borderRadius: 10,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.TOP,
                          message: "Please Select Customer",
                          icon: Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Obx(() {
                    return SearchDropdownTextField2<GetAllCurrencyModel>(
                        labelText: 'Select Currency',
                        suffixIcon: CustomGradient(
                          child: Icon(
                            Icons.expand_circle_down_outlined,
                            color: MyColors.black.withOpacity(0.4),
                          ),
                        ),
                        items: controller.getAllCurrencyList.value,
                        color: Colors.black54,
                        // initialValue: controller.cucc!.isNotEmpty
                        //     ? controller.cucc?.first
                        //     : controller.getAllCurrencyList.value?.last,
                        selectedItem: controller.getByCodeCurrency.value?.first,
                        isValidator: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please select Currency');
                            return 'Please select Currency';
                          }
                        },
                        onAddPressed: () {
                          setState(() {
                            controller.currency = "";
                            controller.getAllCurrencyModel = null;
                          });
                        },
                        onChanged: (value) async {
                          FocusScope.of(context).unfocus();
                          controller.getAllCurrencyModel = value;
                          controller.currency = value.name ?? "";
                          // controller.isCusSelected = true;
                        });
                  }),
                ),
                CustomTextField2(
                  maxLines: 3,
                  inputBorder: const OutlineInputBorder(),
                  controller: controller.remarkController,
                  keyboardType: TextInputType.text,
                  labelText: "Remark",
                  hintText: "Text Here",
                  suffixIcon: const Icon(
                    Icons.edit,
                    size: 18,
                  ),
                  onTap: () {
                    if (controller.getCustomerModel == null &&
                        controller.getCustomerByCodeList.value?.first == null &&
                        controller.customer == "") {
                      Get.showSnackbar(
                        const GetSnackBar(
                          margin: EdgeInsets.all(10),
                          borderRadius: 10,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.TOP,
                          message: "Please Select Customer",
                          icon: Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField2(
                        inputBorder: const OutlineInputBorder(),
                        controller: controller.dateController,
                        keyboardType: TextInputType.datetime,
                        labelText: "Date",
                        readOnly: true,
                        suffixIcon: GestureDetector(
                            onTap: () async {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now())
                                  .then((value) {
                                setState(() {
                                  controller.orderDate = value!;
                                  controller.dateController.text =
                                      '${controller.orderDate.day}-${controller.orderDate.month}-${controller.orderDate.year}';
                                  // '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}';
                                  controller.date =
                                      '${controller.orderDate.year}-${controller.orderDate.month}-${controller.orderDate.day}';
                                });
                              });
                            },
                            child: const Icon(Icons.calendar_month_outlined)),
                      ),
                    ),
                    Expanded(
                      child: CustomTextField2(
                        inputBorder: const OutlineInputBorder(),
                        controller: controller.deliveryDateController,
                        readOnly: true,
                        labelText: "Delivery Date",
                        hintText: "Delivery Date",
                        suffixIcon: GestureDetector(
                            onTap: () async {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(3000))
                                  .then((value) {
                                setState(() {
                                  controller.deliveryDate = value!;
                                  controller.deliveryDateController.text =
                                      '${controller.deliveryDate.day}-${controller.deliveryDate.month}-${controller.deliveryDate.year}';
                                  // '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}';
                                  controller.delDate =
                                      '${controller.deliveryDate.year}-${controller.deliveryDate.month}-${controller.deliveryDate.day}';
                                });
                              });
                            },
                            child: const Icon(Icons.calendar_month_outlined)),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField2(
                        inputBorder: InputBorder.none,
                        controller: controller.creditLimitController,
                        labelText: "Credit Limit",
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        onTap: () {
                          if (controller.getCustomerModel == null &&
                              controller.getCustomerByCodeList.value?.first ==
                                  null &&
                              controller.customer == "") {
                            Get.showSnackbar(
                              const GetSnackBar(
                                margin: EdgeInsets.all(10),
                                borderRadius: 10,
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.TOP,
                                message: "Please Select Customer",
                                icon: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomTextField2(
                        inputBorder: InputBorder.none,
                        controller: controller.outstandingController,
                        labelText: "Outstanding",
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        onTap: () {
                          if (controller.getCustomerModel == null &&
                              controller.getCustomerByCodeList.value?.first ==
                                  null &&
                              controller.customer == "") {
                            Get.showSnackbar(
                              const GetSnackBar(
                                margin: EdgeInsets.all(10),
                                borderRadius: 10,
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.TOP,
                                message: "Please Select Customer",
                                icon: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
    });
  }
}
