import 'package:erp/Helper/size.dart';
import 'package:erp/Model/RequestModel/CreateBrandModel.dart';
import 'package:erp/screens/product/brand/add_brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../../../widgets/Custom_TextField_2.dart';

class AddBrand extends StatefulWidget {
  const AddBrand({Key? key}) : super(key: key);

  @override
  State<AddBrand> createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  late AddBrandController addBrandController;

  @override
  void initState() {
    super.initState();
    addBrandController = Get.put(AddBrandController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addBrandController.addBrandKey,
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
              "Product",
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
                        'Brand',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            color: MyColors.heading354038),
                      ),
                      // SizedBox(width: MediaQuery.of(context).size.width * 0.53,),
                      FlutterSwitch(
                          width: 100,
                          activeText: 'Active',
                          activeColor: Colors.green,
                          activeTextColor: MyColors.white,
                          showOnOff: true,
                          inactiveText: 'Inactive',
                          inactiveTextColor: Colors.white70,
                          value: addBrandController.selected,
                          onToggle: (val) {
                            setState(() {
                              addBrandController.selected = val;
                            });
                          })
                    ],
                  ),
                ),
                CustomTextField2(
                  inputBorder: InputBorder.none,
                  controller: addBrandController.brandCodeController,
                  keyboardType: TextInputType.text,
                  labelText: "Brand Code",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter the Brand code";
                    }
                  },
                  // hintText: 'SRM Travels',
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addBrandController.brandController,
                  keyboardType: TextInputType.datetime,
                  labelText: "Brand Name",
                  // hintText: 'Tours and Travels',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter the Brand name";
                    }
                  },
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addBrandController.chineseNameController,
                  keyboardType: TextInputType.text,
                  labelText: "CHINESE NAME",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter the Chinese name";
                    }
                  },
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                  // hintText: "2322",
                ),
                // Container(
                //   padding: const EdgeInsets.all(20),
                //   margin: const EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       width: 1,
                //       color: MyColors.greyText,
                //     ),
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(18),
                //     ),
                //   ),
                //   child: SizedBox(
                //     height: MediaQuery.of(context).size.height * 0.15,
                //     width: MediaQuery.of(context).size.width * 0.9,
                //     child: Column(
                //       children: [
                //         const SizedBox(
                //           height: 10,
                //         ),
                //         Image.asset(IconAssets.uploadIcon),
                //         const SizedBox(
                //           height: 8,
                //         ),
                //         Text(
                //           'Click here to upload Photo/Video',
                //           style: TextStyle(color: hexStringToColor('B4B4B4')),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: height(context) / 2.8,
                ),
                InkWell(
                  onTap: () {
                    if (addBrandController.addBrandKey.currentState!
                        .validate()) {
                      addBrandController.addBrandKey.currentState!.save();
                      addBrandController.createBrandModel = CreateBrandModel(
                        code: addBrandController.brandCodeController.text,
                        name: addBrandController.brandController.text,
                        brandChineseDescription:
                            addBrandController.chineseNameController.text,
                        brandDisplayOrder: 0,
                        countryId: "",
                        logo: "",
                        isActive: addBrandController.selected,
                        isPOS: false,
                        isB2B: false,
                        isB2C: false,
                        isERP: false,
                        createdBy: 'admin',
                        createdOn: addBrandController.currentTimeAndDate,
                        changedBy: 'admin',
                        changedOn: addBrandController.currentTimeAndDate,
                        orgId: 1,
                        itemImage: '',
                        itemImageString: '',
                        organisationId: 0,
                        itemBrandId: '',
                        itemName: '',
                        itemId: '',
                      );
                      addBrandController.onSaved();
                    }
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
  }
}
