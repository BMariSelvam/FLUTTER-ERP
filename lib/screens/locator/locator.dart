import 'package:get_it/get_it.dart';

import 'cart_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<ProductListService>(ProductListService());
}

void setupCatalogueDependencies() {
  getIt.registerSingleton<CatalogueProductListService>(
      CatalogueProductListService());
}

void setupInvoiceProductDependencies() {
  getIt.registerSingleton<InvoiceProductListService>(
      InvoiceProductListService());
}

void setupSalesOrderDetailListDependencies() {
  getIt.registerSingleton<SalesOrderDetailListService>(
      SalesOrderDetailListService());
}
