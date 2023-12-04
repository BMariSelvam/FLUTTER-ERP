class ReceiptDetails {
  ReceiptDetails({
    this.orgId,
    this.tranNo,
    this.invoiceDate,
    this.invoiceDateString,
    this.invoiceNo,
    this.netTotal,
    this.paidAmount,
    this.balaceAmount,
    this.creditAmount,
    this.debitAmount,
    this.advancePayment,
    this.carryDays,
    this.badDebit,
    this.discount,
    this.creditNote,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.fNetTotal,
    this.fPaidAmount,
    this.fBalanceAmount,
    this.fCreditAmount,
    this.fDebitAmount,
    this.fAdvancePayment,
    this.currencyCode,
    this.currencyRate,
    this.currencyValue,
    this.tranType,
  });

  ReceiptDetails.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    invoiceDate = json['InvoiceDate'];
    invoiceDateString = json['InvoiceDateString'];
    invoiceNo = json['InvoiceNo'];
    netTotal = json['NetTotal'];
    paidAmount = json['PaidAmount'];
    balaceAmount = json['BalaceAmount'];
    creditAmount = json['CreditAmount'];
    debitAmount = json['DebitAmount'];
    advancePayment = json['AdvancePayment'];
    carryDays = json['CarryDays'];
    badDebit = json['BadDebit'];
    discount = json['Discount'];
    creditNote = json['CreditNote'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    fNetTotal = json['FNetTotal'];
    fPaidAmount = json['FPaidAmount'];
    fBalanceAmount = json['FBalanceAmount'];
    fCreditAmount = json['FCreditAmount'];
    fDebitAmount = json['FDebitAmount'];
    fAdvancePayment = json['FAdvancePayment'];
    currencyCode = json['CurrencyCode'];
    currencyRate = json['CurrencyRate'];
    currencyValue = json['CurrencyValue'];
    tranType = json['TranType'];
  }

  int? orgId;
  String? tranNo;
  String? invoiceDate;
  String? invoiceDateString;
  String? invoiceNo;
  double? netTotal;
  double? paidAmount;
  double? balaceAmount;
  double? creditAmount;
  double? debitAmount;
  double? advancePayment;
  int? carryDays;
  double? badDebit;
  double? discount;
  double? creditNote;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  double? fNetTotal;
  double? fPaidAmount;
  double? fBalanceAmount;
  double? fCreditAmount;
  double? fDebitAmount;
  double? fAdvancePayment;
  String? currencyCode;
  double? currencyRate;
  double? currencyValue;

  String? tranType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['InvoiceDate'] = invoiceDate;
    map['InvoiceDateString'] = invoiceDateString;
    map['InvoiceNo'] = invoiceNo;
    map['NetTotal'] = netTotal;
    map['PaidAmount'] = paidAmount;
    map['BalaceAmount'] = balaceAmount;
    map['CreditAmount'] = creditAmount;
    map['DebitAmount'] = debitAmount;
    map['AdvancePayment'] = advancePayment;
    map['CarryDays'] = carryDays;
    map['BadDebit'] = badDebit;
    map['Discount'] = discount;
    map['CreditNote'] = creditNote;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['FNetTotal'] = fNetTotal;
    map['FPaidAmount'] = fPaidAmount;
    map['FBalanceAmount'] = fBalanceAmount;
    map['FCreditAmount'] = fCreditAmount;
    map['FDebitAmount'] = fDebitAmount;
    map['FAdvancePayment'] = fAdvancePayment;
    map['CurrencyCode'] = currencyCode;
    map['CurrencyRate'] = currencyRate;
    map['CurrencyValue'] = currencyValue;
    map['TranType'] = tranType;
    return map;
  }
}
