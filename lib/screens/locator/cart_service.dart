import 'dart:async';

import 'package:erp/Model/GetAllProductModel.dart';
import 'package:erp/Model/RequestModel/SalesOrderDetail.dart';
import 'package:erp/Model/RequestModel/TranDetail.dart';
import 'package:erp/Model/RequestModel/invioce_model/InvoiceDetail.dart';
import 'package:get/get.dart';

class CatalogueProductListService {
  final List<GetAllProductModel> _catalogueProductSelectedListItems = [];

  List<GetAllProductModel> get catalogueProductSelectedListItems =>
      _catalogueProductSelectedListItems;

  Stream<bool> get catalogueProductListChangeStream =>
      _catalogueProductListChangeController.stream;

  final _catalogueProductListChangeController =
      StreamController<bool>.broadcast();

  void addToProductList(
      {required GetAllProductModel productList, bool? isBox}) {
    var existingItem = _catalogueProductSelectedListItems.firstWhereOrNull(
        (item) => item.productCode == productList.productCode);
    if (existingItem != null) {
      // If item exists, update the quantity
      if (isBox == true) {
        existingItem.boxcountincrement();
      } else {
        existingItem.unitincrement();
      }
    } else {
      // If item doesn't exist, add it to the  recipt
      if (isBox == true) {
        productList.boxcountincrement();
      } else {
        productList.unitincrement();
      }
      _catalogueProductSelectedListItems.add(productList);
    }

    // _productSelectedListItems.add(productList);
    _catalogueProductListChangeController.add(true);
  }

  void removeFromCart({required GetAllProductModel productList, bool? isBox}) {
    // Check if the item is already in the  recipt
    var existingItem = _catalogueProductSelectedListItems.firstWhereOrNull(
        (item) => item.productCode == productList.productCode);

    if (existingItem != null) {
      // If item exists, update the quantity
      if (isBox == true) {
        existingItem.boxcountdecrement();
      } else {
        existingItem.unitdecrement();
      }
    }

    if (productList.boxcount < 1 && productList.unitcount < 1) {
      _catalogueProductSelectedListItems
          .removeWhere((item) => item.productCode == productList.productCode);
    }
    // Notify listeners that the  recipt has changed
    _catalogueProductListChangeController.add(true);
  }

  void clearProductList() {
    _catalogueProductSelectedListItems.clear();
    _catalogueProductListChangeController.add(true);
  }

  // Dispose the stream controller
  void disposeProductList() {
    _catalogueProductListChangeController.close();
  }
}

class ProductListService {
  final List<GetAllProductModel> _productSelectedListItems = [];

  List<GetAllProductModel> get productListItems => _productSelectedListItems;

  Stream<bool> get productListChangeStream =>
      _productListChangeController.stream;

  final _productListChangeController = StreamController<bool>.broadcast();

  void addToProductList({required GetAllProductModel productList}) {
    var existingItem = _productSelectedListItems.firstWhereOrNull(
        (item) => item.productCode == productList.productCode);
    // if (existingItem != null) {
    //   existingItem.increment();
    // } else {
    //   productList.increment();
    //   _productSelectedListItems.add(productList);
    // }

    _productSelectedListItems.add(productList);
    _productListChangeController.add(true);
  }

  void removeFromProductList({required GetAllProductModel productList}) {
    // var existingItem = _productSelectedListItems.firstWhereOrNull(
    //     (item) => item.productCode == productList.productCode);
    // productList.fun();
    if (productList.stkQty?.isEmpty ?? false) {
      _productSelectedListItems
          .removeWhere((item) => item.productCode == productList.productCode);
    }
    _productSelectedListItems.remove(productList);
    _productListChangeController.add(true);
  }

  void clearProductList() {
    _productSelectedListItems.clear();
    _productListChangeController.add(true);
  }

  // Dispose the stream controller
  void disposeProductList() {
    _productListChangeController.close();
  }
}

class InvoiceProductListService {
  final List<InvoiceDetail> _invoiceProductSelectedListItems = [];

  List<InvoiceDetail> get productListItems => _invoiceProductSelectedListItems;

  Stream<bool> get invoiceProductListChangeStream =>
      _invoiceProductListChangeController.stream;

  final _invoiceProductListChangeController =
      StreamController<bool>.broadcast();

  void addToProductList({required InvoiceDetail productList}) {
    var existingItem = _invoiceProductSelectedListItems.firstWhereOrNull(
        (item) => item.productCode == productList.productCode);
    // if (existingItem != null) {
    //   existingItem.increment();
    // } else {
    //   productList.increment();
    //   _productSelectedListItems.add(productList);
    // }

    _invoiceProductSelectedListItems.add(productList);
    _invoiceProductListChangeController.add(true);
  }

  // void removeFromProductList({required InvoiceDetail productList}) {
  //   // var existingItem = _productSelectedListItems.firstWhereOrNull(
  //   //     (item) => item.productCode == productList.productCode);
  //   // productList.fun();
  //   if (productList.stockQty?.isEmpty ?? false) {
  //     _productSelectedListItems
  //         .removeWhere((item) => item.productCode == productList.productCode);
  //   }
  //   _productSelectedListItems.remove(productList);
  //   _productListChangeController.add(true);
  // }

  void clearProductList() {
    _invoiceProductSelectedListItems.clear();
    _invoiceProductListChangeController.add(true);
  }

  // Dispose the stream controller
  void disposeProductList() {
    _invoiceProductListChangeController.close();
  }
}

class SalesOrderDetailListService {
  final List<SalesOrderDetail> _salesOrderDetailSelectedListItems = [];

  List<SalesOrderDetail> get productListItems =>
      _salesOrderDetailSelectedListItems;

  Stream<bool> get salesOrderDetailListChangeStream =>
      _salesOrderDetailListChangeController.stream;

  final _salesOrderDetailListChangeController =
      StreamController<bool>.broadcast();

  void addToProductList({required SalesOrderDetail productList}) {
    var existingItem = _salesOrderDetailSelectedListItems.firstWhereOrNull(
        (item) => item.productCode == productList.productCode);
    // if (existingItem != null) {
    //   existingItem.increment();
    // } else {
    //   productList.increment();
    //   _salesOrderDetailSelectedListItems.add(productList);
    // }

    _salesOrderDetailSelectedListItems.add(productList);
    _salesOrderDetailListChangeController.add(true);
  }

  // void removeFromProductList({required SalesOrderDetail productList}) {
  //   var existingItem = _salesOrderDetailSelectedListItems.firstWhereOrNull(
  //       (item) => item.productCode == productList.productCode);
  //
  //   if (productList.stockQty?.isEmpty ?? false) {
  //     _salesOrderDetailSelectedListItems
  //         .removeWhere((item) => item.productCode == productList.productCode);
  //   }
  //   _salesOrderDetailSelectedListItems.remove(productList);
  //   _salesOrderDetailListChangeController.add(true);
  // }

  void clearProductList() {
    _salesOrderDetailSelectedListItems.clear();
    _salesOrderDetailListChangeController.add(true);
  }

  // Dispose the stream controller
  void disposeProductList() {
    _salesOrderDetailListChangeController.close();
  }
}

class ReciptService {
  List<TranDetail> _reciptItems = [];

  void addToCart({required TranDetail product}) {
    // Check if the item is already in the  recipt
    var existingItem = _reciptItems
        .firstWhereOrNull((item) => item.invoiceNo == product.invoiceNo);

    if (existingItem != null) {
      // If item exists, update the quantity
      //   existingItem.isSelected = true;
      // existingItem.unitincrement();////
    } else {
      // If item doesn't exist, add it to the  recipt
      // product.isSelected = true;
      // product.unitincrement();////
      _reciptItems.add(product);
    }
    // Notify listeners that the  recipt has changed
    _reciptChangeController.add(true);
  }

  void removeFromCart({required TranDetail product}) {
    // Check if the item is already in the  recipt
    var existingItem = _reciptItems
        .firstWhereOrNull((item) => item.invoiceNo == product.invoiceNo);

    if (existingItem != null) {
      // If item exists, update the quantity
      // if (isBox == true) {
      // existingItem.unitdecrement();////
      // existingItem.isSelected = false;
      // } else {
      //   existingItem.unitdecrement();
      // }
    }

    // if (product. < 1 && product.unitcount < 1) {
    //   _ reciptItems.removeWhere((item) => item.productCode == product.productCode);
    // }
    // Notify listeners that the  recipt has changed
    _reciptChangeController.add(true);
  }

  List<TranDetail> get reciptItems => _reciptItems;

  final _reciptChangeController = StreamController<bool>.broadcast();

  Stream<bool> get reciptChangeStream => _reciptChangeController.stream;

  void clearCart() {
    _reciptItems.clear();
    _reciptChangeController.add(true);
  }

  void slectedProductClear({required TranDetail product}) {
    _reciptItems.removeWhere((item) => item.invoiceNo == product.invoiceNo);
    // product.unitcount = 0;
    _reciptChangeController.add(true);
  }

  // Dispose the stream controller
  void dispose() {
    _reciptChangeController.close();
  }
}
