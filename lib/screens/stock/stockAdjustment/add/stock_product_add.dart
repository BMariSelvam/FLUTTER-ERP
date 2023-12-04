import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/widgets/product_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Helper/appRoute.dart';
import '../../../successfully_msg_screen.dart';

class StockProductAdd extends StatefulWidget {
  const StockProductAdd({Key? key}) : super(key: key);

  @override
  State<StockProductAdd> createState() => _StockProductAddState();
}

TextEditingController cartonController = TextEditingController();
TextEditingController unitController = TextEditingController();
TextEditingController qtyController = TextEditingController();

class _StockProductAddState extends State<StockProductAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 15, top: 15, bottom: 6),
                    child: Row(
                      children: [
                        const CommonText(
                          text: 'Name       :    ',
                        ),
                        SizedBox(
                          width: width(context) / 1.6,
                          child: const CommonText(
                            text: 'Udhaya Kumar',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 25, right: 15, top: 5, bottom: 6),
                    child: Row(
                      children: [
                        CommonText(
                          text: 'ST.No        :    ',
                        ),
                        CommonText(
                          text: '7347863',
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 25, right: 15, top: 5, bottom: 6),
                    child: Row(
                      children: [
                        CommonText(
                          text: 'Date         :    ',
                        ),
                        CommonText(
                          text: '21/02/2023',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 15, top: 5, bottom: 6),
                    child: Row(
                      children: [
                        const CommonText(text: 'Remark    :    '),
                        SizedBox(
                          width: width(context) / 1.6,
                          child: const CommonText(
                            text: 'You can put Remark',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 18),
                          // height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: MyColors.containerEBEBEB,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Category',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont2,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              MyColors.black.withOpacity(0.6)),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: MyColors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 18),
                          // height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: MyColors.containerEBEBEB,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sub Category',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont2,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              MyColors.black.withOpacity(0.6)),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: MyColors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
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
                          'Product Name',
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
                    height: 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Available Stock',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProductTextFormField(
                                controller: cartonController,
                                inputBorder: InputBorder.none,
                                labelText: 'Carton',
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                              ),
                              ProductTextFormField(
                                controller: unitController,
                                inputBorder: InputBorder.none,
                                labelText: 'Unit',
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                              ),
                              ProductTextFormField(
                                controller: qtyController,
                                inputBorder: InputBorder.none,
                                labelText: 'Qty',
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                              ),
                            ],
                          )
                        ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Adjustment Stock',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProductTextFormField(
                                controller: cartonController,
                                inputBorder: InputBorder.none,
                                labelText: 'Carton',
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                              ),
                              ProductTextFormField(
                                controller: unitController,
                                inputBorder: InputBorder.none,
                                labelText: 'Unit',
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                              ),
                              ProductTextFormField(
                                controller: qtyController,
                                inputBorder: InputBorder.none,
                                labelText: 'Qty',
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                              ),
                            ],
                          )
                        ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'New Stock',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProductTextFormField(
                                controller: cartonController,
                                inputBorder: InputBorder.none,
                                labelText: 'Carton',
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                              ),
                              ProductTextFormField(
                                controller: unitController,
                                inputBorder: InputBorder.none,
                                labelText: 'Unit',
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                              ),
                              ProductTextFormField(
                                controller: qtyController,
                                inputBorder: InputBorder.none,
                                labelText: 'Qty',
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                              ),
                            ],
                          )
                        ]),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                            (Set<MaterialState> states) {
                      return const EdgeInsets.all(0);
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                // style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.zero,
                //     elevation: 0,
                // ),
                onPressed: () {},
                child: Ink(
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
                  child: Container(
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 35),
                    child: Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: MyColors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  elevation: 0,
                ),
                onPressed: () {
                  Get.to(SuccessfullyMsgScreen(
                      name: 'Stock Adjustment Successfully..!',
                      filename: Get.toNamed(AppRoutes.stockTakeList)));
                },
                child: Ink(
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
                  child: Container(
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: MyColors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class CommonText extends StatelessWidget {
  final String text;

  const CommonText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: MyFont.myFont2,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: MyColors.black.withOpacity(0.6)),
    );
  }
}
