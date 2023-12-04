import 'package:erp/screens/ForgotPasswordScreen.dart';
import 'package:erp/screens/RegistrationScreen.dart';
import 'package:erp/screens/ResetPasswordScreen.dart';
import 'package:erp/screens/catalogue/about_Prouduct/aboutproductscreen.dart';
import 'package:erp/screens/catalogue/cart/sales_order_cart_screen.dart';
import 'package:erp/screens/dashboard/DashBoardScreen.dart';
import 'package:erp/screens/invoice/CreateInvoice/AddTapBar.dart';
import 'package:erp/screens/invoice/CreateInvoice/InvoiceCustomer/customerscreen.dart';
import 'package:erp/screens/invoice/CreateInvoice/InvoiceProduct/productscreen.dart';
import 'package:erp/screens/invoice/CreateInvoice/InvoiceSummary/summary.dart';
import 'package:erp/screens/invoice/invioce_print_preview.dart';
import 'package:erp/screens/password_success_screen.dart';
import 'package:erp/screens/product/subCategory/add_sub_category.dart';
import 'package:erp/screens/sales/receipt/receipt_print_preview.dart';
import 'package:erp/screens/sales/receipt/receipt_tabbar_screen.dart';
import 'package:erp/screens/sales/salesorderother/print_preview.dart';
import 'package:erp/screens/splash/SplashScreen1.dart';
import 'package:erp/screens/splash/SplashScreen2.dart';
import 'package:erp/widgets/BottomNavBar.dart';
import 'package:erp/widgets/invoices_tabbar_screen.dart';
import 'package:get/get.dart';

import '../screens/ContactInformation.dart';
import '../screens/Outstanding.dart';
import '../screens/SetPassword.dart';
import '../screens/invoice/AllScreen.dart';
import '../screens/login/LoginScreen.dart';
import '../screens/masters/Customer/add_customer.dart';
import '../screens/masters/Customer/customer_list.dart';
import '../screens/masters/bank/add_bank.dart';
import '../screens/masters/bank/bank_list.dart';
import '../screens/masters/company_screen.dart';
import '../screens/masters/customer/edit_customer.dart';
import '../screens/masters/paymode/add_paymode.dart';
import '../screens/masters/paymode/paymode_list.dart';
import '../screens/masters/supplier/add_supplier.dart';
import '../screens/masters/supplier/supplier_list.dart';
import '../screens/masters/tax/add_tax.dart';
import '../screens/masters/tax/tax_list.dart';
import '../screens/otp_verify_screen1.dart';
import '../screens/otp_verify_screen2.dart';
import '../screens/paid.dart';
import '../screens/product/brand/add_brand.dart';
import '../screens/product/brand/brand_list.dart';
import '../screens/product/category/add_category.dart';
import '../screens/product/category/category_list.dart';
import '../screens/product/product/add_product.dart';
import '../screens/product/product/product_list.dart';
import '../screens/product/productStock/add_product_stock.dart';
import '../screens/product/productStock/product_stock_list.dart';
import '../screens/product/subCategory/sub_category_list.dart';
import '../screens/product/uom/add_uom.dart';
import '../screens/product/uom/uom_list.dart';
import '../screens/profile_screen.dart';
import '../screens/purchase/goodsReceive/add_goods_receive.dart';
import '../screens/purchase/goodsReceive/goods_receive_list.dart';
import '../screens/purchase/payment/add_payment.dart';
import '../screens/purchase/payment/payment_list.dart';
import '../screens/purchase/purchaseOrder/add_purchase_order.dart';
import '../screens/purchase/purchaseOrder/purchase_order_list.dart';
import '../screens/purchase/purchaseReturn/add_purchase_return.dart';
import '../screens/purchase/purchaseReturn/purchase_return_list.dart';
import '../screens/purchase/stockInDo/add_stock_in_do.dart';
import '../screens/purchase/stockInDo/stock_in_do_list.dart';
import '../screens/registered_success_screen.dart';
import '../screens/sales/deliveryOrder/add_delivery_order.dart';
import '../screens/sales/deliveryOrder/delivery_order_list.dart';
import '../screens/sales/receipt/add_receipt.dart';
import '../screens/sales/receipt/receipt_list.dart';
import '../screens/sales/salesReturn/add_sales_return.dart';
import '../screens/sales/salesReturn/sales_return_list.dart';
import '../screens/sales/salesorder/add/sales_add_tabbar.dart';
import '../screens/sales/salesorder/sales_invoice_tabbar.dart';
import '../screens/sales/salesorderother/add_sales_order.dart';
import '../screens/sales/salesorderother/sales_order_list.dart';
import '../screens/settlement/add_settlement.dart';
import '../screens/settlement/settlement_list.dart';
import '../screens/stock/productStock/add_product_stock.dart';
import '../screens/stock/productStock/product_stock_list.dart';
import '../screens/stock/stockAdjustment/add_stock_adjustment.dart';
import '../screens/stock/stockAdjustment/stock_adjustment_list.dart';
import '../screens/stock/stockTake/add_stock_take.dart';
import '../screens/stock/stockTake/stock_take_list.dart';
import '../screens/stock/stockTransfer/add_stock_transfer.dart';
import '../screens/stock/stockTransfer/stock_transfer_list.dart';

class AppRoutes {
  static const String splashScreen1 = '/splashScreen1';
  static const String splashScreen2 = '/splashScreen2';
  static const String dashBoardScreen = '/DashBoardScreen';
  static const String loginScreen = '/LoginScreen';
  static const String resetPasswordScreen = '/ResetPasswordScreen';
  static const String bottomNavBarScreen = '/bottomNavBarScreen';
  static const String forgotPasswordScreen = '/ForgotPasswordScreen';
  static const String successfullyScreen = '/successfullyScreen';
  static const String tabBarScreen = '/tabBarScreen';
  static const String addTabBarScreen = '/AddTabBarScreen';
  static const String customerScreen = '/AddScreen';
  static const String productScreen = '/ProductScreen';
  static const String registrationScreen = '/RegistrationScreen';
  static const String allScreen = '/AllScreen';
  static const String contactInformation = '/ContactInformation';
  static const String otpVerifyScreen1 = '/OtpVerifyScreen1';
  static const String otpVerifyScreen2 = '/OtpVerifyScreen2';
  static const String outStanding = '/Outstanding';
  static const String paidScreen = '/PaidScreen';
  static const String profileScreen = '/ProfileScreen';
  static const String registeredSuccessScreen = '/RegisteredSuccessScreen';
  static const String setPassword = '/SetPassword';
  static const String companyScreen = '/CompanyScreen';
  static const String summaryScreen = '/SummaryScreen';
  static const String addBank = '/AddBank';
  static const String bankList = '/BankList';
  static const String addCustomer = '/AddCustomer';
  static const String customerList = '/CustomerList';
  static const String addPayMode = '/AddPayMode';
  static const String payModeList = '/PayModeList';
  static const String addSupplier = '/AddSupplier';
  static const String supplierList = '/SupplierList';
  static const String addTax = '/AddTax';
  static const String taxList = '/TaxList';
  static const String addBrand = '/AddBrand';
  static const String brandList = '/BrandList';
  static const String addCategory = '/AddCategory';
  static const String categoryList = '/CategoryList';
  static const String addProduct = '/AddProduct';
  static const String productList = '/ProductList';
  static const String addProductStock = '/AddProductStock';
  static const String productStockList = '/ProductStockList';
  static const String addUom = '/AddUom';
  static const String uomList = '/UomList';
  static const String addGoodsReceive = '/AddGoodsReceive';
  static const String goodsReceiveList = '/GoodsReceiveList';
  static const String addPayment = '/AddPayment';
  static const String paymentList = '/PaymentList';
  static const String addPurchaseOrder = '/AddPurchaseOrder';
  static const String purchaseOrderList = '/PurchaseOrderList';
  static const String addPurchaseReturn = '/AddPurchaseReturn';
  static const String purchaseReturnList = '/PurchaseReturnList';
  static const String addStockInDo = '/AddStockInDo';
  static const String stockInDoList = '/StockInDoList';
  static const String successfullyMsgScreen1 = '/SuccessfullyMsgScreen1';
  static const String salesOrderList = '/SalesOrderList';
  static const String addSalesOrder = '/AddSalesOrder';
  static const String deliveryOrderList = '/DeliveryOrderList';
  static const String addDeliveryOrder = '/AddDeliveryOrder';
  static const String salesInvoicesTabBarScreen = '/SalesInvoicesTabBarScreen';
  static const String salesAddTabBar = '/SalesAddTabBar';
  static const String salesReturnList = '/SalesReturnList';
  static const String addSalesReturn = '/AddSalesReturn';
  static const String receiptList = '/ReceiptList';
  static const String addReceipt = '/AddReceipt';
  static const String settlementList = '/SettlementList';
  static const String addSettlement = '/AddSettlement';
  static const String stockProductList = '/StockProductList';
  static const String addStockProduct = '/AddStockProduct';
  static const String stockTakeList = '/StockTakeList';
  static const String addStockTake = '/AddStockTake';
  static const String stockTransferList = '/StockTransferList';
  static const String addStockTransfer = '/AddStockTransfer';
  static const String stockAdjustmentList = '/StockAdjustmentList';
  static const String addStockAdjustment = '/AddStockAdjustment';
  static const String subCategoryList = '/SubCategoryList';
  static const String addSubCategory = '/AddSubCategory';
  static const String editCustomer = '/EditCustomer';
  static const String editReceipt = '/EditReceipt';
  static const String cartScreen = '/cartScreen';
  static const String printPreviewScreen = '/PrintPreviewScreen';
  static const String invoicePrintPreviewScreen = '/invoicePrintPreviewScreen';
  static const String receiptPrintPreviewScreen = '/receiptPrintPreviewScreen';
  static const String receiptTabBarScreen = '/ReceiptTabBarScreen';
  static const String aboutProductScreen = '/AboutProductScreen';
}

final screens = [
  GetPage(name: AppRoutes.splashScreen1, page: () => const SplashScreen1()),
  GetPage(name: AppRoutes.splashScreen2, page: () => const SplashScreen2()),
  GetPage(
      name: AppRoutes.dashBoardScreen,
      page: () => DashBoardScreen(
            fabSelected: false,
          )),
  GetPage(name: AppRoutes.loginScreen, page: () => const LoginScreen()),
  GetPage(
      name: AppRoutes.resetPasswordScreen,
      page: () => const ResetPasswordScreen()),
  GetPage(name: AppRoutes.bottomNavBarScreen, page: () => const BottomNavBar()),
  GetPage(
      name: AppRoutes.forgotPasswordScreen,
      page: () => const ForgotPasswordScreen()),
  GetPage(
      name: AppRoutes.tabBarScreen, page: () => const InvoicesTabBarScreen()),
  GetPage(name: AppRoutes.customerScreen, page: () => const CustomerScreen()),
  GetPage(name: AppRoutes.productScreen, page: () => const ProductScreen()),
  GetPage(name: AppRoutes.addTabBarScreen, page: () => const AddTabBarScreen()),
  GetPage(
      name: AppRoutes.successfullyScreen,
      page: () => const SuccessfullyScreen()),
  GetPage(
      name: AppRoutes.registrationScreen,
      page: () => const RegistrationScreen()),
  GetPage(name: AppRoutes.allScreen, page: () => const AllScreen()),
  GetPage(
      name: AppRoutes.contactInformation,
      page: () => const ContactInformation()),
  GetPage(
      name: AppRoutes.otpVerifyScreen1, page: () => const OtpVerifyScreen1()),
  GetPage(
      name: AppRoutes.otpVerifyScreen2, page: () => const OtpVerifyScreen2()),
  GetPage(name: AppRoutes.outStanding, page: () => const Outstanding()),
  GetPage(name: AppRoutes.paidScreen, page: () => const PaidScreen()),
  GetPage(name: AppRoutes.profileScreen, page: () => const ProfileScreen()),
  GetPage(
      name: AppRoutes.registeredSuccessScreen,
      page: () => const RegisteredSuccessScreen()),
  GetPage(name: AppRoutes.setPassword, page: () => const SetPassword()),
  GetPage(name: AppRoutes.summaryScreen, page: () => const SummaryScreen()),
  GetPage(name: AppRoutes.addBank, page: () => const AddBank()),
  GetPage(name: AppRoutes.bankList, page: () => const BankList()),
  GetPage(name: AppRoutes.addCustomer, page: () => const AddCustomer()),
  GetPage(name: AppRoutes.customerList, page: () => const CustomerList()),
  GetPage(name: AppRoutes.addPayMode, page: () => const AddPayMode()),
  GetPage(name: AppRoutes.payModeList, page: () => const PayModeList()),
  GetPage(name: AppRoutes.addSupplier, page: () => const AddSupplier()),
  GetPage(name: AppRoutes.supplierList, page: () => const SupplierList()),
  GetPage(name: AppRoutes.addTax, page: () => const AddTax()),
  GetPage(name: AppRoutes.taxList, page: () => const TaxList()),
  GetPage(name: AppRoutes.companyScreen, page: () => const CompanyScreen()),
  GetPage(name: AppRoutes.addBrand, page: () => const AddBrand()),
  GetPage(name: AppRoutes.brandList, page: () => const BrandList()),
  GetPage(name: AppRoutes.addCategory, page: () => const AddCategory()),
  GetPage(name: AppRoutes.categoryList, page: () => const CategoryList()),
  GetPage(name: AppRoutes.addProduct, page: () => const AddProduct()),
  GetPage(name: AppRoutes.productList, page: () => const ProductList()),
  GetPage(name: AppRoutes.addProductStock, page: () => const AddProductStock()),
  GetPage(
      name: AppRoutes.productStockList, page: () => const ProductStockList()),
  GetPage(name: AppRoutes.addUom, page: () => const AddUom()),
  GetPage(name: AppRoutes.uomList, page: () => const UomList()),
  GetPage(name: AppRoutes.addGoodsReceive, page: () => const AddGoodsReceive()),
  GetPage(
      name: AppRoutes.goodsReceiveList, page: () => const GoodsReceiveList()),
  GetPage(name: AppRoutes.addPayment, page: () => const AddPayment()),
  GetPage(name: AppRoutes.paymentList, page: () => const PaymentList()),
  GetPage(
      name: AppRoutes.addPurchaseOrder, page: () => const AddPurchaseOrder()),
  GetPage(
      name: AppRoutes.purchaseOrderList, page: () => const PurchaseOrderList()),
  GetPage(
      name: AppRoutes.addPurchaseReturn, page: () => const AddPurchaseReturn()),
  GetPage(
      name: AppRoutes.purchaseReturnList,
      page: () => const PurchaseReturnList()),
  GetPage(name: AppRoutes.addStockInDo, page: () => const AddStockInDo()),
  GetPage(name: AppRoutes.stockInDoList, page: () => const StockInDoList()),
  GetPage(
      name: AppRoutes.registrationScreen,
      page: () => const RegistrationScreen()),
  GetPage(name: AppRoutes.salesOrderList, page: () => const SalesOrderList()),
  GetPage(name: AppRoutes.addSalesOrder, page: () => const AddSalesOrder()),
  GetPage(
      name: AppRoutes.deliveryOrderList, page: () => const DeliveryOrderList()),
  GetPage(
      name: AppRoutes.addDeliveryOrder, page: () => const AddDeliveryOrder()),
  GetPage(
      name: AppRoutes.salesInvoicesTabBarScreen,
      page: () => const SalesInvoicesTabBarScreen()),
  GetPage(name: AppRoutes.salesAddTabBar, page: () => const SalesAddTabBar()),
  GetPage(name: AppRoutes.salesReturnList, page: () => const SalesReturnList()),
  GetPage(name: AppRoutes.addSalesReturn, page: () => const AddSalesReturn()),
  GetPage(name: AppRoutes.receiptList, page: () => const ReceiptList()),
  GetPage(name: AppRoutes.addReceipt, page: () => const AddReceipt()),
  GetPage(name: AppRoutes.settlementList, page: () => const SettlementList()),
  GetPage(name: AppRoutes.addSettlement, page: () => const AddSettlement()),
  GetPage(
      name: AppRoutes.stockProductList, page: () => const StockProductList()),
  GetPage(name: AppRoutes.addStockProduct, page: () => const AddStockProduct()),
  GetPage(name: AppRoutes.stockTakeList, page: () => const StockTakeList()),
  GetPage(name: AppRoutes.addStockTake, page: () => const AddStockTake()),
  GetPage(
      name: AppRoutes.stockTransferList, page: () => const StockTransferList()),
  GetPage(
      name: AppRoutes.addStockTransfer, page: () => const AddStockTransfer()),
  GetPage(
      name: AppRoutes.stockAdjustmentList,
      page: () => const StockAdjustmentList()),
  GetPage(
      name: AppRoutes.addStockAdjustment,
      page: () => const AddStockAdjustment()),
  GetPage(name: AppRoutes.subCategoryList, page: () => const SubCategoryList()),
  GetPage(name: AppRoutes.addSubCategory, page: () => const AddSubCategory()),
  GetPage(name: AppRoutes.editCustomer, page: () => const EditCustomer()),
  GetPage(name: AppRoutes.cartScreen, page: () => const SalesOrderCartScreen()),
  GetPage(
      name: AppRoutes.printPreviewScreen,
      page: () => const PrintPreviewScreen()),
  GetPage(
      name: AppRoutes.invoicePrintPreviewScreen,
      page: () => const InvoicePrintPreviewScreen()),
  GetPage(
      name: AppRoutes.receiptPrintPreviewScreen,
      page: () => const ReceiptPrintPreviewScreen()),
  GetPage(
      name: AppRoutes.receiptTabBarScreen,
      page: () => const ReceiptTabBarScreen()),
  GetPage(
      name: AppRoutes.aboutProductScreen,
      page: () => const AboutProductScreen()),
];
