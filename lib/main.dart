import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/screens/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  setupCatalogueDependencies();
  setupInvoiceProductDependencies();
  setupSalesOrderDetailListDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ERP',
      theme: ThemeData(primarySwatch: MyColors.primaryCustom),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen1,
      getPages: screens,
    );
  }
}
