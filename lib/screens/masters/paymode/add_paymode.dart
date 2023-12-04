import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/RequestModel/CreatePaymodeModel.dart';
import 'package:erp/screens/masters/paymode/add_paymode_controller.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class AddPayMode extends StatefulWidget {
  const AddPayMode({Key? key}) : super(key: key);

  @override
  State<AddPayMode> createState() => _AddPayModeState();
}

class _AddPayModeState extends State<AddPayMode> {
  late AddPaymodeController addPaymodeController;

  @override
  void initState() {
    super.initState();
    addPaymodeController = Get.put(AddPaymodeController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addPaymodeController.addPaymodeKey,
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
                        'Paymode',
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
                          value: addPaymodeController.selected,
                          onToggle: (val) {
                            setState(() {
                              addPaymodeController.selected = val;
                            });
                          })
                    ],
                  ),
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: InputBorder.none,
                  controller: addPaymodeController.codeController,
                  keyboardType: TextInputType.text,
                  labelText: "Code",
                  // hintText: 'Udhaya Kumar',
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addPaymodeController.nameController,
                  keyboardType: TextInputType.text,
                  labelText: "Name",
                  // hintText: 'Cash',
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please Enter the Name';
                    }
                    return null;
                  },
                ),
                // CustomTextField2(
                //   inputBorder: const OutlineInputBorder(),
                //   controller: descriptionController,
                //   keyboardType: TextInputType.number,
                //   labelText: "Description",
                //   hintText: "Description One",
                //   suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                // ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'IS POS',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.w500,
                              color: MyColors.drakgreyText),
                        ),
                        Switch(
                            activeTrackColor: MyColors.primaryCustom,
                            value: addPaymodeController.isPos,
                            onChanged: (val) {
                              setState(() {
                                addPaymodeController.isPos = val;
                              });
                            }),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'IS B2B',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.w500,
                              color: MyColors.drakgreyText),
                        ),
                        Switch(
                            activeTrackColor: MyColors.primaryCustom,
                            value: addPaymodeController.isB2B,
                            onChanged: (val) {
                              setState(() {
                                addPaymodeController.isB2B = val;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'IS B2C',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.w500,
                              color: MyColors.drakgreyText),
                        ),
                        Switch(
                            activeTrackColor: MyColors.primaryCustom,
                            value: addPaymodeController.isB2C,
                            onChanged: (val) {
                              setState(() {
                                addPaymodeController.isB2C = val;
                              });
                            }),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'IS ERP',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.w500,
                              color: MyColors.drakgreyText),
                        ),
                        Switch(
                            activeTrackColor: MyColors.primaryCustom,
                            value: addPaymodeController.isERP,
                            onChanged: (val) {
                              setState(() {
                                addPaymodeController.isERP = val;
                              });
                            }),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: height(context) / 3.5),
                InkWell(
                  onTap: () {
                    if (addPaymodeController.addPaymodeKey.currentState!
                        .validate()) {
                      addPaymodeController.addPaymodeKey.currentState?.save();
                      addPaymodeController.createPaymodeModel =
                          CreatePaymodeModel(
                        orgId: 1,
                        code: '',
                        name: addPaymodeController.nameController.text,
                        displayOrder: 0,
                        isPOS: addPaymodeController.isPos,
                        isB2B: addPaymodeController.isB2B,
                        isB2C: addPaymodeController.isB2C,
                        isERP: addPaymodeController.isERP,
                        isActive: addPaymodeController.selected,
                        createdBy: 'admin',
                        createdOn: addPaymodeController.currentTimeAndDate,
                        changedBy: 'admin',
                        changedOn: addPaymodeController.currentTimeAndDate,
                      );
                      addPaymodeController.onSaved();
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
