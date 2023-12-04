import 'package:erp/Model/GetAllCountry.dart';
import 'package:erp/Model/RequestModel/CreateCustomerModel.dart';
import 'package:erp/screens/masters/customer/add_customer_controller.dart';
import 'package:erp/widgets/search_dropdown_textfield2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../../../Model/GetAllCustomerModel.dart';
import '../../../widgets/Custom_TextField_2.dart';
import 'edit_customer_controller.dart';

class EditCustomer extends StatefulWidget {
  const EditCustomer({Key? key}) : super(key: key);

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  late EditCustomerController editController;
  late AddCustomerController addController;

  GetCustomerModel? customerModel;
  String? countryName;

  @override
  void initState() {
    super.initState();
    editController = Get.put(EditCustomerController());
    addController = Get.put(AddCustomerController());
    addController.countryListGet();
    customerModel = Get.arguments as GetCustomerModel;
    print("aaaaaaaaaaaaaaaaaaaaaa");
    print(customerModel?.name);
    print("aaaaaaaaaaaaaaaaaaaaaa");
    initialFunction();
  }

  initialFunction() {
    editController.customerCodeController.text = customerModel?.code ?? "";
    editController.customerNameController.text = customerModel?.name ?? "";
    editController.address1Controller.text = customerModel?.addressLine1 ?? "";
    editController.address2Controller.text = customerModel?.addressLine2 ?? "";
    editController.address3Controller.text = customerModel?.addressLine3 ?? "";
    editController.phoneNoController.text = customerModel?.phone ?? "";
    editController.mobileNoController.text = customerModel?.mobile ?? "";
    editController.postCodeController.text = customerModel?.postalCode ?? "";
    editController.selected = customerModel?.isActive as bool;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: editController.editCustomerKey,
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
                          value: editController.selected,
                          onToggle: (val) {
                            setState(() {
                              editController.selected = val;
                            });
                          })
                    ],
                  ),
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: InputBorder.none,
                  controller: editController.customerCodeController,
                  keyboardType: TextInputType.text,
                  labelText: "Customer Code",
                  // suffixIcon: const Icon(Icons.search, color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: editController.customerNameController,
                  keyboardType: TextInputType.datetime,
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
                        controller: editController.address1Controller,
                        decoration: InputDecoration(
                            hintText: 'Address Line 1',
                            hintStyle: TextStyle(
                                fontFamily: MyFont.myFont2,
                                color: MyColors.greyText),
                            suffixIcon: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                            suffixIconColor: MyColors.greyIcon),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please Enter Address';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: editController.address2Controller,
                        decoration: InputDecoration(
                            hintText: 'Address Line 2',
                            hintStyle: TextStyle(
                                fontFamily: MyFont.myFont2,
                                color: MyColors.greyText),
                            suffixIcon: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                            suffixIconColor: MyColors.greyIcon),
                      ),
                      TextFormField(
                        controller: editController.address3Controller,
                        decoration: InputDecoration(
                            hintText: 'Address Line 3',
                            hintStyle: TextStyle(
                                fontFamily: MyFont.myFont2,
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
                // CustomTextField2(
                //   inputBorder: const OutlineInputBorder(),
                //   controller: editController.countryController,
                //   keyboardType: TextInputType.datetime,
                //   labelText: "Country",
                //   // validator: (val) {
                //   //   if (val == null || val.isEmpty) {
                //   //     return 'Please Enter Country';
                //   //   }
                //   //   return null;
                //   // },
                //   // hintText: 'AppXperts Enterprise Solutions',
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Obx(() {
                    return SearchDropdownTextField2<GetAllCountry>(
                        labelText: 'Country',
                        hintText: 'Select atleast one country',
                        suffixIcon: Icon(
                          Icons.expand_circle_down_outlined,
                          color: MyColors.black.withOpacity(0.4),
                        ),
                        items: addController.getCountryList.value,
                        color: Colors.black54,
                        selectedItem: editController.getCountryModel,
                        isValidator: true,
                        errorMessage: '*',
                        onAddPressed: () {
                          setState(() {
                            editController.country = "";
                            editController.getCountryModel = null;
                          });
                        },
                        onChanged: (value) async {
                          FocusScope.of(context).unfocus();
                          editController.getCountryModel = value;
                          editController.country = value.countryName;
                          setState(() {
                            editController.country = value.countryName;
                            countryName = value.countryName ?? "";
                          });
                        });
                  }),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField2(
                        inputBorder: const OutlineInputBorder(),
                        controller: editController.postCodeController,
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
                      padding: const EdgeInsets.only(right: 10, top: 0),
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
                  controller: editController.phoneNoController,
                  keyboardType: TextInputType.number,
                  labelText: "Phone No.",
                  // hintText: "32154 22226",
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: editController.mobileNoController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: "Mobile No",
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: editController.taxTypeController,
                  keyboardType: TextInputType.name,
                  labelText: "Tax Type",
                  // hintText: "Inarchive",
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: MyColors.mainTheme),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: editController.taxTypeController,
                  keyboardType: TextInputType.name,
                  labelText: "Currency",
                  // hintText: "Inarchive",
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: MyColors.mainTheme),
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
                    if (editController.editCustomerKey.currentState!
                        .validate()) {
                      editController.editCustomerKey.currentState!.save();
                      addController.createCustomerModel = CreateCustomerModel(
                        orgId: 1,
                        code: editController.customerCodeController.text,
                        name: editController.customerNameController.text,
                        customerGroup: '',
                        remarks: '',
                        customerType: '',
                        taxType: '',
                        uniqueNo: '',
                        mail: '',
                        addressLine1: editController.address1Controller.text,
                        addressLine2: editController.address2Controller.text,
                        addressLine3: editController.address3Controller.text,
                        countryId: '',
                        postalCode: editController.postCodeController.text,
                        mobile: editController.mobileNoController.text,
                        phone: editController.phoneNoController.text,
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
                        isActive: editController.selected,
                        isOutStanding: true,
                        createdBy: 'admin',
                        createdOn: addController.currentTimeandDate,
                        changedBy: 'admin',
                        changedOn: addController.currentTimeandDate,
                        activity1: '',
                        activity2: '',
                        contactPerson: '',
                        countryName: editController.country,
                        priceSettings: '',
                        creditLimit: 0,
                        outstandingAmount: 0,
                        taxPerc: 0,
                        account: '',
                        isVisited: 0,
                        visitedNo: 0,
                        visitedDate: addController.currentTimeandDate,
                        password: '',
                        contactType: '',
                        currencyRate: 0,
                        currencyValue: 0,
                        orgRefCode: '',
                      );
                      addController.onSaved();
                    }
                  },
                  // => Get.to(const SuccessfullyMsgScreen(
                  //     name: 'Customer Saved Successfully..!',
                  //     filename: AppRoutes.supplierList)),
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
  }
}
