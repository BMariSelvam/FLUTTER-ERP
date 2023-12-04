import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Model/GetAllCountry.dart';
import 'package:erp/Model/GetAllCurrencyModel.dart';
import 'package:erp/Model/GetAllTaxModel.dart';
import 'package:erp/Model/RequestModel/CreateCustomerModel.dart';
import 'package:erp/screens/masters/customer/add_customer_controller.dart';
import 'package:erp/screens/masters/tax/tax_list_controller.dart';
import 'package:erp/screens/sales/receipt/add_receipt_controller.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:erp/widgets/search_dropdown_textfield2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  late AddCustomerController addCustomerController;
  late AddReceiptController currencyController;
  late TaxListController taxController;

  @override
  void initState() {
    super.initState();
    addCustomerController = Get.put(AddCustomerController());
    addCustomerController.countryListGet();
    currencyController = Get.put(AddReceiptController());
    currencyController.currencyListGet();
    taxController = Get.put(TaxListController());
    taxController.taxListGet();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCustomerController>(builder: (logic) {
      if (logic.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Form(
        key: addCustomerController.addCustomerKey,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  IconAssets.leftIcon,
                  color: MyColors.white,
                  scale: 1.3,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Image.asset(
                    IconAssets.search,
                    scale: 1.8,
                  ),
                )
              ],
              titleSpacing: -15,
              title: Text(
                "Master",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 0.5,
                    color: MyColors.white),
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    MyColors.gradient1,
                    MyColors.gradient2,
                    MyColors.gradient3,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
            ),
            backgroundColor: MyColors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Customer',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.heading354038),
                        ),
                        // SizedBox(width: MediaQuery.of(context).size.width * 0.42,),
                        FlutterSwitch(
                            width: 100,
                            activeText: 'Active',
                            activeColor: Colors.green,
                            activeTextColor: MyColors.white,
                            showOnOff: true,
                            inactiveText: 'Inactive',
                            inactiveTextColor: Colors.white70,
                            value: addCustomerController.selected,
                            onToggle: (val) {
                              setState(() {
                                addCustomerController.selected = val;
                              });
                            })
                      ],
                    ),
                  ),
                  CustomTextField2(
                    readOnly: true,
                    inputBorder: InputBorder.none,
                    controller: addCustomerController.customerCodeController,
                    keyboardType: TextInputType.text,
                    labelText: "Customer Code",
                    // suffixIcon: const Icon(Icons.search, color: MyColors.greyIcon),
                  ),
                  CustomTextField2(
                    inputBorder: const OutlineInputBorder(),
                    controller: addCustomerController.customerNameController,
                    keyboardType: TextInputType.text,
                    labelText: "Customer Name",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please Enter Customer Name';
                      }
                      return null;
                    },
                    // hintText: 'AppXperts Enterprise Solutions',
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: MyColors.greyIcon,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please Enter Address';
                            }
                            return null;
                          },
                          controller: addCustomerController.address1Controller,
                          decoration: InputDecoration(
                              hintText: 'Address Line 1',
                              hintStyle: TextStyle(
                                  fontFamily: MyFont.myFont2,
                                  fontSize: 13,
                                  color: MyColors.greyText),
                              suffixIcon: const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                              suffixIconColor: MyColors.greyIcon),
                        ),
                        TextFormField(
                          controller: addCustomerController.address2Controller,
                          decoration: InputDecoration(
                              hintText: 'Address Line 2',
                              hintStyle: TextStyle(
                                  fontFamily: MyFont.myFont2,
                                  fontSize: 13,
                                  color: MyColors.greyText),
                              suffixIcon: const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                              suffixIconColor: MyColors.greyIcon),
                        ),
                        TextFormField(
                          controller: addCustomerController.address3Controller,
                          decoration: InputDecoration(
                              hintText: 'Address Line 3',
                              hintStyle: TextStyle(
                                  fontFamily: MyFont.myFont2,
                                  fontSize: 13,
                                  color: MyColors.greyText),
                              suffixIcon: const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                              suffixIconColor: MyColors.greyIcon),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Obx(() {
                      return SearchDropdownTextField2<GetAllCountry>(
                          labelText: 'Country',
                          hintText: 'Select atleast one country',
                          suffixIcon: Icon(
                            Icons.expand_circle_down_outlined,
                            color: MyColors.black.withOpacity(0.4),
                          ),
                          items: addCustomerController.getCountryList.value,
                          color: Colors.black54,
                          selectedItem: addCustomerController.getCountryModel,
                          isValidator: true,
                          errorMessage: '*',
                          onAddPressed: () {
                            setState(() {
                              addCustomerController.country = "";
                              addCustomerController.getCountryModel = null;
                            });
                          },
                          onChanged: (value) async {
                            FocusScope.of(context).unfocus();
                            addCustomerController.getCountryModel = value;
                            addCustomerController.country = value.countryName;
                            setState(() {
                              addCustomerController.country = value.countryName;
                              addCustomerController.countryController.text =
                                  value.countryName ?? "";
                            });
                          });
                    }),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField2(
                          inputBorder: const OutlineInputBorder(),
                          controller: addCustomerController.postCodeController,
                          keyboardType: TextInputType.number,
                          labelText: "Post Code",
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please Enter Postal code';
                            }
                            return null;
                          },
                          // hintText: "Post Code",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 10),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                  colors: [
                                    MyColors.gradient1,
                                    MyColors.gradient2,
                                    MyColors.gradient3,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                //make color or elevated button transparent
                              ),
                              onPressed: () {},
                              child: const Text(
                                'FETCH',
                                style: TextStyle(
                                    color: MyColors.white, fontSize: 15),
                              )),
                        ),
                      )
                    ],
                  ),
                  CustomTextField2(
                    inputBorder: const OutlineInputBorder(),
                    controller: addCustomerController.phoneNoController,
                    keyboardType: TextInputType.number,
                    labelText: "Phone No.",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please Enter Phone No';
                      }
                      return null;
                    },
                    // hintText: "32154 22226",
                  ),
                  CustomTextField2(
                    inputBorder: const OutlineInputBorder(),
                    controller: addCustomerController.mobileNoController,
                    keyboardType: TextInputType.number,
                    labelText: "Mobile No",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please Enter Mobile No';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Obx(() {
                      return SearchDropdownTextField2<GetTaxModel>(
                          labelText: 'Tax Type',
                          hintText: 'Select atleast one Tax type',
                          suffixIcon: Icon(
                            Icons.expand_circle_down_outlined,
                            color: MyColors.black.withOpacity(0.4),
                          ),
                          items: taxController.getTaxList.value,
                          color: Colors.black54,
                          selectedItem: taxController.getTaxModel,
                          isValidator: true,
                          errorMessage: '*',
                          onAddPressed: () {
                            setState(() {
                              taxController.tax = "";
                              taxController.getTaxModel = null;
                            });
                          },
                          onChanged: (value) async {
                            FocusScope.of(context).unfocus();
                            taxController.getTaxModel = value;
                            taxController.tax = value.taxName;
                            setState(() {
                              taxController.tax = value.taxName;
                              addCustomerController.currencyController.text =
                                  value.taxName ?? "";
                            });
                          });
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Obx(() {
                      return SearchDropdownTextField2<GetAllCurrencyModel>(
                          labelText: 'Currency',
                          hintText: 'Select atleast one Currency',
                          suffixIcon: Icon(
                            Icons.expand_circle_down_outlined,
                            color: MyColors.black.withOpacity(0.4),
                          ),
                          items: currencyController.getCurrencyList.value,
                          color: Colors.black54,
                          selectedItem: currencyController.getCurrencyModel,
                          isValidator: true,
                          errorMessage: '*',
                          onAddPressed: () {
                            setState(() {
                              currencyController.currency = "";
                              currencyController.getCurrencyModel = null;
                            });
                          },
                          onChanged: (value) async {
                            FocusScope.of(context).unfocus();
                            currencyController.getCurrencyModel = value;
                            currencyController.currency = value.name;
                            setState(() {
                              currencyController.currency = value.name;
                              currencyController.currencyController.text =
                                  value.name ?? "";
                            });
                          });
                    }),
                  ),
                  // CustomTextField2(
                  //   inputBorder: const OutlineInputBorder(),
                  //   controller: taxTypeController,
                  //   keyboardType: TextInputType.name,
                  //   labelText: "Delivery Number",
                  //   // hintText: "0023",
                  // ),
                  // CustomTextField2(
                  //   inputBorder: const OutlineInputBorder(),
                  //   controller: taxTypeController,
                  //   keyboardType: TextInputType.name,
                  //   labelText: "Delivery Name",
                  //   // hintText: "Mohan",
                  // ),
                  // CustomTextField2(
                  //   inputBorder: const OutlineInputBorder(),
                  //   controller: taxTypeController,
                  //   keyboardType: TextInputType.name,
                  //   labelText: "Delivery Address",
                  //   // hintText: "Address 1",
                  //   suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                  //       color: MyColors.mainTheme),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (addCustomerController.addCustomerKey.currentState!
                          .validate()) {
                        addCustomerController.addCustomerKey.currentState!
                            .save();
                        addCustomerController.createCustomerModel =
                            CreateCustomerModel(
                          orgId: 1,
                          code: '',
                          name:
                              addCustomerController.customerNameController.text,
                          customerGroup: '',
                          remarks: '',
                          customerType: '',
                          taxType: taxController.tax,
                          uniqueNo: '',
                          mail: '',
                          addressLine1:
                              addCustomerController.address1Controller.text,
                          addressLine2:
                              addCustomerController.address2Controller.text,
                          addressLine3:
                              addCustomerController.address3Controller.text,
                          countryId: '',
                          postalCode:
                              addCustomerController.postCodeController.text,
                          mobile: addCustomerController.mobileNoController.text,
                          phone: addCustomerController.phoneNoController.text,
                          fax: '',
                          currencyId: '',
                          taxTypeId: '',
                          directorName: '',
                          directorPhone: '',
                          directorMobile: '',
                          directorMail: '',
                          salesPerson: '',
                          paymentTerms: '',
                          source: '',
                          isActive: addCustomerController.selected,
                          isOutStanding: true,
                          createdBy: 'admin',
                          createdOn: addCustomerController.currentTimeandDate,
                          changedBy: 'admin',
                          changedOn: addCustomerController.currentTimeandDate,
                          activity1: '',
                          activity2: '',
                          contactPerson: '',
                          countryName:
                              addCustomerController.countryController.text,
                          priceSettings: '',
                          creditLimit: 0,
                          outstandingAmount: 0,
                          taxPerc: 0,
                          account: '',
                          isVisited: 0,
                          visitedNo: 0,
                          visitedDate: addCustomerController.currentTimeandDate,
                          password: '',
                          contactType: '',
                          currencyRate: 0,
                          currencyValue: 0,
                          orgRefCode: '',
                        );
                        addCustomerController.onSaved();
                      }
                      //   // => Get.to(const SuccessfullyMsgScreen(
                      //   //     name: 'Customer Saved Successfully..!',
                      //   //     filename: AppRoutes.supplierList)),
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      // height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                MyColors.gradient1,
                                MyColors.gradient2,
                                MyColors.gradient3,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Save',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: MyFont.myFont2,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: MyColors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  )
                ],
              ),
            )),
      );
    });
  }
}
