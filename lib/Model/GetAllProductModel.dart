import 'package:flutter/material.dart';

class GetAllProductModel {
  GetAllProductModel({
    this.orgId,
    this.branchCode,
    this.code,
    this.name,
    this.productCode,
    this.productName,
    this.specification,
    this.category,
    this.subCategory,
    this.categoryName,
    this.subCategoryName,
    this.uom,
    this.uomName,
    this.pcsPerCarton,
    this.productType,
    this.brand,
    this.weight,
    this.unitCost,
    this.averageCost,
    this.pcsPrice,
    this.cartonPrice,
    this.barCode,
    this.displayOrder,
    this.isActive,
    this.isStock,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.sellingCost,
    this.sellingBoxCost,
    this.stockQty,
    this.stockBoxQty,
    this.stockPcsQty,
    this.salesAccount,
    this.inventoryAccount,
    this.cOGAccount,
    this.productImageString,
    this.productImage,
    this.createdOnString,
    this.changedOnString,
    this.supplierCode,
    this.supplierName,
    this.taxPerc,
    this.productBarcode,
    this.boxCount,
    this.productImgBase64String,
    this.productImageFileName,
    this.productImagePath,
    this.minSellingCost,
    this.minSellingBoxCost,
    this.tag,
    this.isWeight,
    this.uomPriceDetail,
    this.stockWQty,
    this.unitMarginPerc,
    this.boxMarginPerc,
    this.haveTransaction,
    this.ecommerceDetail,
    this.ecommerceGalleryImages,
    this.haveBatch,
    this.haveSerialNo,
    this.haveExpiryDate,
    this.haveMfDate,
    this.pOSMinSellingPrice,
    this.pOSSellingPrice,
    this.publishToPos,
    this.taxCode,
    this.taxType,
  });

  GetAllProductModel.fromJson(Map<String, dynamic> json,
      {bool? forSharedPreference}) {
    orgId = json['OrgId'];
    branchCode = json['BranchCode'];
    code = json['Code'];
    name = json['Name'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    specification = json['Specification'];
    category = json['Category'];
    subCategory = json['SubCategory'];
    categoryName = json['CategoryName'];
    subCategoryName = json['SubCategoryName'];
    uom = json['Uom'];
    uomName = json['UomName'];
    pcsPerCarton = json['PcsPerCarton'];
    productType = json['ProductType'];
    brand = json['Brand'];
    weight = json['Weight'];
    unitCost = json['UnitCost'];
    averageCost = json['AverageCost'];
    pcsPrice = json['PcsPrice'];
    cartonPrice = json['CartonPrice'];
    barCode = json['BarCode'];
    displayOrder = json['DisplayOrder'];
    isActive = json['IsActive'];
    isStock = json['IsStock'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    sellingCost = json['SellingCost'];
    sellingBoxCost = json['SellingBoxCost'];
    stockQty = json['StockQty'];
    stockBoxQty = json['StockBoxQty'];
    stockPcsQty = json['StockPcsQty'];
    salesAccount = json['SalesAccount'];
    inventoryAccount = json['InventoryAccount'];
    cOGAccount = json['COGAccount'];
    productImageString = json['ProductImageString'];
    productImage = json['ProductImage'];
    createdOnString = json['CreatedOnString'];
    changedOnString = json['ChangedOnString'];
    supplierCode = json['SupplierCode'];
    supplierName = json['SupplierName'];
    taxPerc = json['TaxPerc'];
    productBarcode = json['ProductBarcode'];
    boxCount = json['BoxCount'];
    productImgBase64String = json['ProductImg_Base64String'];
    productImageFileName = json['ProductImageFileName'];
    productImagePath = json['ProductImagePath'];
    minSellingCost = json['MinSellingCost'];
    minSellingBoxCost = json['MinSellingBoxCost'];
    tag = json['Tag'];
    isWeight = json['IsWeight'];
    uomPriceDetail = json['UomPriceDetail'];
    stockWQty = json['StockWQty'];
    unitMarginPerc = json['UnitMarginPerc'];
    boxMarginPerc = json['BoxMarginPerc'];
    haveTransaction = json['HaveTransaction'];
    ecommerceDetail = json['EcommerceDetail'];
    ecommerceGalleryImages = json['EcommerceGalleryImages'];
    haveBatch = json['HaveBatch'];
    haveSerialNo = json['HaveSerialNo'];
    haveExpiryDate = json['HaveExpiryDate'];
    haveMfDate = json['HaveMfDate'];
    pOSMinSellingPrice = json['POSMinSellingPrice'];
    pOSSellingPrice = json['POSSellingPrice'];
    publishToPos = json['PublishToPos'];
    taxCode = json['TaxCode'];
    taxType = json['TaxType'];
  }

  int? orgId;
  dynamic branchCode;
  String? code;
  String? name;
  String? productCode;
  String? productName;
  String? specification;
  String? category;
  String? subCategory;
  String? categoryName;
  String? subCategoryName;
  String? uom;
  dynamic uomName;
  int? pcsPerCarton;
  String? productType;
  String? brand;
  double? weight;
  double? unitCost;
  double? averageCost;
  double? pcsPrice;
  double? cartonPrice;
  String? barCode;
  int? displayOrder;
  bool? isActive;
  bool? isStock;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  double? sellingCost;
  double? sellingBoxCost;
  dynamic stockQty;
  dynamic stockBoxQty;
  dynamic stockPcsQty;
  String? salesAccount;
  String? inventoryAccount;
  String? cOGAccount;
  dynamic productImageString;
  dynamic productImage;
  String? createdOnString;
  String? changedOnString;
  String? supplierCode;
  String? supplierName;
  double? taxPerc;
  dynamic productBarcode;
  dynamic boxCount;
  dynamic productImgBase64String;
  String? productImageFileName;
  String? productImagePath;
  double? minSellingCost;
  double? minSellingBoxCost;
  String? tag;
  bool? isWeight;
  dynamic uomPriceDetail;
  dynamic stockWQty;
  double? unitMarginPerc;
  double? boxMarginPerc;
  dynamic haveTransaction;
  dynamic ecommerceDetail;
  dynamic ecommerceGalleryImages;
  bool? haveBatch;
  bool? haveSerialNo;
  bool? haveExpiryDate;
  bool? haveMfDate;
  double? pOSMinSellingPrice;
  double? pOSSellingPrice;
  bool? publishToPos;
  dynamic taxCode;
  dynamic taxType;

  int cartonCount = 0;
  int unitCount = 0;

  String? stkCarton;
  String? stkUnit;
  String? stkQty;
  String? focCarton;
  String? focUnit;
  String? focQty;
  String? excCarton;
  String? excUnit;
  String? excQty;
  int? slNo;

  bool isShowButtons = false;

  int boxcount = 0;
  int unitcount = 0;

  double Weightcount = 0;

  TextEditingController unitcountController = TextEditingController();
  TextEditingController boxcountController = TextEditingController();
  TextEditingController WeightcountController = TextEditingController();

  funv() {
    boxcountController.text = boxcount.toInt().toString();
    unitcountController.text = unitcount.toInt().toString();
  }

  boxcountincrement() async {
    boxcount++;
    boxcountController.text = boxcount.toInt().toString();
  }

  boxcountdecrement() {
    if (boxcount != 0) {
      boxcount--;
      boxcountController.text = boxcount.toInt().toString();
    }
  }

  unitincrement() {
    unitcount++;
    print("++++++++++++++++$unitcount");

    unitcountController.text = unitcount.toInt().toString();
  }

  unitdecrement() {
    if (unitcount != 0) {
      unitcount--;
      unitcountController.text = unitcount.toInt().toString();
    }
  }

  Weightincrement() {
    Weightcount++;
    WeightcountController.text = Weightcount.toInt().toString();
  }

  Weightdecrement() {
    if (Weightcount != 0) {
      Weightcount--;
      WeightcountController.text = Weightcount.toInt().toString();
    }
  }

  Map<String, dynamic> toJson({bool? forSharedPreference}) {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['BranchCode'] = branchCode;
    map['Code'] = code;
    map['Name'] = name;
    map['ProductCode'] = productCode;
    map['ProductName'] = productName;
    map['Specification'] = specification;
    map['Category'] = category;
    map['SubCategory'] = subCategory;
    map['CategoryName'] = categoryName;
    map['SubCategoryName'] = subCategoryName;
    map['Uom'] = uom;
    map['UomName'] = uomName;
    map['PcsPerCarton'] = pcsPerCarton;
    map['ProductType'] = productType;
    map['Brand'] = brand;
    map['Weight'] = weight;
    map['UnitCost'] = unitCost;
    map['AverageCost'] = averageCost;
    map['PcsPrice'] = pcsPrice;
    map['CartonPrice'] = cartonPrice;
    map['BarCode'] = barCode;
    map['DisplayOrder'] = displayOrder;
    map['IsActive'] = isActive;
    map['IsStock'] = isStock;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['SellingCost'] = sellingCost;
    map['SellingBoxCost'] = sellingBoxCost;
    map['StockQty'] = stockQty;
    map['StockBoxQty'] = stockBoxQty;
    map['StockPcsQty'] = stockPcsQty;
    map['SalesAccount'] = salesAccount;
    map['InventoryAccount'] = inventoryAccount;
    map['COGAccount'] = cOGAccount;
    map['ProductImageString'] = productImageString;
    map['ProductImage'] = productImage;
    map['CreatedOnString'] = createdOnString;
    map['ChangedOnString'] = changedOnString;
    map['SupplierCode'] = supplierCode;
    map['SupplierName'] = supplierName;
    map['TaxPerc'] = taxPerc;
    map['ProductBarcode'] = productBarcode;
    map['BoxCount'] = boxCount;
    map['ProductImg_Base64String'] = productImgBase64String;
    map['ProductImageFileName'] = productImageFileName;
    map['ProductImagePath'] = productImagePath;
    map['MinSellingCost'] = minSellingCost;
    map['MinSellingBoxCost'] = minSellingBoxCost;
    map['Tag'] = tag;
    map['IsWeight'] = isWeight;
    map['UomPriceDetail'] = uomPriceDetail;
    map['StockWQty'] = stockWQty;
    map['UnitMarginPerc'] = unitMarginPerc;
    map['BoxMarginPerc'] = boxMarginPerc;
    map['HaveTransaction'] = haveTransaction;
    map['EcommerceDetail'] = ecommerceDetail;
    map['EcommerceGalleryImages'] = ecommerceGalleryImages;
    map['HaveBatch'] = haveBatch;
    map['HaveSerialNo'] = haveSerialNo;
    map['HaveExpiryDate'] = haveExpiryDate;
    map['HaveMfDate'] = haveMfDate;
    map['POSMinSellingPrice'] = pOSMinSellingPrice;
    map['POSSellingPrice'] = pOSSellingPrice;
    map['PublishToPos'] = publishToPos;
    map['TaxCode'] = taxCode;
    map['TaxType'] = taxType;
    return map;
  }

  @override
  String toString() {
    return "$name";
  }
}
