// import 'package:erp/Helper/fonts.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../Helper/colors.dart';
// import '../../../../Helper/custom_gradient.dart';
// import '../../salesorder/add/AddSalesCustomer/customersales.dart';
// import '../../salesorder/add/AddSalesProduct/productsales.dart';
// import '../../salesorder/add/summary_sales.dart';
//
// class SalesAddTabBar extends StatefulWidget {
//   const SalesAddTabBar({super.key});
//
//   @override
//   _SalesAddTabBarState createState() => _SalesAddTabBarState();
// }
//
// class _SalesAddTabBarState extends State<SalesAddTabBar>
//     with SingleTickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(colors: [
//                 MyColors.gradient1,
//                 MyColors.gradient2,
//                 MyColors.gradient3,
//               ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//             ),
//           ),
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_ios_new_rounded,
//               size: 18,
//               color: MyColors.white,
//             ),
//             onPressed: () {
//               setState(() {
//                 Get.back();
//               });
//             },
//           ),
//           titleTextStyle: TextStyle(
//               fontFamily: MyFont.myFont2,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: MyColors.white),
//           titleSpacing: -10,
//           title: Text(
//             'Add',
//           ),
//           bottom: PreferredSize(
//               preferredSize: tabBar.preferredSize,
//               child: Material(
//                 color: MyColors.white,
//                 child: tabBar,
//               )),
//         ),
//         body:  TabBarView(
//           children: [
//             CustomerSales(),
//             ProductSales(),
//             SummarySales(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// TabBar get tabBar => const TabBar(
//       tabs: [
//         CustomGradient(child: Tab(text: 'Customer')),
//         CustomGradient(child: Tab(text: 'Product')),
//         CustomGradient(child: Tab(text: 'Summary')),
//       ],
//     );
