import 'package:erp/Helper/appRoute.dart';
import 'package:erp/screens/successfully_msg_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../../../widgets/Custom_TextField_2.dart';

class AddSupplier extends StatefulWidget {
  const AddSupplier({Key? key}) : super(key: key);

  @override
  State<AddSupplier> createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  bool selected = false;
  TextEditingController supplierCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController logoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Supplier',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.heading354038),
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width * 0.45,),
                    FlutterSwitch(
                        width: 100,
                        activeText: 'Active',
                        activeColor: Colors.green,
                        activeTextColor: MyColors.white,
                        showOnOff: true,
                        inactiveText: 'Inactive',
                        inactiveTextColor: Colors.white70,
                        value: selected,
                        onToggle: (val) {
                          setState(() {
                            selected = val;
                          });
                        })
                  ],
                ),
              ),
              CustomTextField2(
                inputBorder: InputBorder.none,
                controller: supplierCodeController,
                keyboardType: TextInputType.text,
                labelText: "Supplier Code",
                hintText: '10AABCU9603R1Z2',
                suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: nameController,
                keyboardType: TextInputType.datetime,
                labelText: "Name",
                hintText: 'Mohan Kumar',
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: phoneNoController,
                keyboardType: TextInputType.number,
                labelText: "GST No",
                hintText: "10AABCU9603R1Z2",
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: MyColors.greyIcon,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Address 1',
                          suffixIcon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          suffixIconColor: MyColors.greyIcon),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Address 1',
                          suffixIcon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          suffixIconColor: MyColors.greyIcon),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Address 1',
                          suffixIcon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          suffixIconColor: MyColors.greyIcon),
                    )
                  ],
                ),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: supplierCodeController,
                keyboardType: TextInputType.name,
                labelText: "Phone No",
                hintText: "32154 22226",
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.mainTheme),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: mobileNoController,
                keyboardType: TextInputType.emailAddress,
                labelText: "Mobile No",
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: supplierCodeController,
                keyboardType: TextInputType.name,
                labelText: "Tax Type",
                hintText: "None",
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.mainTheme),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: supplierCodeController,
                keyboardType: TextInputType.name,
                labelText: "Email ID",
                hintText: "mohankumar.appxperts@gmail.com",
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: MyColors.greyText,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Image.asset(IconAssets.uploadIcon),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Click here to upload Photo/Video',
                        style: TextStyle(color: hexStringToColor('B4B4B4')),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Get.to(SuccessfullyMsgScreen(
                    name: 'Supplier Saved Successfully..!',
                    filename: Get.toNamed(AppRoutes.taxList))),
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
        ));
  }
}
