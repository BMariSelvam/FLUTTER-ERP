import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/widgets/Class.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:erp/widgets/searchTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllSales extends StatefulWidget {
  const AllSales({
    super.key,
  });

  @override
  State<AllSales> createState() => _AllSalesState();
}

class _AllSalesState extends State<AllSales> {
  late InvoiceControllers invoiceControllers;
  TextEditingController fromDatecontroller = TextEditingController();
  TextEditingController toDatecontroller = TextEditingController();
  TextEditingController customerCodecontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    invoiceControllers = Get.put(InvoiceControllers());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceControllers>(builder: (state) {
      return SafeArea(
        child: Scaffold(
            body: Column(
          children: [buildBody(), outStandingAmount()],
        )),
      );
    });
  }

  buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            invoiceControllers.isSelectedFilter
                ? Container()
                : Column(
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
                  ),
            list(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  outStandingAmount() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          MyColors.gradient1,
          MyColors.gradient2,
          MyColors.gradient3,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Out Standing Amount : ',
            style: TextStyle(
                fontFamily: MyFont.myFont2,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: MyColors.white),
          ),
          Text('\$10000.00',
              style: TextStyle(
                  fontFamily: MyFont.myFont2,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: MyColors.white))
        ],
      ),
    );
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
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            margin: const EdgeInsets.only(
              top: 20,
              left: 18,
              right: 18,
              bottom: 8,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        left: 18,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Mariselvam",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            color: MyColors.black),
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
                          const EditPopupMenuButton(),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, top: 5, bottom: 10, right: 5),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.7),
                      1: FlexColumnWidth(1.4)
                    },
                    children: [
                      // TableRow(children: [
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Invoice Number:  ',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text('PO2023-00023  ',
                      //             style: TextStyle(
                      //                 decoration: TextDecoration.none,
                      //                 fontFamily: MyFont.myFont,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 12,
                      //                 color: MyColors.black)),
                      //       ],
                      //     ),
                      //   ),
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Date :   ',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text(
                      //           '13/02/2023',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 12,
                      //               color: MyColors.black),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Net Total',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text(
                      //           " \$32.00 ",
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.w900,
                      //               fontSize: 12,
                      //               color: MyColors.green),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Balance',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text(
                      //           " \$10.00 ",
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.w900,
                      //               fontSize: 12,
                      //               color: MyColors.red),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ]),
                      TableRow(children: [
                        Text(
                          'Invoice Number:',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: MyColors.greyText),
                        ),
                        Text('Date:',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.greyText)),
                        Text('Net Total',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.greyText)),
                        Text('Balance',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.greyText)),
                      ]),

                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 3),
                          child: Text('PO2023-00023',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: MyColors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 3),
                          child: Text('13/02/2023',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: MyColors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 3),
                          child: Text(
                            '\$32.00',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: MyColors.green),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 3),
                          child: Text(
                            '\$10.00',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                color: MyColors.red),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class EditPopupMenuButton extends StatelessWidget {
  const EditPopupMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          PopupMenuItem(
              height: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Image.asset(
                      IconAssets.createOrder,
                      scale: 1.1,
                    ),
                    SizedBox(
                      width: width(context) / 50,
                    ),
                    CustomGradient(
                      child: Text(
                        'Create Order ',
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
          PopupMenuItem(
              height: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Image.asset(
                      IconAssets.createInvoice,
                    ),
                    SizedBox(
                      width: width(context) / 50,
                    ),
                    CustomGradient(
                      child: Text(
                        'Create Invoice',
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
          PopupMenuItem(
              height: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Image.asset(
                      IconAssets.createReceipt,
                      scale: 1.6,
                    ),
                    SizedBox(
                      width: width(context) / 50,
                    ),
                    CustomGradient(
                      child: Text(
                        'Create Receipt',
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
          PopupMenuItem(
              height: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Image.asset(
                      IconAssets.viewLocation,
                      scale: 1.2,
                    ),
                    SizedBox(
                      width: width(context) / 50,
                    ),
                    CustomGradient(
                      child: Text(
                        'View Location',
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
          PopupMenuItem(
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

// class TooltipShape extends ShapeBorder {
//   const TooltipShape();

//   final BorderSide _side = BorderSide.none;
//   final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

//   @override
//   EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

//   @override
//   Path getInnerPath(
//     Rect rect, {
//     TextDirection? textDirection,
//   }) {
//     final Path path = Path();

//     path.addRRect(
//       _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
//     );

//     return path;
//   }

//   @override
//   Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
//     final Path path = Path();
//     final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

//     path.moveTo(0, 10);
//     path.quadraticBezierTo(0, 0, 10, 0);
//     path.lineTo(rrect.width - 30, 0);
//     path.lineTo(rrect.width - 20, -10);
//     path.lineTo(rrect.width - 10, 0);
//     path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
//     path.lineTo(rrect.width, rrect.height - 10);
//     path.quadraticBezierTo(
//         rrect.width, rrect.height, rrect.width - 10, rrect.height);
//     path.lineTo(10, rrect.height);
//     path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

//     return path;
//   }

//   @override
//   void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

//   @override
//   ShapeBorder scale(double t) => RoundedRectangleBorder(
//         side: _side.scale(t),
//         borderRadius: _borderRadius * t,
//       );
// }
