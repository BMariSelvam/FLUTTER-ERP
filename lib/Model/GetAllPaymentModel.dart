class GetAllPaymentModel {
  GetAllPaymentModel({
    this.orgId,
    this.tranNo,
    this.tranDate,
    this.branchCode,
    this.supplierCode,
    this.supplierName,
    this.address,
    this.paidAmount,
    this.payMode,
    this.bank,
    this.chequeNo,
    this.chequeDate,
    this.remarks,
    this.accountNo,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.isActive,
    this.tranDatestring,
    this.chequeDatestring,
    this.moduleName,
    this.paymodeName,
    this.isUpdate,
    this.fPaidAmount,
    this.currencyRate,
    this.currencyValue,
    this.currencyCode,
    this.tranDetail,
  });

  GetAllPaymentModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    tranDate = json['TranDate'];
    branchCode = json['BranchCode'];
    supplierCode = json['SupplierCode'];
    supplierName = json['SupplierName'];
    address = json['Address'];
    paidAmount = json['PaidAmount'];
    payMode = json['PayMode'];
    bank = json['Bank'];
    chequeNo = json['ChequeNo'];
    chequeDate = json['ChequeDate'];
    remarks = json['Remarks'];
    accountNo = json['AccountNo'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    isActive = json['IsActive'];
    tranDatestring = json['TranDatestring'];
    chequeDatestring = json['ChequeDatestring'];
    moduleName = json['ModuleName'];
    paymodeName = json['PaymodeName'];
    isUpdate = json['IsUpdate'];
    fPaidAmount = json['FPaidAmount'];
    currencyRate = json['CurrencyRate'];
    currencyValue = json['CurrencyValue'];
    currencyCode = json['CurrencyCode'];
    tranDetail = json['TranDetail'];
  }

  int? orgId;
  String? tranNo;
  String? tranDate;
  String? branchCode;
  String? supplierCode;
  String? supplierName;
  String? address;
  double? paidAmount;
  String? payMode;
  String? bank;
  String? chequeNo;
  String? chequeDate;
  String? remarks;
  String? accountNo;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  dynamic isActive;
  String? tranDatestring;
  String? chequeDatestring;
  dynamic moduleName;
  String? paymodeName;
  bool? isUpdate;
  double? fPaidAmount;
  double? currencyRate;
  double? currencyValue;
  String? currencyCode;
  dynamic tranDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['TranDate'] = tranDate;
    map['BranchCode'] = branchCode;
    map['SupplierCode'] = supplierCode;
    map['SupplierName'] = supplierName;
    map['Address'] = address;
    map['PaidAmount'] = paidAmount;
    map['PayMode'] = payMode;
    map['Bank'] = bank;
    map['ChequeNo'] = chequeNo;
    map['ChequeDate'] = chequeDate;
    map['Remarks'] = remarks;
    map['AccountNo'] = accountNo;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['IsActive'] = isActive;
    map['TranDatestring'] = tranDatestring;
    map['ChequeDatestring'] = chequeDatestring;
    map['ModuleName'] = moduleName;
    map['PaymodeName'] = paymodeName;
    map['IsUpdate'] = isUpdate;
    map['FPaidAmount'] = fPaidAmount;
    map['CurrencyRate'] = currencyRate;
    map['CurrencyValue'] = currencyValue;
    map['CurrencyCode'] = currencyCode;
    map['TranDetail'] = tranDetail;
    return map;
  }
}
