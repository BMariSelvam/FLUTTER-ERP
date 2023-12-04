import 'package:erp/Helper/Controllers.dart';
import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/screens/catalogue/catalogue_screen.dart';
import 'package:erp/screens/dashboard/DashBoardScreen.dart';
import 'package:erp/screens/sales/receipt/receipt_list.dart';
import 'package:erp/widgets/invoices_tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;
  bool fabSelected = false;
  late Controllers controllers;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
      fabSelected = false;
    });
  }

  List<Widget> tab = [
    DashBoardScreen(fabSelected: false),
    InvoicesTabBarScreen(),
    Container(color: Colors.yellow),
    Container(color: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fabSelected = false;
        });
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                fabSelected
                    ? AnimatedContainer(
                        transformAlignment: Alignment.center,
                        duration: const Duration(milliseconds: 250),
                        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
                        color: Colors.transparent,
                        height: 250,
                        width: 300,
                        child: Stack(
                          children: [
                            Positioned(
                                left: 0,
                                bottom: 75,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.salesAddTabBar);
                                    setState(() {
                                      fabSelected = !fabSelected;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 35,
                                    child: Image.asset(Assets.orderFab),
                                  ),
                                )),
                            Positioned(
                                left: 40,
                                bottom: 145,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.addTabBarScreen);
                                    setState(() {
                                      fabSelected = !fabSelected;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 35,
                                    child: Image.asset(Assets.invoiceFab),
                                  ),
                                )),
                            Positioned(
                                left: 115,
                                bottom: 175,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CatalogueScreen(),
                                        ));
                                    setState(() {
                                      fabSelected = !fabSelected;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 35,
                                    child: Image.asset(Assets.catalogue),
                                  ),
                                )),
                            Positioned(
                                right: 40,
                                bottom: 145,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ReceiptList(),
                                        ));
                                    setState(() {
                                      fabSelected = !fabSelected;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 35,
                                    child: Image.asset(Assets.receiptFab),
                                  ),
                                )),
                            Positioned(
                                right: 0,
                                bottom: 75,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ReceiptList(),
                                        ));
                                    setState(() {
                                      fabSelected = !fabSelected;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 35,
                                    child: Image.asset(Assets.expenseFab),
                                  ),
                                )),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
            body: GestureDetector(
                onTap: () {
                  setState(() {
                    fabSelected = false;
                  });
                },
                child: tab.elementAt(_index)),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: hexStringToColor('DEF0FF'),
              elevation: 25,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Image.asset(IconAssets.homeIcon, scale: 1.5),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Image.asset(IconAssets.homeIcon, scale: 1.5),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Image.asset(Assets.reportIcon, scale: 1.5),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(
                      top: 9,
                    ),
                    child: Image.asset(Assets.reportIcon, scale: 1.5),
                  ),
                  label: 'Report',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Image.asset(Assets.notifyTab, scale: 1.5),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Image.asset(Assets.notifyTab, scale: 1.5),
                  ),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  activeIcon: Image.asset(Assets.settingTab, scale: 1.5),
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Image.asset(Assets.settingTab, scale: 1.5),
                  ),
                  label: 'Settings',
                ),
              ],
              currentIndex: _index,
              selectedItemColor: MyColors.mainTheme,
              onTap: _onItemTapped,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: SizedBox(
              height: 62,
              width: 62,
              child: FloatingActionButton(
                backgroundColor: hexStringToColor('D9D9D9'),
                shape: const CircleBorder(),
                elevation: 0,
                onPressed: () {
                  setState(() {
                    fabSelected = !fabSelected;
                  });
                },
                child: Ink(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                          colors: [
                            MyColors.gradient1,
                            MyColors.gradient2,
                            MyColors.gradient3,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Icon(
                    fabSelected ? Icons.close : Icons.add_outlined,
                    color: MyColors.white,
                    weight: 50,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  iconBackground(String iconName, String image) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: MyColors.white, borderRadius: BorderRadius.circular(75)),
      child: Column(
        children: [
          Image.asset(
            image,
            scale: 1.8,
          ),
          CustomGradient(child: Text(iconName))
        ],
      ),
    );
  }
}
