import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/extension.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/GetAllAutocompleteProduct.dart';
import 'package:erp/Model/RequestModel/CreateSalesOrderModel.dart';
import 'package:erp/Model/RequestModel/SalesOrderDetail.dart';
import 'package:erp/screens/sales/salesorder/add/AddSalesCustomer/customersalescontroller.dart';
import 'package:erp/screens/sales/salesorder/add/AddSalesProduct/productsalescontroller.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:erp/widgets/search_dropdown_textfield2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ProductSales extends StatefulWidget {
  const ProductSales({
    super.key,
  });

  @override
  State<ProductSales> createState() => _ProductSalesState();
}

class _ProductSalesState extends State<ProductSales> {
  late SalesProductController controller;
  bool isFOCSelected = false;
  bool isExchangeSelected = false;
  bool isAddProduct = false;
  SalesOrder? productCodePassing;
  double totalPrice = 0;
  double tax = 0;
  double netTotal = 0;
  int totalcount = 0;

  @override
  void initState() {
    super.initState();
    _initializeAsyncData();
  }

  Future<void> _initializeAsyncData() async {
    controller = Get.put(SalesProductController());
    controller.getAllSalesOrderProductList();
    SalesOrder? productCodePassing = Get.arguments as SalesOrder?;
    if (productCodePassing != null) {
      await controller.salesOrderByCodeList(productCodePassing.tranNo);
      setState(() {
        controller.tranNumbar = productCodePassing.tranNo;
      });
      isAddProduct = true;
    }
    if (productCodePassing == null) {
      isAddProduct = false;
      controller.productList = controller.productService.productListItems;
    }
    CustomerSalesController customerController =
        Get.find<CustomerSalesController>();
    controller.productService.salesOrderDetailListChangeStream.listen((_) {
      setState(() {});
    });
    controller.getTaxDetails(
        customerController.getCustomerByCodeList.value?.first.taxTypeId);
  }

  firstUnitCalculation(String value) {
    setState(() {
      if (value == "") {
        value = "0";
      }
      double unitQty = double.parse(value);
      print("UnitQty====$unitQty");
      if (controller.stockCartonController.text != "" &&
          controller.stockCartonController.text != "0") {
        double countOfPcsPerCarton =
            double.parse(controller.cartonPcsCountController.text);
        double cartonQty = double.parse(controller.stockCartonController.text);

        ///TotalCartonQty111
        double totalCartonQty = countOfPcsPerCarton * cartonQty;
        print("TotalCartonQty>>>>>>>>>>>>>>$totalCartonQty");

        ///TotalQuantity
        double totalQty = unitQty + totalCartonQty;
        controller.stockQtyController.text = totalQty.toStringAsFixed(0);
      } else {
        print("value=======$value");
        controller.stockQtyController.text = unitQty.toStringAsFixed(0);
      }
    });
  }

  firstCartonCalculation(String value) {
    print("value2====FirstCartonCalculation=======$value");

    setState(() {
      if (value == "") {
        value = "0";
      }
      double cartonQty = double.parse(value);
      if (controller.stockUnitController.text != "" &&
          controller.stockUnitController.text != "0") {
        print("cartonQty===========$value");

        double countOfPcsPerCarton =
            double.parse(controller.cartonPcsCountController.text);
        double unitQty = double.parse(controller.stockUnitController.text);

        ///TotalCartonQty
        var totalCartonQty = countOfPcsPerCarton * cartonQty;
        print("TotalCartonQty>>>>>>>>>>>>>>$totalCartonQty");

        ///TotalQuantity
        double totalQty = unitQty + totalCartonQty;
        controller.stockQtyController.text = totalQty.toStringAsFixed(0);

        controller.stockQtyController.text = totalQty.toStringAsFixed(0);
      } else {
        print("value4 FirstCartonCalculation===========$value");

        double countOfPcsPerCarton =
            double.parse(controller.cartonPcsCountController.text);
        double totalCartonQty = cartonQty * countOfPcsPerCarton;

        controller.stockQtyController.text = totalCartonQty.toStringAsFixed(0);
      }
    });
  }

  reverseCalculation(String value) {
    print(value);
    setState(() {
      if (value == "") {
        value = "0";
      }
      double qty = double.parse(value);
      double countOfPcsPerCarton =
          double.parse(controller.cartonPcsCountController.text);
      if (countOfPcsPerCarton != 1) {
        double oneCartonQty =
            double.parse(controller.cartonPcsCountController.text);

        double boxSplit = (qty / oneCartonQty);

        if (oneCartonQty <= qty) {
          int roundedValue = boxSplit.toInt();
          controller.stockCartonController.text =
              roundedValue.toStringAsFixed(0);
          double splitUnit = qty % oneCartonQty;
          controller.stockUnitController.text = splitUnit.toStringAsFixed(0);
        } else if (oneCartonQty > qty) {
          controller.stockUnitController.text = qty.toStringAsFixed(0);
          if (qty == 0) {
            controller.stockUnitController.text = "";
          }
          controller.stockCartonController.clear();
        } else {
          double splitUnit = qty % oneCartonQty;
          controller.stockUnitController.text = '';
          controller.stockCartonController.text = '';
        }
      }
      if (countOfPcsPerCarton == 1) {
        print("QTY..........$qty");
        controller.stockUnitController.text = qty.toStringAsFixed(0);
        if (qty == 0) {
          controller.stockUnitController.text = "";
        }
      }
    });
  }

  totalFun() {
    double? cartonPrice =
        controller.getProductListByCodeList.first.sellingBoxCost;
    double? unitPrice = controller.getProductListByCodeList.first.sellingCost;
    int cartonQty = int.tryParse(controller.stockCartonController.text) ?? 0;
    int unitQty = int.tryParse(controller.stockUnitController.text) ?? 0;

    // print("unitTotalPrice.............$unitTotalPrice");

    if (controller.stockUnitController.text == "") {
      totalPrice = cartonQty * cartonPrice!;
      tax = totalPrice *
          double.parse(controller.taxModel.first.taxPercentage.toString()) /
          100;
      if (controller.taxModel.first.taxType == "I") {
        netTotal = totalPrice;
      } else if (controller.taxModel.first.taxType == "E") {
        netTotal = totalPrice + tax;
      } else if (controller.taxModel.first.taxType == "Z") {
        netTotal = totalPrice + tax;
      } else {
        netTotal = totalPrice + tax;
      }
    } else if (controller.stockCartonController.text == "") {
      totalPrice = unitQty * unitPrice!;
      tax = totalPrice *
          double.parse(controller.taxModel.first.taxPercentage.toString()) /
          100;
      if (controller.taxModel.first.taxType == "I") {
        netTotal = totalPrice;
      } else if (controller.taxModel.first.taxType == "E") {
        netTotal = totalPrice + tax;
      } else if (controller.taxModel.first.taxType == "Z") {
        netTotal = totalPrice + tax;
      } else {
        netTotal = totalPrice + tax;
      }
    } else {
      totalPrice = (cartonQty * cartonPrice!) + (unitQty * unitPrice!);
      tax = totalPrice *
          double.parse(controller.taxModel.first.taxPercentage.toString()) /
          100;
      if (controller.taxModel.first.taxType == "I") {
        netTotal = totalPrice;
      } else if (controller.taxModel.first.taxType == "E") {
        netTotal = totalPrice + tax;
      } else if (controller.taxModel.first.taxType == "Z") {
        netTotal = totalPrice + tax;
      } else {
        netTotal = totalPrice + tax;
      }
    }
    print("totalPrice..................$totalPrice");
  }

  void updateTotal() {
    setState(() {
      totalFun();
    });
  }

  @override
  Widget build(BuildContext context) {
    double taxValue = 0.00;
    double cartonTotalPrice = 0.00;
    double unitTotalPrice = 0.00;
    double grandTotal = 0.00;
    double price = 0.00;

    for (var element in controller.productList ?? []) {
      unitTotalPrice += (element.pcsQty! * element.price!);
      cartonTotalPrice += (element.boxQty! * element.boxPrice!);
      price = unitTotalPrice + cartonTotalPrice;
      taxValue =
          (price * double.parse(controller.taxPercentage.toString())) / 100;
      if (controller.taxName == "Inclusive") {
        grandTotal = price;
      } else if (controller.taxName == "Exclusive") {
        grandTotal = price + taxValue;
      } else if (controller.taxName == "GSTs") {
        grandTotal = price + taxValue;
      } else {
        grandTotal = price + taxValue;
      }
    }

    return GetBuilder<SalesProductController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Scaffold(
          body: Center(
            child: CustomGradient(child: CircularProgressIndicator()),
          ),
        );
      }
      return Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              MyColors.gradient1,
              MyColors.gradient2,
              MyColors.gradient3,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Table(
            children: [
              TableRow(children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: MyColors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        price.toStringAsFixed(2),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: MyColors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Tax',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: MyColors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        taxValue.toStringAsFixed(2),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: MyColors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Net Total',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: MyColors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        grandTotal.toStringAsFixed(2),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: MyColors.white),
                      ),
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
        backgroundColor: MyColors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: CustomTextField2(
                        inputBorder: const OutlineInputBorder(),
                        controller: controller.barcodeController,
                        hintText: "Barcode",
                        readOnly: true,
                        suffixIcon: const Icon(Icons.qr_code_2),
                        onTap: () async {
                          var res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SimpleBarcodeScannerPage(),
                              ));
                          setState(() {
                            if (res is String) {
                              // result = res;
                              controller.barcodeController.text = res;
                              if (controller.barcodeController.text == "-1") {
                                controller.barcodeController.text = "";
                              }
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print(
                              'controller.getProductListByCodeList.first.boxcount,');
                          print(controller.weightController.text);
                          print(
                              'controller.getProductListByCodeList.first.boxcount,');
                          if (isAddProduct == true) {
                            onTap1();
                          } else {
                            onTap2();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  MyColors.gradient1,
                                  MyColors.gradient2,
                                  MyColors.gradient3,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Add",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: MyColors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Obx(() {
                  return SearchDropdownTextField2<GetAllAutocompleteProduct>(
                      labelText: 'Select Product',
                      suffixIcon: Icon(
                        Icons.expand_circle_down_outlined,
                        color: MyColors.black.withOpacity(0.4),
                      ),
                      items: controller.getProductList.value,
                      color: Colors.black54,
                      selectedItem: controller.getAllProductModel,
                      isValidator: false,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     Fluttertoast.showToast(
                      //         msg: 'Please select Product Name');
                      //     return 'Please select Product Name';
                      //   }
                      //   return null;
                      // },
                      onAddPressed: () {
                        setState(() {
                          controller.product = "";
                          controller.getAllProductModel = null;
                        });
                      },
                      onChanged: (value) async {
                        FocusScope.of(context).unfocus();
                        controller.getAllProductModel = value;
                        controller.product = value.name;
                        controller.isProductSelect = true;
                        // cusController.isCusSelected = false;

                        setState(() {
                          controller.product = value.name;
                          controller.code = value.name;
                          controller.productNameController.text =
                              value.name ?? '';
                          controller
                              .getAllSalesOrderProductListCode(controller.code);
                          // controller.clearData();
                        });
                      });
                }),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  "Stock",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColors.black),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField2(
                readOnly: true,
                inputBorder: const OutlineInputBorder(),
                controller: controller.productNameController,
                labelText: "Product Name",
                onTap: () {
                  if (controller.getAllProductModel == null &&
                      controller.product == "") {
                    Get.showSnackbar(
                      const GetSnackBar(
                        margin: EdgeInsets.all(10),
                        borderRadius: 10,
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.TOP,
                        message: "Please Select Product Name",
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
              controller.isWeight == true
                  ? CustomTextField2(
                      readOnly: (controller.productNameController.text.isEmpty)
                          ? true
                          : false,
                      inputBorder: const OutlineInputBorder(),
                      controller: controller.weightController,
                      inputFormatters: [NumericInputFormatter()],
                      keyboardType: TextInputType.number,
                      labelText: "Weight",
                      onTap: () {
                        if (controller.getAllProductModel == null &&
                            controller.product == "") {
                          Get.showSnackbar(
                            const GetSnackBar(
                              margin: EdgeInsets.all(10),
                              borderRadius: 10,
                              backgroundColor: Colors.red,
                              snackPosition: SnackPosition.TOP,
                              message: "Please Select Product Name",
                              icon: Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            inputFormatters: [NumericInputFormatter()],
                            controller: controller.stockCartonController,
                            keyboardType: TextInputType.number,
                            onTap: () {
                              if (controller.getAllProductModel == null &&
                                  controller.product == "") {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    message: "Please Select Product",
                                    icon: Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            readOnly:
                                (controller.cartonPcsCountController.text ==
                                            "1" ||
                                        controller
                                            .productNameController.text.isEmpty)
                                    ? true
                                    : false,
                            labelText: "Carton",
                            onChanged: (value) async {
                              firstCartonCalculation(value);
                              updateTotal();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            readOnly:
                                (controller.cartonPcsCountController.text ==
                                            "1" ||
                                        controller
                                            .productNameController.text.isEmpty)
                                    ? true
                                    : false,
                            controller: controller.stockUnitController,
                            inputFormatters: [NumericInputFormatter()],
                            keyboardType: TextInputType.number,
                            labelText: "Unit",
                            onChanged: (value) async {
                              firstUnitCalculation(value);
                              updateTotal();
                            },
                            onTap: () {
                              if (controller.getAllProductModel == null &&
                                  controller.product == "") {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    message: "Please Select Product",
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            controller: controller.stockQtyController,
                            readOnly:
                                (controller.productNameController.text.isEmpty)
                                    ? true
                                    : false,
                            inputFormatters: [NumericInputFormatter()],
                            keyboardType: TextInputType.number,
                            labelText: 'Qty',
                            onChanged: (value) async {
                              reverseCalculation(value);
                              updateTotal();
                            },
                            onTap: () {
                              if (controller.getAllProductModel == null &&
                                  controller.product == "") {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    message: "Please Select Product",
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
              Row(
                children: [
                  Expanded(
                    child: CustomTextField2(
                      readOnly: true,
                      inputBorder: const OutlineInputBorder(),
                      inputFormatters: [NumericInputFormatter()],
                      keyboardType: TextInputType.number,
                      controller: controller.cartonPcsCountController,
                      labelText: "Pcs",
                      filled: true,
                      filledColor: MyColors.lightBlue,
                      onTap: () {
                        if (controller.getAllProductModel == null &&
                            controller.product == "") {
                          Get.showSnackbar(
                            const GetSnackBar(
                              margin: EdgeInsets.all(10),
                              borderRadius: 10,
                              backgroundColor: Colors.red,
                              snackPosition: SnackPosition.TOP,
                              message: "Please Select Product",
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
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField2(
                      readOnly: true,
                      inputBorder: const OutlineInputBorder(),
                      controller: controller.pcsPerCartonPrice,
                      inputFormatters: [NumericInputFormatter()],
                      keyboardType: TextInputType.number,
                      labelText: "Carton Price",
                      filled: true,
                      filledColor: MyColors.lightBlue,
                      onTap: () {
                        if (controller.getAllProductModel == null &&
                            controller.product == "") {
                          Get.showSnackbar(
                            const GetSnackBar(
                              margin: EdgeInsets.all(10),
                              borderRadius: 10,
                              backgroundColor: Colors.red,
                              snackPosition: SnackPosition.TOP,
                              message: "Please Select Product",
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
                  const SizedBox(width: 10),
                  controller.isWeight == false
                      ? Expanded(
                          child: CustomTextField2(
                            readOnly: true,
                            inputBorder: const OutlineInputBorder(),
                            controller: controller.pcsPerUnitPrice,
                            inputFormatters: [NumericInputFormatter()],
                            keyboardType: TextInputType.number,
                            labelText: 'Unit Price',
                            filled: true,
                            filledColor: MyColors.lightBlue,
                            onTap: () {
                              if (controller.getAllProductModel == null &&
                                  controller.product == "") {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    message: "Please Select Product",
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
                        )
                      : Expanded(
                          child: CustomTextField2(
                            readOnly: false,
                            inputBorder: const OutlineInputBorder(),
                            controller: controller.sellingCostController,
                            inputFormatters: [NumericInputFormatter()],
                            keyboardType: TextInputType.number,
                            labelText: 'Unit Price',
                            filled: false,
                            filledColor: MyColors.lightBlue,
                            onTap: () {
                              if (controller.getAllProductModel == null &&
                                  controller.product == "") {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    message: "Please Select Product",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      "FOC",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: MyColors.black),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isFOCSelected = !isFOCSelected;
                        });
                      },
                      icon: Icon(isFOCSelected
                          ? Icons.remove_circle_outline_sharp
                          : Icons.add_circle_outline_sharp))
                ],
              ),
              isFOCSelected
                  ? Row(
                      children: [
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            controller: controller.focCartonController,
                            inputFormatters: [NumericInputFormatter()],
                            keyboardType: TextInputType.number,
                            labelText: "Carton",
                            onChanged: (value) async {
                              firstCartonCalculationFoc(value);
                              updateTotalFoc();
                            },
                            onTap: () {
                              if (controller.getAllProductModel == null &&
                                  controller.product == "") {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    message: "Please Select Product",
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            controller: controller.focUnitController,
                            inputFormatters: [NumericInputFormatter()],
                            keyboardType: TextInputType.number,
                            labelText: "Unit",
                            onChanged: (value) async {
                              firstUnitCalculationFoc(value);
                              updateTotalFoc();
                            },
                            onTap: () {
                              if (controller.getAllProductModel == null &&
                                  controller.product == "") {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    message: "Please Select Product",
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            controller: controller.focQtyController,
                            inputFormatters: [NumericInputFormatter()],
                            keyboardType: TextInputType.number,
                            labelText: 'Qty',
                            onChanged: (value) async {
                              reverseCalculationFoc(value);
                              updateTotalFoc();
                            },
                            onTap: () {
                              if (controller.getAllProductModel == null &&
                                  controller.product == "") {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    message: "Please Select Product",
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
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      "Exchange",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: MyColors.black),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isExchangeSelected = !isExchangeSelected;
                        });
                      },
                      icon: Icon(isExchangeSelected
                          ? Icons.remove_circle_outline_sharp
                          : Icons.add_circle_outline_sharp))
                ],
              ),
              isExchangeSelected
                  ? Row(
                      children: [
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            controller: controller.exchangeCartonController,
                            inputFormatters: [NumericInputFormatter()],
                            keyboardType: TextInputType.number,
                            labelText: "Carton",
                            onChanged: (value) async {
                              firstCartonCalculationExg(value);
                              updateTotalExg();
                            },
                            onTap: () {
                              if (controller.getAllProductModel == null &&
                                  controller.product == "") {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    message: "Please Select Product",
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            controller: controller.exchangeUnitController,
                            inputFormatters: [NumericInputFormatter()],
                            keyboardType: TextInputType.number,
                            labelText: "Unit",
                            onChanged: (value) async {
                              firstUnitCalculationExg(value);
                              updateTotalExg();
                            },
                            onTap: () {
                              if (controller.getAllProductModel == null &&
                                  controller.product == "") {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    message: "Please Select Product",
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            controller: controller.exchangeQtyController,
                            inputFormatters: [NumericInputFormatter()],
                            keyboardType: TextInputType.number,
                            labelText: 'Qty',
                            onChanged: (value) async {
                              reverseCalculationExg(value);
                              updateTotalExg();
                            },
                            onTap: () {
                              if (controller.getAllProductModel == null &&
                                  controller.product == "") {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    message: "Please Select Product",
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
                    )
                  : Container(),
              isExchangeSelected
                  ? const SizedBox(
                      height: 15,
                    )
                  : Container(),
              const SizedBox(height: 15),
              controller.productList!.isEmpty ? Container() : listView()
            ],
          ),
        ),
      );
    });
  }

  // listView() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         color: MyColors.grey,
  //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Table(
  //               columnWidths: const {
  //                 0: FlexColumnWidth(0.5),
  //                 1: FlexColumnWidth(),
  //               },
  //               children: [
  //                 TableRow(children: [
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       'Code',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w700,
  //                           fontFamily: MyFont.myFont2),
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       'Description',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w700,
  //                           fontFamily: MyFont.myFont2),
  //                     ),
  //                   ),
  //                 ]),
  //               ],
  //             ),
  //             const SizedBox(height: 5),
  //             Table(
  //               columnWidths: const {
  //                 0: FlexColumnWidth(),
  //                 1: FlexColumnWidth(),
  //                 2: FlexColumnWidth(),
  //               },
  //               children: [
  //                 TableRow(children: [
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       'Carton',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w700,
  //                           fontFamily: MyFont.myFont2),
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       'Unit',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w700,
  //                           fontFamily: MyFont.myFont2),
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       'Qty',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w700,
  //                           fontFamily: MyFont.myFont2),
  //                     ),
  //                   ),
  //                 ])
  //               ],
  //             ),
  //             const SizedBox(height: 5),
  //             Table(
  //               columnWidths: const {
  //                 0: FlexColumnWidth(),
  //                 1: FlexColumnWidth(),
  //                 2: FlexColumnWidth(),
  //               },
  //               children: [
  //                 TableRow(children: [
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       'C Price',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w700,
  //                           fontFamily: MyFont.myFont2),
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       'U Price',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w700,
  //                           fontFamily: MyFont.myFont2),
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       'Amt',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.bold,
  //                           fontFamily: MyFont.myFont2),
  //                     ),
  //                   ),
  //                 ])
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //
  //     ],
  //   );
  // }
  listView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: MyColors.grey,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            MyColors.gradient1,
            MyColors.gradient2,
            MyColors.gradient3,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Table(
                border: const TableBorder(
                    verticalInside: BorderSide(color: MyColors.lightBlue),
                    bottom: BorderSide(color: MyColors.lightBlue),
                    top: BorderSide(color: MyColors.gradient3),
                    left: BorderSide(color: MyColors.gradient3),
                    right: BorderSide(color: MyColors.gradient3)),
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Code',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 3, bottom: 3, left: width(context) / 11),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Description',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
              // const SizedBox(height: 5),
              Table(
                border: const TableBorder(
                    verticalInside: BorderSide(color: MyColors.lightBlue),
                    bottom: BorderSide(color: MyColors.lightBlue),
                    left: BorderSide(color: MyColors.gradient3),
                    right: BorderSide(color: MyColors.gradient3)),
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Carton',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Unit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Qty/Wt',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                    ),
                  ])
                ],
              ),
              // const SizedBox(height: 5),
              Table(
                border: const TableBorder(
                    verticalInside: BorderSide(color: MyColors.lightBlue),
                    bottom: BorderSide(color: MyColors.gradient3),
                    left: BorderSide(color: MyColors.gradient3),
                    right: BorderSide(color: MyColors.gradient3)),
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'C Price',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'U Price',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Amt',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                    ),
                  ])
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.productList?.length,
              itemBuilder: (context, index) {
                SalesOrderDetail? values = controller.productList?[index];
                if (controller.productList != null) {
                  controller.summaryListUnitPrice =
                      values!.pcsQty! * values.price!;
                  controller.summaryListCartPrice =
                      values.boxQty! * values.boxPrice!;

                  controller.total = controller.summaryListUnitPrice +
                      controller.summaryListCartPrice;
                }
                return GestureDetector(
                  onTapDown: (position) {
                    // _getTapPosition(position);
                    // _showContextMenu(context, index);
                  },
                  child: Container(
                    // color: MyColors.greyText,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(),
                          },
                          children: [
                            TableRow(children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  values?.productCode ?? "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: MyFont.myFont2),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  values?.productName ?? "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: MyFont.myFont2),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  child: const Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: MyColors.red,
                                  ),
                                  onTap: () {
                                    if (index >= 0 &&
                                        index <
                                            controller.productList!.length) {
                                      setState(() {
                                        controller.productList?.removeAt(index);
                                      });
                                    }
                                  },
                                ),
                              ),
                            ]),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(),
                            1: FlexColumnWidth(),
                            2: FlexColumnWidth(),
                          },
                          children: [
                            TableRow(children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  values?.boxQty?.toStringAsFixed(0) ?? "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: MyFont.myFont2),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  values?.pcsQty?.toStringAsFixed(0) ?? "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: MyFont.myFont2),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  values?.isWeight == false
                                      ? values?.qty?.toStringAsFixed(0) ?? '0'
                                      : values?.weight?.toStringAsFixed(2) ??
                                          '0',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: MyFont.myFont2),
                                ),
                              ),
                            ])
                          ],
                        ),
                        const SizedBox(height: 5),
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(),
                            1: FlexColumnWidth(),
                            2: FlexColumnWidth(),
                          },
                          children: [
                            TableRow(children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  values?.boxPrice?.toStringAsFixed(2) ??
                                      "0.00",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: MyFont.myFont2),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  values?.price?.toStringAsFixed(2) ?? "0.00",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: MyFont.myFont2),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  values?.subTotal?.toStringAsFixed(2) ??
                                      '0.00',
                                  // controller.total?.toStringAsFixed(2) ??
                                  //     "0.00",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: MyFont.myFont2),
                                ),
                              ),
                            ])
                          ],
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  onTap1() {
    var qty = (controller.stockQtyController.text.isNotEmpty)
        ? int.parse(controller.stockQtyController.text)
        : 0;
    var weight = (controller.weightController.text.isNotEmpty)
        ? int.parse(controller.weightController.text)
        : 0;
    FocusScope.of(context).unfocus();
    if (controller.isWeight == false &&
            controller.stockQtyController.text.isEmpty ||
        controller.stockQtyController.text == "0" ||
        qty < 1) {
      print('It\'s a ONTAP 1 method');
      Get.showSnackbar(
        const GetSnackBar(
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          message: "Select product and enter atleast one Qty",
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      var subtotal = (controller.stockUnitController.text.isNotEmpty
                  ? int.parse(controller.stockUnitController.text)
                  : 0) *
              (controller.getProductListByCodeList.first.unitCost!) +
          (controller.stockCartonController.text.isNotEmpty
                  ? int.parse(controller.stockCartonController.text)
                  : 0) *
              (controller.getProductListByCodeList.first.cartonPrice!);
      SalesOrderDetail? salesOrderDetail = SalesOrderDetail(
        orgId: controller.getProductListByCodeList.first.orgId,
        productName: controller.getProductListByCodeList.first.productName,
        productCode: controller.getProductListByCodeList.first.productCode,
        stockBoxQty: controller.stockCartonController.text.isNotEmpty
            ? int.parse(controller.stockCartonController.text)
            : 0,
        stockPcsQty: controller.stockUnitController.text.isNotEmpty
            ? int.parse(controller.stockUnitController.text)
            : 0,
        stockQty: controller.stockQtyController.text.isNotEmpty
            ? double.parse(controller.stockQtyController.text)
            : 0,
        boxQty: controller.stockCartonController.text.isNotEmpty
            ? int.parse(controller.stockCartonController.text)
            : 0,
        pcsQty: controller.stockUnitController.text.isNotEmpty
            ? int.parse(controller.stockUnitController.text)
            : 0,
        qty: controller.stockQtyController.text.isNotEmpty
            ? int.parse(controller.stockQtyController.text)
            : 0,
        weight: controller.weightController.text.isNotEmpty
            ? double.parse(controller.weightController.text)
            : 0.00,
        boxPrice:
            controller.getProductListByCodeList.first.cartonPrice!.toDouble(),
        price: controller.getProductListByCodeList.first.unitCost!.toDouble(),
        subTotal: subtotal.toDouble(),
        tax: (((controller.stockUnitController.text.isNotEmpty
                    ? int.parse(controller.stockUnitController.text)
                    : 0 *
                        controller
                            .getProductListByCodeList.first.sellingCost!) +
                (controller.getProductListByCodeList.first.boxcount *
                    controller
                        .getProductListByCodeList.first.sellingBoxCost!)) *
            controller.taxModel.first.taxPercentage!.toDouble() /
            100),
        netTotal: (((controller.stockUnitController.text.isNotEmpty
                        ? int.parse(controller.stockUnitController.text)
                        : 0 *
                            controller
                                .getProductListByCodeList.first.sellingCost!) +
                    (controller.getProductListByCodeList.first.boxcount *
                        controller
                            .getProductListByCodeList.first.sellingBoxCost!)) *
                controller.taxModel.first.taxPercentage!.toDouble() /
                100) +
            subtotal,
        fSubTotal: subtotal.toDouble(),
        fTax: (((controller.stockUnitController.text.isNotEmpty
                    ? int.parse(controller.stockUnitController.text)
                    : 0 *
                        controller
                            .getProductListByCodeList.first.sellingCost!) +
                (controller.getProductListByCodeList.first.boxcount *
                    controller
                        .getProductListByCodeList.first.sellingBoxCost!)) *
            controller.taxModel.first.taxPercentage!.toDouble() /
            100),
        fNetTotal: (((controller.stockUnitController.text.isNotEmpty
                        ? int.parse(controller.stockUnitController.text)
                        : 0 *
                            controller
                                .getProductListByCodeList.first.sellingCost!) +
                    (controller.getProductListByCodeList.first.boxcount *
                        controller
                            .getProductListByCodeList.first.sellingBoxCost!)) *
                controller.taxModel.first.taxPercentage!.toDouble() /
                100) +
            subtotal,
        total: subtotal.toDouble(),
        boxCount: controller.cartonPcsCountController.text.isNotEmpty
            ? int.parse(controller.cartonPcsCountController.text)
            : 0,
        fPrice: controller.getProductListByCodeList.first.unitCost!.toDouble(),
        fBoxPrice:
            controller.getProductListByCodeList.first.cartonPrice!.toDouble(),
        fTotal: subtotal.toDouble(),
        foc: controller.focQtyController.text.isNotEmpty
            ? int.parse(controller.focQtyController.text)
            : 0,
        exchange: controller.exchangeQtyController.text.isNotEmpty
            ? int.parse(controller.exchangeQtyController.text)
            : 0,
      );
      bool isAlreadyAdded = (controller.productList ?? []).any(
          (element) => element.productCode == salesOrderDetail.productCode);
      if (!isAlreadyAdded) {
        controller.productList?.add(salesOrderDetail);
        clear();
        Get.showSnackbar(
          const GetSnackBar(
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            message: "Product Successfully added",
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
          ),
        );

        print("111111111111111111111111111");
      } else if (isAlreadyAdded) {
        var ietm = (controller.productList ?? []).indexWhere(
            (element) => element.productCode == salesOrderDetail.productCode);

        (controller.productList ?? [])[ietm] = salesOrderDetail;
        clear();
        Get.showSnackbar(
          const GetSnackBar(
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            message: "Product Successfully Updated",
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
          ),
        );
        print("111111111111111111111111111");
      } else {
        print("111111111111111111111111111");
        Get.showSnackbar(
          const GetSnackBar(
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            message: "This Product is already added",
            icon: Icon(
              Icons.error,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  onTap2() {
    var qty = (controller.stockQtyController.text.isNotEmpty)
        ? int.parse(controller.stockQtyController.text)
        : 0;
    var weight = (controller.weightController.text.isNotEmpty)
        ? double.parse(controller.weightController.text)
        : 0;
    FocusScope.of(context).unfocus();
    if (controller.isWeight == false && qty < 1) {
      print('It\'s a ONTAP 2 method');
      Get.showSnackbar(
        const GetSnackBar(
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          message: "Select product and enter atleast one Qty",
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (controller.isWeight == true && weight < 1) {
      Get.showSnackbar(
        const GetSnackBar(
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          message: "Select product and enter weight",
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      print('It\'s a ONTAP 2 else method');
      var subtotal = (controller.stockUnitController.text.isNotEmpty
                  ? int.parse(controller.stockUnitController.text)
                  : 0) *
              (controller.getProductListByCodeList.first.unitCost!) +
          (controller.stockCartonController.text.isNotEmpty
                  ? int.parse(controller.stockCartonController.text)
                  : 0) *
              (controller.getProductListByCodeList.first.cartonPrice!);
      double sellingCost = controller.sellingCostController.text.isNotEmpty
          ? double.parse(controller.sellingCostController.text)
          : 0.00;
      var wtSubTotal = (controller.weightController.text.isNotEmpty
              ? double.parse(controller.weightController.text)
              : 0) *
          sellingCost;

      SalesOrderDetail? salesOrderDetail = SalesOrderDetail(
        orgId: controller.getProductListByCodeList.first.orgId,
        productName: controller.getProductListByCodeList.first.productName,
        productCode: controller.getProductListByCodeList.first.productCode,
        stockBoxQty: controller.stockCartonController.text.isNotEmpty
            ? int.parse(controller.stockCartonController.text)
            : 0,
        stockPcsQty: controller.stockUnitController.text.isNotEmpty
            ? int.parse(controller.stockUnitController.text)
            : 0,
        stockQty: controller.stockQtyController.text.isNotEmpty
            ? double.parse(controller.stockQtyController.text)
            : 0,
        boxQty: controller.stockCartonController.text.isNotEmpty
            ? int.parse(controller.stockCartonController.text)
            : 0,
        pcsQty: controller.stockUnitController.text.isNotEmpty
            ? int.parse(controller.stockUnitController.text)
            : 0,
        qty: controller.stockQtyController.text.isNotEmpty
            ? int.parse(controller.stockQtyController.text)
            : 0,
        weight: controller.weightController.text.isNotEmpty
            ? double.parse(controller.weightController.text)
            : 0.00,
        isWeight: controller.isWeight,
        boxPrice:
            controller.getProductListByCodeList.first.cartonPrice!.toDouble(),
        price: controller.isWeight == false
            ? controller.getProductListByCodeList.first.unitCost!.toDouble()
            : controller.getProductListByCodeList.first.sellingCost!.toDouble(),
        subTotal: controller.isWeight == false
            ? subtotal.toDouble()
            : wtSubTotal.toDouble(),
        tax: (((controller.stockUnitController.text.isNotEmpty
                    ? int.parse(controller.stockUnitController.text)
                    : 0 *
                        controller
                            .getProductListByCodeList.first.sellingCost!) +
                (controller.getProductListByCodeList.first.boxcount *
                    controller
                        .getProductListByCodeList.first.sellingBoxCost!)) *
            controller.taxModel.first.taxPercentage!.toDouble() /
            100),
        netTotal: (((controller.stockUnitController.text.isNotEmpty
                        ? int.parse(controller.stockUnitController.text)
                        : 0 *
                            controller
                                .getProductListByCodeList.first.sellingCost!) +
                    (controller.getProductListByCodeList.first.boxcount *
                        controller
                            .getProductListByCodeList.first.sellingBoxCost!)) *
                controller.taxModel.first.taxPercentage!.toDouble() /
                100) +
            subtotal,
        fSubTotal: subtotal.toDouble(),
        fTax: (((controller.stockUnitController.text.isNotEmpty
                    ? int.parse(controller.stockUnitController.text)
                    : 0 *
                        controller
                            .getProductListByCodeList.first.sellingCost!) +
                (controller.getProductListByCodeList.first.boxcount *
                    controller
                        .getProductListByCodeList.first.sellingBoxCost!)) *
            controller.taxModel.first.taxPercentage!.toDouble() /
            100),
        fNetTotal: (((controller.stockUnitController.text.isNotEmpty
                        ? int.parse(controller.stockUnitController.text)
                        : 0 *
                            controller
                                .getProductListByCodeList.first.sellingCost!) +
                    (controller.getProductListByCodeList.first.boxcount *
                        controller
                            .getProductListByCodeList.first.sellingBoxCost!)) *
                controller.taxModel.first.taxPercentage!.toDouble() /
                100) +
            subtotal,
        total: subtotal.toDouble(),
        boxCount: controller.cartonPcsCountController.text.isNotEmpty
            ? int.parse(controller.cartonPcsCountController.text)
            : 0,
        fPrice: controller.getProductListByCodeList.first.unitCost!.toDouble(),
        fBoxPrice:
            controller.getProductListByCodeList.first.cartonPrice!.toDouble(),
        fTotal: subtotal.toDouble(),
        foc: controller.focQtyController.text.isNotEmpty
            ? int.parse(controller.exchangeQtyController.text)
            : 0,
        exchange: controller.focQtyController.text.isNotEmpty
            ? int.parse(controller.exchangeQtyController.text)
            : 0,
      );
      bool isAlreadyAdded = (controller.productList ?? []).any(
          (element) => element.productCode == salesOrderDetail.productCode);
      if (!isAlreadyAdded) {
        controller.productService
            .addToProductList(productList: salesOrderDetail);
        print('It\'s a ONTAP 2 not added method');
        clear();
        Get.showSnackbar(
          const GetSnackBar(
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            message: "Product Successfully added",
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
          ),
        );
      } else if (isAlreadyAdded) {
        var ietm = (controller.productList ?? []).indexWhere(
            (element) => element.productCode == salesOrderDetail.productCode);

        (controller.productList ?? [])[ietm] = salesOrderDetail;
        print('It\'s a ONTAP 2 else if method');
        clear();
        Get.showSnackbar(
          const GetSnackBar(
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            message: "Product Successfully Updated",
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        print("222222222223222222222");
        Get.showSnackbar(
          const GetSnackBar(
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            message: "This Product is already added",
            icon: Icon(
              Icons.error,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void clear() {
    controller.barcodeController.clear();
    controller.productNameController.clear();
    controller.stockCartonController.clear();
    controller.stockUnitController.clear();
    controller.stockQtyController.clear();
    controller.cartonPcsCountController.clear();
    controller.pcsPerUnitPrice.clear();
    controller.pcsPerCartonPrice.clear();
    controller.focCartonController.clear();
    controller.focUnitController.clear();
    controller.focQtyController.clear();
    controller.exchangeCartonController.clear();
    controller.exchangeUnitController.clear();
    controller.exchangeQtyController.clear();
    controller.weightController.clear();
    controller.sellingCostController.clear();
    controller.getAllProductModel = null;
  }

  firstUnitCalculationFoc(String value) {
    setState(() {
      if (value == "") {
        value = "0";
      }
      double unitQty = double.parse(value);
      print("UnitQty====$unitQty");
      if (controller.focCartonController.text != "" &&
          controller.focCartonController.text != "0") {
        double countOfPcsPerCarton =
            double.parse(controller.cartonPcsCountController.text);
        double cartonQty = double.parse(controller.focCartonController.text);

        ///TotalCartonQty111
        double totalCartonQty = countOfPcsPerCarton * cartonQty;
        print("TotalCartonQty>>>>>>>>>>>>>>$totalCartonQty");

        ///TotalQuantity
        double totalQty = unitQty + totalCartonQty;
        controller.focQtyController.text = totalQty.toStringAsFixed(0);
      } else {
        print("value=======$value");
        controller.focQtyController.text = unitQty.toStringAsFixed(0);
      }
    });
  }

  firstCartonCalculationFoc(String value) {
    print("value2====FirstCartonCalculation=======$value");

    setState(() {
      if (value == "") {
        value = "0";
      }
      double cartonQty = double.parse(value);
      if (controller.focUnitController.text != "" &&
          controller.focUnitController.text != "0") {
        print("cartonQty===========$value");

        double countOfPcsPerCarton =
            double.parse(controller.cartonPcsCountController.text);
        double unitQty = double.parse(controller.focUnitController.text);

        ///TotalCartonQty
        var totalCartonQty = countOfPcsPerCarton * cartonQty;
        print("TotalCartonQty>>>>>>>>>>>>>>$totalCartonQty");

        ///TotalQuantity
        double totalQty = unitQty + totalCartonQty;
        controller.focQtyController.text = totalQty.toStringAsFixed(0);

        controller.focQtyController.text = totalQty.toStringAsFixed(0);
      } else {
        print("value4 FirstCartonCalculation===========$value");

        double countOfPcsPerCarton =
            double.parse(controller.cartonPcsCountController.text);
        double totalCartonQty = cartonQty * countOfPcsPerCarton;

        controller.focQtyController.text = totalCartonQty.toStringAsFixed(0);
      }
    });
  }

  reverseCalculationFoc(String value) {
    print(value);
    setState(() {
      if (value == "") {
        value = "0";
      }
      double qty = double.parse(value);
      double countOfPcsPerCarton =
          double.parse(controller.cartonPcsCountController.text);
      if (countOfPcsPerCarton != 1) {
        double oneCartonQty =
            double.parse(controller.cartonPcsCountController.text);

        double boxSplit = (qty / oneCartonQty);

        if (oneCartonQty <= qty) {
          int roundedValue = boxSplit.toInt();
          controller.focCartonController.text = roundedValue.toStringAsFixed(0);
          double splitUnit = qty % oneCartonQty;
          controller.focUnitController.text = splitUnit.toStringAsFixed(0);
        } else if (oneCartonQty > qty) {
          controller.focUnitController.text = qty.toStringAsFixed(0);
          if (qty == 0) {
            controller.focUnitController.text = "";
          }
          controller.focCartonController.clear();
        } else {
          double splitUnit = qty % oneCartonQty;
          controller.focUnitController.text = '';
          controller.focCartonController.text = '';
        }
      }
      if (countOfPcsPerCarton == 1) {
        print("QTY..........$qty");
        controller.focUnitController.text = qty.toStringAsFixed(0);
        if (qty == 0) {
          controller.focUnitController.text = "";
        }
      }
    });
  }

  totalFunFoc() {
    double? cartonPrice =
        controller.getProductListByCodeList.first.sellingBoxCost;
    double? unitPrice = controller.getProductListByCodeList.first.sellingCost;
    int cartonQty = int.tryParse(controller.focCartonController.text) ?? 0;
    int unitQty = int.tryParse(controller.focUnitController.text) ?? 0;

    // print("unitTotalPrice.............$unitTotalPrice");

    if (controller.focUnitController.text == "") {
      totalPrice = cartonQty * cartonPrice!;
      tax = totalPrice *
          double.parse(controller.taxModel.first.taxPercentage.toString()) /
          100;
      if (controller.taxModel.first.taxName == "Inclusive") {
        netTotal = totalPrice;
      } else if (controller.taxModel.first.taxName == "Exclusive") {
        netTotal = totalPrice + tax;
      } else if (controller.taxModel.first.taxName == "GSTs") {
        netTotal = totalPrice + tax;
      } else {
        netTotal = totalPrice + tax;
      }
    } else if (controller.focCartonController.text == "") {
      totalPrice = unitQty * unitPrice!;
      tax = totalPrice *
          double.parse(controller.taxModel.first.taxPercentage.toString()) /
          100;
      if (controller.taxModel.first.taxName == "Inclusive") {
        netTotal = totalPrice;
      } else if (controller.taxModel.first.taxName == "Exclusive") {
        netTotal = totalPrice + tax;
      } else if (controller.taxModel.first.taxName == "GSTs") {
        netTotal = totalPrice + tax;
      } else {
        netTotal = totalPrice + tax;
      }
    } else {
      totalPrice = (cartonQty * cartonPrice!) + (unitQty * unitPrice!);
      tax = totalPrice *
          double.parse(controller.taxModel.first.taxPercentage.toString()) /
          100;
      if (controller.taxModel.first.taxName == "Inclusive") {
        netTotal = totalPrice;
      } else if (controller.taxModel.first.taxName == "Exclusive") {
        netTotal = totalPrice + tax;
      } else if (controller.taxModel.first.taxName == "GSTs") {
        netTotal = totalPrice + tax;
      } else {
        netTotal = totalPrice + tax;
      }
    }
    print("totalPrice..................$totalPrice");
  }

  void updateTotalFoc() {
    setState(() {
      totalFunFoc();
    });
  }

  firstUnitCalculationExg(String value) {
    setState(() {
      if (value == "") {
        value = "0";
      }
      double unitQty = double.parse(value);
      print("UnitQty====$unitQty");
      if (controller.exchangeCartonController.text != "" &&
          controller.exchangeCartonController.text != "0") {
        double countOfPcsPerCarton =
            double.parse(controller.cartonPcsCountController.text);
        double cartonQty =
            double.parse(controller.exchangeCartonController.text);

        ///TotalCartonQty111
        double totalCartonQty = countOfPcsPerCarton * cartonQty;
        print("TotalCartonQty>>>>>>>>>>>>>>$totalCartonQty");

        ///TotalQuantity
        double totalQty = unitQty + totalCartonQty;
        controller.exchangeQtyController.text = totalQty.toStringAsFixed(0);
      } else {
        print("value=======$value");
        controller.exchangeQtyController.text = unitQty.toStringAsFixed(0);
      }
    });
  }

  firstCartonCalculationExg(String value) {
    print("value2====FirstCartonCalculation=======$value");

    setState(() {
      if (value == "") {
        value = "0";
      }
      double cartonQty = double.parse(value);
      if (controller.exchangeUnitController.text != "" &&
          controller.exchangeUnitController.text != "0") {
        print("cartonQty===========$value");

        double countOfPcsPerCarton =
            double.parse(controller.cartonPcsCountController.text);
        double unitQty = double.parse(controller.exchangeUnitController.text);

        ///TotalCartonQty
        var totalCartonQty = countOfPcsPerCarton * cartonQty;
        print("TotalCartonQty>>>>>>>>>>>>>>$totalCartonQty");

        ///TotalQuantity
        double totalQty = unitQty + totalCartonQty;
        controller.exchangeQtyController.text = totalQty.toStringAsFixed(0);

        controller.exchangeQtyController.text = totalQty.toStringAsFixed(0);
      } else {
        print("value4 FirstCartonCalculation===========$value");

        double countOfPcsPerCarton =
            double.parse(controller.cartonPcsCountController.text);
        double totalCartonQty = cartonQty * countOfPcsPerCarton;

        controller.exchangeQtyController.text =
            totalCartonQty.toStringAsFixed(0);
      }
    });
  }

  reverseCalculationExg(String value) {
    print(value);
    setState(() {
      if (value == "") {
        value = "0";
      }
      double qty = double.parse(value);
      double countOfPcsPerCarton =
          double.parse(controller.cartonPcsCountController.text);
      if (countOfPcsPerCarton != 1) {
        double oneCartonQty =
            double.parse(controller.cartonPcsCountController.text);

        double boxSplit = (qty / oneCartonQty);

        if (oneCartonQty <= qty) {
          int roundedValue = boxSplit.toInt();
          controller.exchangeCartonController.text =
              roundedValue.toStringAsFixed(0);
          double splitUnit = qty % oneCartonQty;
          controller.exchangeUnitController.text = splitUnit.toStringAsFixed(0);
        } else if (oneCartonQty > qty) {
          controller.exchangeUnitController.text = qty.toStringAsFixed(0);
          if (qty == 0) {
            controller.exchangeUnitController.text = "";
          }
          controller.exchangeCartonController.clear();
        } else {
          double splitUnit = qty % oneCartonQty;
          controller.exchangeUnitController.text = '';
          controller.exchangeCartonController.text = '';
        }
      }
      if (countOfPcsPerCarton == 1) {
        print("QTY..........$qty");
        controller.exchangeUnitController.text = qty.toStringAsFixed(0);
        if (qty == 0) {
          controller.exchangeUnitController.text = "";
        }
      }
    });
  }

  totalFunExg() {
    double? cartonPrice =
        controller.getProductListByCodeList.first.sellingBoxCost;
    double? unitPrice = controller.getProductListByCodeList.first.sellingCost;
    int cartonQty = int.tryParse(controller.exchangeCartonController.text) ?? 0;
    int unitQty = int.tryParse(controller.exchangeUnitController.text) ?? 0;

    // print("unitTotalPrice.............$unitTotalPrice");

    if (controller.exchangeUnitController.text == "") {
      totalPrice = cartonQty * cartonPrice!;
      tax = totalPrice *
          double.parse(controller.taxModel.first.taxPercentage.toString()) /
          100;
      if (controller.taxModel.first.taxName == "Inclusive") {
        netTotal = totalPrice;
      } else if (controller.taxModel.first.taxName == "Exclusive") {
        netTotal = totalPrice + tax;
      } else if (controller.taxModel.first.taxName == "GSTs") {
        netTotal = totalPrice + tax;
      } else {
        netTotal = totalPrice + tax;
      }
    } else if (controller.exchangeCartonController.text == "") {
      totalPrice = unitQty * unitPrice!;
      tax = totalPrice *
          double.parse(controller.taxModel.first.taxPercentage.toString()) /
          100;
      if (controller.taxModel.first.taxName == "Inclusive") {
        netTotal = totalPrice;
      } else if (controller.taxModel.first.taxName == "Exclusive") {
        netTotal = totalPrice + tax;
      } else if (controller.taxModel.first.taxName == "GSTs") {
        netTotal = totalPrice + tax;
      } else {
        netTotal = totalPrice + tax;
      }
    } else {
      totalPrice = (cartonQty * cartonPrice!) + (unitQty * unitPrice!);
      tax = totalPrice *
          double.parse(controller.taxModel.first.taxPercentage.toString()) /
          100;
      if (controller.taxModel.first.taxName == "Inclusive") {
        netTotal = totalPrice;
      } else if (controller.taxModel.first.taxName == "Exclusive") {
        netTotal = totalPrice + tax;
      } else if (controller.taxModel.first.taxName == "GSTs") {
        netTotal = totalPrice + tax;
      } else {
        netTotal = totalPrice + tax;
      }
    }
    print("totalPrice..................$totalPrice");
  }

  void updateTotalExg() {
    setState(() {
      totalFunExg();
    });
  }
}
