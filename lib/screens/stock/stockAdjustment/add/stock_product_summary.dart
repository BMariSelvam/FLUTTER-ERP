import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:erp/widgets/searchTextField.dart';
import 'package:flutter/material.dart';

import '../../../invoice/AllScreen.dart';

class StockProductSummaryList extends StatefulWidget {
  const StockProductSummaryList({Key? key}) : super(key: key);

  @override
  State<StockProductSummaryList> createState() =>
      _StockProductSummaryListState();
}

TextEditingController searchController = TextEditingController();
TextEditingController fromController = TextEditingController();
TextEditingController toController = TextEditingController();
TextEditingController cusCodeController = TextEditingController();
bool isSelectedFilter = false;

class _StockProductSummaryListState extends State<StockProductSummaryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          isSelectedFilter
              ? Column(
                  children: [
                    searchTextField(
                      inputBorder: InputBorder.none,
                      controller: searchController,
                      keyboardType: TextInputType.datetime,
                      hintText: "Search Customer",
                      suffixIcon: const Icon(Icons.search),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            controller: fromController,
                            keyboardType: TextInputType.datetime,
                            labelText: "From Loc",
                          ),
                        ),
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            controller: toController,
                            keyboardType: TextInputType.datetime,
                            labelText: "To Loc",
                          ),
                        ),
                      ],
                    ),
                    CustomTextField2(
                      inputBorder: const OutlineInputBorder(),
                      controller: cusCodeController,
                      keyboardType: TextInputType.datetime,
                      labelText: "Customer Code",
                      hintText: "33202",
                    ),
                    const SizedBox(
                      height: 10,
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
                            'Search',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: MyFont.myFont2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Container(),
          list(),
          const SizedBox(
            height: 18,
          )
        ])));
  }

  ListView list() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 2),
              ],
            ),
            margin: const EdgeInsets.only(
              top: 15,
              left: 18,
              right: 18,
              bottom: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 15,
                        left: 5,
                        right: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width(context) / 1.8,
                            child: Text(
                              "Udhaya Kumar",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.black1D2226),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 1, right: 10, top: 12),
                      padding: const EdgeInsets.only(
                        left: 1,
                        right: 3,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              MyColors.gradient1,
                              MyColors.gradient2,
                              MyColors.gradient3,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 5, right: 10, top: 3, bottom: 3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const CustomGradient(
                                  child: Icon(
                                    Icons.edit_document,
                                    color: MyColors.mainTheme,
                                    size: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                CustomGradient(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 9,
                                        color: MyColors.mainTheme),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const EditPopupMenuButton(),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1.2)
                    },
                    children: [
                      TableRow(children: [
                        Text(
                          'ST Number',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black5F5F5F),
                        ),
                        Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black5F5F5F),
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          'PO2023-00023',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black1D2226),
                        ),
                        Text(
                          '13/02/2023',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black1D2226),
                        ),
                      ])
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
