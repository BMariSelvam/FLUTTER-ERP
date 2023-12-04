import 'ReceiptDetails.dart';
import 'TranDetail.dart';

class Receipt {
  Receipt({
    this.orgId,
    this.tranNo,
    this.invoiceNo,
    this.tranDate,
    this.branchCode,
    this.customerCode,
    this.customerName,
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
    this.deliveryId,
    this.tranDetail,
    this.bankInDate,
    this.bankInDateString,
    this.netTotal,
    this.creditAmount,
    this.debitAmount,
    this.advancePayment,
    this.diff,
    this.writeOff,
    this.tranType,
    this.receiptDetails,
    this.chequeStatus,
    this.fPaidAmount,
    this.fNetTotal,
    this.fCreditAmount,
    this.fDebitAmount,
    this.fAdvancePayment,
    this.currencyCode,
    this.currencyRate,
    this.currencyValue,
  });

  Receipt.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    invoiceNo = json['InvoiceNo'];
    tranDate = json['TranDate'];
    branchCode = json['BranchCode'];
    customerCode = json['CustomerCode'];
    customerName = json['CustomerName'];
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
    deliveryId = json['DeliveryId'];
    if (json['TranDetail'] != null) {
      tranDetail = [];
      json['TranDetail'].forEach((v) {
        tranDetail?.add(TranDetail.fromJson(v));
      });
    }
    bankInDate = json['BankInDate'];
    bankInDateString = json['BankInDateString'];
    netTotal = json['NetTotal'];
    creditAmount = json['CreditAmount'];
    debitAmount = json['DebitAmount'];
    advancePayment = json['AdvancePayment'];
    diff = json['Diff'];
    writeOff = json['WriteOff'];
    tranType = json['TranType'];
    if (json['ReceiptDetails'] != null) {
      receiptDetails = [];
      json['ReceiptDetails'].forEach((v) {
        receiptDetails?.add(ReceiptDetails.fromJson(v));
      });
    }
    chequeStatus = json['ChequeStatus'];
    fPaidAmount = json['FPaidAmount'];
    fNetTotal = json['FNetTotal'];
    fCreditAmount = json['FCreditAmount'];
    fDebitAmount = json['FDebitAmount'];
    fAdvancePayment = json['FAdvancePayment'];
    currencyCode = json['CurrencyCode'];
    currencyRate = json['CurrencyRate'];
    currencyValue = json['CurrencyValue'];
  }
  int? orgId;
  String? tranNo;
  String? invoiceNo;
  String? tranDate;
  String? branchCode;
  String? customerCode;
  String? customerName;
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
  bool? isActive;
  String? tranDatestring;
  String? chequeDatestring;
  String? moduleName;
  String? paymodeName;
  bool? isUpdate;
  int? deliveryId;
  List<TranDetail>? tranDetail;
  String? bankInDate;
  String? bankInDateString;
  double? netTotal;
  double? creditAmount;
  double? debitAmount;
  double? advancePayment;
  double? diff;
  double? writeOff;
  String? tranType;
  List<ReceiptDetails>? receiptDetails;
  int? chequeStatus;
  double? fPaidAmount;
  double? fNetTotal;
  double? fCreditAmount;
  double? fDebitAmount;
  double? fAdvancePayment;
  String? currencyCode;
  double? currencyRate;
  double? currencyValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['InvoiceNo'] = invoiceNo;
    map['TranDate'] = tranDate;
    map['BranchCode'] = branchCode;
    map['CustomerCode'] = customerCode;
    map['CustomerName'] = customerName;
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
    map['DeliveryId'] = deliveryId;
    if (tranDetail != null) {
      map['TranDetail'] = tranDetail?.map((v) => v.toJson()).toList();
    }
    map['BankInDate'] = bankInDate;
    map['BankInDateString'] = bankInDateString;
    map['NetTotal'] = netTotal;
    map['CreditAmount'] = creditAmount;
    map['DebitAmount'] = debitAmount;
    map['AdvancePayment'] = advancePayment;
    map['Diff'] = diff;
    map['WriteOff'] = writeOff;
    map['TranType'] = tranType;
    if (receiptDetails != null) {
      map['ReceiptDetails'] = receiptDetails?.map((v) => v.toJson()).toList();
    }
    map['ChequeStatus'] = chequeStatus;
    map['FPaidAmount'] = fPaidAmount;
    map['FNetTotal'] = fNetTotal;
    map['FCreditAmount'] = fCreditAmount;
    map['FDebitAmount'] = fDebitAmount;
    map['FAdvancePayment'] = fAdvancePayment;
    map['CurrencyCode'] = currencyCode;
    map['CurrencyRate'] = currencyRate;
    map['CurrencyValue'] = currencyValue;
    return map;
  }
}
