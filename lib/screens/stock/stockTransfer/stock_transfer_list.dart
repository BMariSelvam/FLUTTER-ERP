import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/appRoute.dart';
import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/custom_gradient.dart';
import '../../../Helper/fonts.dart';
import '../../../Helper/size.dart';
import '../../../widgets/Custom_TextField_2.dart';
import '../../../widgets/searchTextField.dart';
import '../../invoice/AllScreen.dart';

class StockTransferList extends StatefulWidget {
  const StockTransferList({Key? key}) : super(key: key);

  @override
  State<StockTransferList> createState() => _StockTransferListState();
}

TextEditingController searchController = TextEditingController();
TextEditingController fromController = TextEditingController();
TextEditingController toController = TextEditingController();
TextEditingController cusCodeController = TextEditingController();
bool isSelectedFilter = false;

class _StockTransferListState extends State<StockTransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          leading: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.bottomNavBarScreen);
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
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelectedFilter = !isSelectedFilter;
                  });
                },
                child: Image.asset(
                  IconAssets.search,
                  scale: 1.8,
                ),
              ),
            )
          ],
          titleSpacing: -15,
          title: Text(
            "Stock",
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
            child: Column(children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Stock Transfer',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: MyFont.myFont2,
                        fontWeight: FontWeight.bold,
                        color: MyColors.heading354038),
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.46,
                  // ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.addStockTransfer),
                    child: Container(
                      margin: const EdgeInsets.only(right: 4),
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                              colors: [
                                MyColors.gradient1,
                                MyColors.gradient2,
                                MyColors.gradient3,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            CustomGradient(
                                child: Image.asset(
                              IconAssets.personAddIcon,
                              scale: 1.6,
                            )),
                            const SizedBox(width: 6),
                            CustomGradient(
                                child: Text(
                              'Add',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
          ),
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
                    ),
                    const SizedBox(height: 5),
                    const Divider(
                      thickness: 2,
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
                          'Trans.No',
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
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 12),
                  child: Text(
                    'Perumbakkam to Singapore',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: MyFont.myFont2,
                        fontWeight: FontWeight.bold,
                        color: MyColors.black1D2226),
                  ),
                )
              ],
            ),
          );
        });
  }
}
