import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/screens/masters/customer/customer_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/GetAllCustomerModel.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  late CustomerListController listController;

  // CreateCustomerModel? createCustomerModel;

  @override
  void initState() {
    super.initState();
    listController = Get.put(CustomerListController());
    listController.customerListGet();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerListController>(builder: (logic) {
      if (logic.isLoading == true) {
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
              child: Column(children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.45,
                    // ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.addCustomer),
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
        itemCount: listController.getCustomerList.value?.length,
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
                      margin: const EdgeInsets.only(
                        top: 15,
                        left: 5,
                        right: 10,
                      ),
                      child: SizedBox(
                        width: width(context) / 1.8,
                        child: CustomGradient(
                          child: Text(
                            listController.getCustomerList.value?[index].name ??
                                "",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                letterSpacing: 0.5,
                                color: MyColors.black),
                          ),
                        ),
                      ),
                    ),
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
                          customerEdit(
                              listController.getCustomerList.value?[index]),
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
                      0: FixedColumnWidth(250),
                      1: FlexColumnWidth()
                    },
                    children: [
                      TableRow(children: [
                        Text(
                          'Address:',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black5F5F5F),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'ID',
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                color: MyColors.black5F5F5F),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          '${listController.getCustomerList.value?[index].addressLine1}, ${listController.getCustomerList.value?[index].addressLine2}, ${listController.getCustomerList.value?[index].addressLine3}',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black1D2226),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            listController.getCustomerList.value?[index].code ??
                                "",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                color: MyColors.black1D2226),
                          ),
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

  customerEdit(GetCustomerModel? customerModel) {
    return SizedBox(
      height: 25,
      width: 28,
      child: PopupMenuButton(
        color: MyColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 2, color: Colors.black54)),
        iconSize: 25,
        padding: const EdgeInsets.all(1),
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
          color: MyColors.white,
        ),
        offset: const Offset(0, 30),
        itemBuilder: (_) => <PopupMenuEntry>[
          PopupMenuItem(
              onTap: () {
                Get.toNamed(AppRoutes.editCustomer, arguments: customerModel);
              },
              height: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Image.asset(IconAssets.editIcon),
                    SizedBox(
                      width: width(context) / 50,
                    ),
                    CustomGradient(
                      child: Text(
                        'Edit ',
                        style: TextStyle(
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: MyColors.mainTheme),
                      ),
                    ),
                  ]),
                ],
              )),
          const PopupMenuDivider(),
          // PopupMenuItem(
          //     height: 20,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //           Image.asset(
          //             IconAssets.createOrder,
          //             scale: 1.1,
          //           ),
          //           SizedBox(
          //             width: width(context) / 50,
          //           ),
          //           CustomGradient(
          //             child: Text(
          //               'Create Order ',
          //               style: TextStyle(
          //                   fontFamily: MyFont.myFont2,
          //                   fontWeight: FontWeight.w900,
          //                   fontSize: 15,
          //                   color: MyColors.mainTheme),
          //             ),
          //           ),
          //         ]),
          //       ],
          //     )),
          // const PopupMenuDivider(),
          // PopupMenuItem(
          //     height: 20,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //           Image.asset(
          //             IconAssets.createInvoice,
          //           ),
          //           SizedBox(
          //             width: width(context) / 50,
          //           ),
          //           CustomGradient(
          //             child: Text(
          //               'Create Invoice',
          //               style: TextStyle(
          //                   fontFamily: MyFont.myFont2,
          //                   fontWeight: FontWeight.w900,
          //                   fontSize: 15,
          //                   color: MyColors.mainTheme),
          //             ),
          //           ),
          //         ]),
          //       ],
          //     )),
          // const PopupMenuDivider(),
          // PopupMenuItem(
          //     height: 20,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //           Image.asset(
          //             IconAssets.createReceipt,
          //             scale: 1.6,
          //           ),
          //           SizedBox(
          //             width: width(context) / 50,
          //           ),
          //           CustomGradient(
          //             child: Text(
          //               'Create Receipt',
          //               style: TextStyle(
          //                   fontFamily: MyFont.myFont2,
          //                   fontWeight: FontWeight.w900,
          //                   fontSize: 15,
          //                   color: MyColors.mainTheme),
          //             ),
          //           ),
          //         ]),
          //       ],
          //     )),
          // const PopupMenuDivider(),
          // PopupMenuItem(
          //     height: 20,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //           Image.asset(
          //             IconAssets.viewLocation,
          //             scale: 1.2,
          //           ),
          //           SizedBox(
          //             width: width(context) / 50,
          //           ),
          //           CustomGradient(
          //             child: Text(
          //               'View Location',
          //               style: TextStyle(
          //                   fontFamily: MyFont.myFont2,
          //                   fontWeight: FontWeight.w900,
          //                   fontSize: 15,
          //                   color: MyColors.mainTheme),
          //             ),
          //           ),
          //         ]),
          //       ],
          //     )),
          // const PopupMenuDivider(),
          PopupMenuItem(
            onTap: () {},
            height: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        IconAssets.delete,
                        scale: 1.2,
                      ),
                      SizedBox(
                        width: width(context) / 50,
                      ),
                      CustomGradient(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: MyColors.mainTheme),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
