class InvoiceBatchDetail {
  InvoiceBatchDetail({
    this.orgId,
    this.tranNo,
    this.slNo,
    this.batchNo,
    this.productCode,
    this.productSlNo,
    this.pcsPerCarton,
    this.qty,
    this.batchQty,
    this.cQty,
    this.lQty,
    this.expiryDate,
    this.mfDate,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.expiryDateString,
    this.mfDateString,
    this.foc,
  });

  InvoiceBatchDetail.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    slNo = json['SlNo'];
    batchNo = json['BatchNo'];
    productCode = json['ProductCode'];
    productSlNo = json['ProductSlNo'];
    pcsPerCarton = json['PcsPerCarton'];
    qty = json['Qty'];
    batchQty = json['BatchQty'];
    cQty = json['CQty'];
    lQty = json['LQty'];
    expiryDate = json['ExpiryDate'];
    mfDate = json['MfDate'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    expiryDateString = json['ExpiryDateString'];
    mfDateString = json['MfDateString'];
    foc = json['FOC'];
  }
  int? orgId;
  String? tranNo;
  int? slNo;
  String? batchNo;
  String? productCode;
  int? productSlNo;
  int? pcsPerCarton;
  int? qty;
  int? batchQty;
  int? cQty;
  int? lQty;
  String? expiryDate;
  String? mfDate;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  String? expiryDateString;
  String? mfDateString;
  int? foc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['SlNo'] = slNo;
    map['BatchNo'] = batchNo;
    map['ProductCode'] = productCode;
    map['ProductSlNo'] = productSlNo;
    map['PcsPerCarton'] = pcsPerCarton;
    map['Qty'] = qty;
    map['BatchQty'] = batchQty;
    map['CQty'] = cQty;
    map['LQty'] = lQty;
    map['ExpiryDate'] = expiryDate;
    map['MfDate'] = mfDate;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['ExpiryDateString'] = expiryDateString;
    map['MfDateString'] = mfDateString;
    map['FOC'] = foc;
    return map;
  }
}
