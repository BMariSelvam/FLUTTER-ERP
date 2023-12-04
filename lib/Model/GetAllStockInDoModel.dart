class GetAllStockInDoModel {
  GetAllStockInDoModel({
    this.orgId,
    this.tranNo,
    this.tranDate,
    this.requiredDate,
    this.requiredDateString,
    this.supplierId,
    this.supplierName,
    this.supplierAddress,
    this.locationCode,
    this.taxCode,
    this.taxType,
    this.taxPerc,
    this.currencyCode,
    this.currencyRate,
    this.currencyValue,
    this.total,
    this.discount,
    this.discountPerc,
    this.subTotal,
    this.tax,
    this.netTotal,
    this.fTotal,
    this.fDiscount,
    this.fSubTotal,
    this.fTax,
    this.fNetTotal,
    this.fDiscountPerc,
    this.remarks,
    this.referenceNo,
    this.createdFrom,
    this.isActive,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.assignTo,
    this.tranDateString,
    this.status,
    this.stockIndoDetail,
    this.stockInDOBatchDetails,
    this.isUpdate,
    this.billDiscount,
    this.fBillDiscount,
    this.poNo,
  });

  GetAllStockInDoModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    tranDate = json['TranDate'];
    requiredDate = json['RequiredDate'];
    requiredDateString = json['RequiredDateString'];
    supplierId = json['SupplierId'];
    supplierName = json['SupplierName'];
    supplierAddress = json['SupplierAddress'];
    locationCode = json['LocationCode'];
    taxCode = json['TaxCode'];
    taxType = json['TaxType'];
    taxPerc = json['TaxPerc'];
    currencyCode = json['CurrencyCode'];
    currencyRate = json['CurrencyRate'];
    currencyValue = json['CurrencyValue'];
    total = json['Total'];
    discount = json['Discount'];
    discountPerc = json['DiscountPerc'];
    subTotal = json['SubTotal'];
    tax = json['Tax'];
    netTotal = json['NetTotal'];
    fTotal = json['FTotal'];
    fDiscount = json['FDiscount'];
    fSubTotal = json['FSubTotal'];
    fTax = json['FTax'];
    fNetTotal = json['FNetTotal'];
    fDiscountPerc = json['FDiscountPerc'];
    remarks = json['Remarks'];
    referenceNo = json['ReferenceNo'];
    createdFrom = json['CreatedFrom'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    assignTo = json['AssignTo'];
    tranDateString = json['TranDateString'];
    status = json['Status'];
    stockIndoDetail = json['StockIndoDetail'];
    stockInDOBatchDetails = json['StockInDOBatchDetails'];
    isUpdate = json['IsUpdate'];
    billDiscount = json['BillDiscount'];
    fBillDiscount = json['FBillDiscount'];
    poNo = json['PoNo'];
  }

  int? orgId;
  String? tranNo;
  String? tranDate;
  dynamic requiredDate;
  dynamic requiredDateString;
  String? supplierId;
  String? supplierName;
  String? supplierAddress;
  String? locationCode;
  int? taxCode;
  String? taxType;
  double? taxPerc;
  String? currencyCode;
  double? currencyRate;
  dynamic currencyValue;
  double? total;
  double? discount;
  double? discountPerc;
  double? subTotal;
  double? tax;
  double? netTotal;
  double? fTotal;
  double? fDiscount;
  double? fSubTotal;
  double? fTax;
  double? fNetTotal;
  dynamic fDiscountPerc;
  String? remarks;
  String? referenceNo;
  String? createdFrom;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  dynamic assignTo;
  String? tranDateString;
  dynamic status;
  dynamic stockIndoDetail;
  dynamic stockInDOBatchDetails;
  bool? isUpdate;
  double? billDiscount;
  double? fBillDiscount;
  dynamic poNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['TranDate'] = tranDate;
    map['RequiredDate'] = requiredDate;
    map['RequiredDateString'] = requiredDateString;
    map['SupplierId'] = supplierId;
    map['SupplierName'] = supplierName;
    map['SupplierAddress'] = supplierAddress;
    map['LocationCode'] = locationCode;
    map['TaxCode'] = taxCode;
    map['TaxType'] = taxType;
    map['TaxPerc'] = taxPerc;
    map['CurrencyCode'] = currencyCode;
    map['CurrencyRate'] = currencyRate;
    map['CurrencyValue'] = currencyValue;
    map['Total'] = total;
    map['Discount'] = discount;
    map['DiscountPerc'] = discountPerc;
    map['SubTotal'] = subTotal;
    map['Tax'] = tax;
    map['NetTotal'] = netTotal;
    map['FTotal'] = fTotal;
    map['FDiscount'] = fDiscount;
    map['FSubTotal'] = fSubTotal;
    map['FTax'] = fTax;
    map['FNetTotal'] = fNetTotal;
    map['FDiscountPerc'] = fDiscountPerc;
    map['Remarks'] = remarks;
    map['ReferenceNo'] = referenceNo;
    map['CreatedFrom'] = createdFrom;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['AssignTo'] = assignTo;
    map['TranDateString'] = tranDateString;
    map['Status'] = status;
    map['StockIndoDetail'] = stockIndoDetail;
    map['StockInDOBatchDetails'] = stockInDOBatchDetails;
    map['IsUpdate'] = isUpdate;
    map['BillDiscount'] = billDiscount;
    map['FBillDiscount'] = fBillDiscount;
    map['PoNo'] = poNo;
    return map;
  }
}
