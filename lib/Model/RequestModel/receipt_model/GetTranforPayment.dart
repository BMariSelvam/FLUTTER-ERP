import 'package:flutter/material.dart';

class GetTranforPayment {
  GetTranforPayment({
    this.tranNo,
    this.tranDate,
    this.currencyCode,
    this.currencyRate,
    this.currencyValue,
    this.netTotal,
    this.receivedAmount,
    this.balanceAmount,
    this.advanceAmount,
    this.paidAmount,
    this.tranDateString,
    this.creditAmount,
    this.debitAmount,
    this.advancePayment,
    this.carryDays,
    this.fNetTotal,
    this.fReceivedAmount,
    this.fBalanceAmount,
    this.fPaidAmount,
    this.fCreditAmount,
    this.fDebitAmount,
    this.tranType,
  });

  GetTranforPayment.fromJson(dynamic json) {
    tranNo = json['TranNo'];
    tranDate = json['TranDate'];
    currencyCode = json['CurrencyCode'];
    currencyRate = json['CurrencyRate'];
    currencyValue = json['CurrencyValue'];
    netTotal = json['NetTotal'];
    receivedAmount = json['ReceivedAmount'];
    balanceAmount = json['BalanceAmount'];
    advanceAmount = json['AdvanceAmount'];
    paidAmount = json['PaidAmount'];
    tranDateString = json['TranDateString'];
    creditAmount = json['CreditAmount'];
    debitAmount = json['DebitAmount'];
    advancePayment = json['AdvancePayment'];
    carryDays = json['CarryDays'];
    fNetTotal = json['FNetTotal'];
    fReceivedAmount = json['FReceivedAmount'];
    fBalanceAmount = json['FBalanceAmount'];
    fPaidAmount = json['FPaidAmount'];
    fCreditAmount = json['FCreditAmount'];
    fDebitAmount = json['FDebitAmount'];
    tranType = json['TranType'];
  }

  String? tranNo;
  String? tranDate;
  String? currencyCode;
  double? currencyRate;
  double? currencyValue;
  double? netTotal;
  double? receivedAmount;
  double? balanceAmount;
  double? advanceAmount;
  double? paidAmount;
  String? tranDateString;
  double? creditAmount;
  double? debitAmount;
  double? advancePayment;
  int? carryDays;
  double? fNetTotal;
  double? fReceivedAmount;
  double? fBalanceAmount;
  double? fPaidAmount;
  double? fCreditAmount;
  double? fDebitAmount;
  String? tranType;
  TextEditingController paidController = TextEditingController();
  TextEditingController creditController = TextEditingController();
  bool isChecked = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TranNo'] = tranNo;
    map['TranDate'] = tranDate;
    map['CurrencyCode'] = currencyCode;
    map['CurrencyRate'] = currencyRate;
    map['CurrencyValue'] = currencyValue;
    map['NetTotal'] = netTotal;
    map['ReceivedAmount'] = receivedAmount;
    map['BalanceAmount'] = balanceAmount;
    map['AdvanceAmount'] = advanceAmount;
    map['PaidAmount'] = paidAmount;
    map['TranDateString'] = tranDateString;
    map['CreditAmount'] = creditAmount;
    map['DebitAmount'] = debitAmount;
    map['AdvancePayment'] = advancePayment;
    map['CarryDays'] = carryDays;
    map['FNetTotal'] = fNetTotal;
    map['FReceivedAmount'] = fReceivedAmount;
    map['FBalanceAmount'] = fBalanceAmount;
    map['FPaidAmount'] = fPaidAmount;
    map['FCreditAmount'] = fCreditAmount;
    map['FDebitAmount'] = fDebitAmount;
    map['TranType'] = tranType;
    return map;
  }
}
