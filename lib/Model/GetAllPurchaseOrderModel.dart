class GetAllPurchaseOrderModel {
  GetAllPurchaseOrderModel({
    this.orgId,
    this.tranNo,
    this.tranDate,
    this.requiredDate,
    this.requiredDateString,
    this.deliveryDate,
    this.deliveryDateString,
    this.supplierId,
    this.supplierName,
    this.supplierAddress,
    this.locationCode,
    this.taxCode,
    this.taxType,
    this.taxPerc,
    this.currencyCode,
    this.currencyRate,
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
    this.purchaseOrderDetail,
    this.isUpdate,
    this.outStanding,
    this.modeOfDelivery,
    this.billDiscount,
    this.fBillDiscount,
    this.fDiscountPerc,
    this.currencyValue,
  });

  GetAllPurchaseOrderModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    tranDate = json['TranDate'];
    requiredDate = json['RequiredDate'];
    requiredDateString = json['RequiredDateString'];
    deliveryDate = json['DeliveryDate'];
    deliveryDateString = json['DeliveryDateString'];
    supplierId = json['SupplierId'];
    supplierName = json['SupplierName'];
    supplierAddress = json['SupplierAddress'];
    locationCode = json['LocationCode'];
    taxCode = json['TaxCode'];
    taxType = json['TaxType'];
    taxPerc = json['TaxPerc'];
    currencyCode = json['CurrencyCode'];
    currencyRate = json['CurrencyRate'];
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
    purchaseOrderDetail = json['PurchaseOrderDetail'];
    isUpdate = json['IsUpdate'];
    outStanding = json['OutStanding'];
    modeOfDelivery = json['ModeOfDelivery'];
    billDiscount = json['BillDiscount'];
    fBillDiscount = json['FBillDiscount'];
    fDiscountPerc = json['FDiscountPerc'];
    currencyValue = json['CurrencyValue'];
  }

  int? orgId;
  String? tranNo;
  String? tranDate;
  dynamic requiredDate;
  dynamic requiredDateString;
  String? deliveryDate;
  String? deliveryDateString;
  String? supplierId;
  String? supplierName;
  String? supplierAddress;
  String? locationCode;
  int? taxCode;
  String? taxType;
  double? taxPerc;
  String? currencyCode;
  double? currencyRate;
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
  int? status;
  dynamic purchaseOrderDetail;
  bool? isUpdate;
  double? outStanding;
  String? modeOfDelivery;
  double? billDiscount;
  double? fBillDiscount;
  double? fDiscountPerc;
  double? currencyValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['TranDate'] = tranDate;
    map['RequiredDate'] = requiredDate;
    map['RequiredDateString'] = requiredDateString;
    map['DeliveryDate'] = deliveryDate;
    map['DeliveryDateString'] = deliveryDateString;
    map['SupplierId'] = supplierId;
    map['SupplierName'] = supplierName;
    map['SupplierAddress'] = supplierAddress;
    map['LocationCode'] = locationCode;
    map['TaxCode'] = taxCode;
    map['TaxType'] = taxType;
    map['TaxPerc'] = taxPerc;
    map['CurrencyCode'] = currencyCode;
    map['CurrencyRate'] = currencyRate;
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
    map['PurchaseOrderDetail'] = purchaseOrderDetail;
    map['IsUpdate'] = isUpdate;
    map['OutStanding'] = outStanding;
    map['ModeOfDelivery'] = modeOfDelivery;
    map['BillDiscount'] = billDiscount;
    map['FBillDiscount'] = fBillDiscount;
    map['FDiscountPerc'] = fDiscountPerc;
    map['CurrencyValue'] = currencyValue;
    return map;
  }
}
