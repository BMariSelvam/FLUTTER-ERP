import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/preferencehelper.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/screens/invoice/AllScreen.dart';
import 'package:erp/screens/purchase/payment/payment_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({Key? key}) : super(key: key);

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  late PaymentListController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(PaymentListController());
    controller.paymentListGet();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentListController>(builder: (logic) {
      if (logic.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

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
                child: Image.asset(
                  IconAssets.search,
                  scale: 1.8,
                ),
              )
            ],
            titleSpacing: -15,
            title: Text(
              "Purchase",
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
                      'Payment',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.heading354038),
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.48,
                    // ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.addPayment),
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
            list(),
            const SizedBox(
              height: 18,
            )
          ])));
    });
  }

  ListView list() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.getPayment.value?.length,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text(
                            'Supplier Name',
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
                                controller.getPayment.value![index]
                                        .supplierName ??
                                    '',
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
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
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
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    columnWidths: const {
                      0: FlexColumnWidth(1.0),
                      2: FlexColumnWidth(0.6)
                    },
                    children: [
                      TableRow(children: [
                        Text(
                          'TRAN Number',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black5F5F5F),
                        ),
                        Text(
                          'TRAN Date',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black5F5F5F),
                        ),
                        Text(
                          'Amount',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black5F5F5F),
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          controller.getPayment.value![index].tranNo ?? '',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black1D2226),
                        ),
                        Text(
                          formatDate(
                              controller.getPayment.value![index].tranDate ??
                                  ''),
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black1D2226),
                        ),
                        Text(
                          '\$${controller.getPayment.value![index].paidAmount ?? ''}',
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