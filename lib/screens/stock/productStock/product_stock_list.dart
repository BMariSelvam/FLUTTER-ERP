import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../Helper/assets.dart';
import '../../../../Helper/colors.dart';
import '../../../../Helper/custom_gradient.dart';
import '../../../../Helper/fonts.dart';
import '../../../../Helper/size.dart';
import '../../../Helper/appRoute.dart';
import '../../../widgets/Custom_TextField_2.dart';
import '../../../widgets/searchTextField.dart';
import '../../invoice/AllScreen.dart';

class StockProductList extends StatefulWidget {
  const StockProductList({Key? key}) : super(key: key);

  @override
  State<StockProductList> createState() => _StockProductListState();
}

TextEditingController fromDatecontroller = TextEditingController();
TextEditingController toDatecontroller = TextEditingController();
TextEditingController customerCodecontroller = TextEditingController();
TextEditingController searchcontroller = TextEditingController();
bool isSelectedFilter = false;

class _StockProductListState extends State<StockProductList> {
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
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelectedFilter = !isSelectedFilter;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Image.asset(
                  IconAssets.search,
                  scale: 2,
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
                    'Product Stock',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: MyFont.myFont2,
                        fontWeight: FontWeight.bold,
                        color: MyColors.heading354038),
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  // ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.addStockProduct),
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
                      controller: searchcontroller,
                      keyboardType: TextInputType.datetime,
                      hintText: "Search Customer",
                      suffixIcon: const Icon(Icons.search),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            controller: fromDatecontroller,
                            keyboardType: TextInputType.datetime,
                            labelText: "From Date",
                            suffixIcon: const Icon(Icons.date_range),
                          ),
                        ),
                        Expanded(
                          child: CustomTextField2(
                            inputBorder: const OutlineInputBorder(),
                            controller: toDatecontroller,
                            keyboardType: TextInputType.datetime,
                            labelText: "To Date",
                            suffixIcon: const Icon(Icons.date_range),
                          ),
                        ),
                      ],
                    ),
                    CustomTextField2(
                      inputBorder: const OutlineInputBorder(),
                      controller: customerCodecontroller,
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
          const SizedBox(
            height: 10,
          ),
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
        itemCount: 5,
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Product Name',
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                color: MyColors.black5F5F5F),
                          ),
                          SizedBox(
                            width: width(context) / 1.8,
                            child: CustomGradient(
                              child: Text(
                                "Product Description",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: MyFont.myFont2,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.black1D2226),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 1,
                              right: 10,
                            ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                          ),
                          SizedBox(
                            height: height(context) / 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 1,
                              right: 10,
                            ),
                            child: LinearPercentIndicator(
                              curve: Curves.fastOutSlowIn,
                              width: 105,
                              animation: true,
                              lineHeight: 20.0,
                              barRadius: Radius.circular(5),
                              animationDuration: 2500,
                              center: Padding(
                                padding: const EdgeInsets.only(
                                  left: 1,
                                  right: 20,
                                ),
                                child: Text(
                                  "Q.Level",
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont2,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: MyColors.white),
                                ),
                              ),
                              percent: 0.8,
                              progressColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    columnWidths: const {
                      0: FlexColumnWidth(0.85),
                      2: FlexColumnWidth(0.5)
                    },
                    children: [
                      TableRow(children: [
                        Text(
                          'SKU Number',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black5F5F5F),
                        ),
                        Text(
                          'Stock Update Date',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black5F5F5F),
                        ),
                        Text(
                          'Quantity',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black5F5F5F),
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          'SKU-2652',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black1D2226),
                        ),
                        Text(
                          '03/24/2023',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black1D2226),
                        ),
                        Text(
                          '34',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black1D2226),
                        )
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
