import 'package:erp/Model/RequestModel/invioce_model/InvoiceDetail.dart';
import 'package:erp/Model/RequestModel/invioce_model/invoice_batch_detail.dart';

class Invoice {
  Invoice({
    this.orgId,
    this.tranNo,
    this.tranDate,
    this.orderNo,
    this.orderDate,
    this.customerId,
    this.customerName,
    this.customerAddress,
    this.locationCode,
    this.taxCode,
    this.taxType,
    this.paymentType,
    this.taxPerc,
    this.currencyCode,
    this.currencyRate,
    this.total,
    this.discount,
    this.discountPerc,
    this.subTotal,
    this.tax,
    this.netTotal,
    this.paidAmount,
    this.balanceAmount,
    this.fTotal,
    this.fDiscount,
    this.fSubTotal,
    this.fTax,
    this.fNetTotal,
    this.fPaidAmount,
    this.fBalanceAmount,
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
    this.orderDateString,
    this.invoiceDetail,
    this.invoiceBatchDetail,
    this.isUpdate,
    this.customerShipToId,
    this.customerShipToAddress,
    this.priceSettingCode,
    this.termCode,
    this.invoiceType,
    this.billDiscount,
    this.creditLimit,
    this.outStanding,
    this.latitude,
    this.longitude,
    this.signatureimage,
    this.sONo,
    this.dONo,
    this.sQNo,
    this.cameraimage,
    this.summaryRemarks,
    this.pLNo,
    this.customerEmail,
    this.salesman,
    this.fDiscountPerc,
    this.fBillDiscount,
    this.currencyValue,
    this.isDraft,
    this.cashRegisterCode,
    this.settlementNo,
    this.authorizedSignature,
    this.authorizedImage,
    this.cameraImage,
    this.signImage,
    this.signImgBase64String,
    this.cameraImgBase64String,
    this.authImgBase64String,
    this.roundOff,
  });

  Invoice.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    tranDate = json['TranDate'];
    orderNo = json['OrderNo'];
    orderDate = json['OrderDate'];
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    customerAddress = json['CustomerAddress'];
    locationCode = json['LocationCode'];
    taxCode = json['TaxCode'];
    taxType = json['TaxType'];
    paymentType = json['PaymentType'];
    taxPerc = json['TaxPerc'];
    currencyCode = json['CurrencyCode'];
    currencyRate = json['CurrencyRate'];
    total = json['Total'];
    discount = json['Discount'];
    discountPerc = json['DiscountPerc'];
    subTotal = json['SubTotal'];
    tax = json['Tax'];
    netTotal = json['NetTotal'];
    paidAmount = json['PaidAmount'];
    balanceAmount = json['BalanceAmount'];
    fTotal = json['FTotal'];
    fDiscount = json['FDiscount'];
    fSubTotal = json['FSubTotal'];
    fTax = json['FTax'];
    fNetTotal = json['FNetTotal'];
    fPaidAmount = json['FPaidAmount'];
    fBalanceAmount = json['FBalanceAmount'];
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
    orderDateString = json['OrderDateString'];
    if (json['InvoiceDetail'] != null) {
      invoiceDetail = [];
      json['InvoiceDetail'].forEach((v) {
        invoiceDetail?.add(InvoiceDetail.fromJson(v));
      });
    }
    if (json['InvoiceBatchDetail'] != null) {
      invoiceBatchDetail = [];
      json['InvoiceBatchDetail'].forEach((v) {
        invoiceBatchDetail?.add(InvoiceBatchDetail.fromJson(v));
      });
    }
    isUpdate = json['IsUpdate'];
    customerShipToId = json['CustomerShipToId'];
    customerShipToAddress = json['CustomerShipToAddress'];
    priceSettingCode = json['PriceSettingCode'];
    termCode = json['TermCode'];
    invoiceType = json['InvoiceType'];
    billDiscount = json['BillDiscount'];
    creditLimit = json['CreditLimit'];
    outStanding = json['OutStanding'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    signatureimage = json['Signatureimage'];
    sONo = json['SONo'];
    dONo = json['DONo'];
    sQNo = json['SQNo'];
    cameraimage = json['Cameraimage'];
    summaryRemarks = json['SummaryRemarks'];
    pLNo = json['PLNo'];
    customerEmail = json['CustomerEmail'];
    salesman = json['Salesman'];
    fDiscountPerc = json['FDiscountPerc'];
    fBillDiscount = json['FBillDiscount'];
    currencyValue = json['CurrencyValue'];
    isDraft = json['IsDraft'];
    cashRegisterCode = json['CashRegisterCode'];
    settlementNo = json['SettlementNo'];
    authorizedSignature = json['AuthorizedSignature'];
    authorizedImage = json['AuthorizedImage'];
    cameraImage = json['CameraImage'];
    signImage = json['SignImage'];
    signImgBase64String = json['SignImg_Base64String'];
    cameraImgBase64String = json['CameraImg_Base64String'];
    authImgBase64String = json['AuthImg_Base64String'];
    roundOff = json['RoundOff'];
  }
  int? orgId;
  String? tranNo;
  String? tranDate;
  String? orderNo;
  String? orderDate;
  String? customerId;
  String? customerName;
  String? customerAddress;
  String? locationCode;
  int? taxCode;
  String? taxType;
  dynamic paymentType;
  double? taxPerc;
  String? currencyCode;
  double? currencyRate;
  double? total;
  double? discount;
  double? discountPerc;
  double? subTotal;
  double? tax;
  double? netTotal;
  double? paidAmount;
  double? balanceAmount;
  double? fTotal;
  double? fDiscount;
  double? fSubTotal;
  double? fTax;
  double? fNetTotal;
  double? fPaidAmount;
  double? fBalanceAmount;
  String? remarks;
  String? referenceNo;
  String? createdFrom;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  String? assignTo;
  String? tranDateString;
  String? orderDateString;
  List<InvoiceDetail>? invoiceDetail;
  List<InvoiceBatchDetail>? invoiceBatchDetail;
  bool? isUpdate;
  dynamic customerShipToId;
  String? customerShipToAddress;
  String? priceSettingCode;
  String? termCode;
  bool? invoiceType;
  double? billDiscount;
  double? creditLimit;
  double? outStanding;
  dynamic latitude;
  dynamic longitude;
  String? signatureimage;
  String? sONo;
  String? dONo;
  dynamic sQNo;
  String? cameraimage;
  dynamic summaryRemarks;
  dynamic pLNo;
  String? customerEmail;
  String? salesman;
  double? fDiscountPerc;
  double? fBillDiscount;
  double? currencyValue;
  dynamic isDraft;
  String? cashRegisterCode;
  String? settlementNo;
  String? authorizedSignature;
  dynamic authorizedImage;
  dynamic cameraImage;
  dynamic signImage;
  dynamic signImgBase64String;
  dynamic cameraImgBase64String;
  dynamic authImgBase64String;
  dynamic roundOff;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['TranDate'] = tranDate;
    map['OrderNo'] = orderNo;
    map['OrderDate'] = orderDate;
    map['CustomerId'] = customerId;
    map['CustomerName'] = customerName;
    map['CustomerAddress'] = customerAddress;
    map['LocationCode'] = locationCode;
    map['TaxCode'] = taxCode;
    map['TaxType'] = taxType;
    map['PaymentType'] = paymentType;
    map['TaxPerc'] = taxPerc;
    map['CurrencyCode'] = currencyCode;
    map['CurrencyRate'] = currencyRate;
    map['Total'] = total;
    map['Discount'] = discount;
    map['DiscountPerc'] = discountPerc;
    map['SubTotal'] = subTotal;
    map['Tax'] = tax;
    map['NetTotal'] = netTotal;
    map['PaidAmount'] = paidAmount;
    map['BalanceAmount'] = balanceAmount;
    map['FTotal'] = fTotal;
    map['FDiscount'] = fDiscount;
    map['FSubTotal'] = fSubTotal;
    map['FTax'] = fTax;
    map['FNetTotal'] = fNetTotal;
    map['FPaidAmount'] = fPaidAmount;
    map['FBalanceAmount'] = fBalanceAmount;
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
    map['OrderDateString'] = orderDateString;
    if (invoiceDetail != null) {
      map['InvoiceDetail'] = invoiceDetail?.map((v) => v.toJson()).toList();
    }
    if (invoiceBatchDetail != null) {
      map['InvoiceBatchDetail'] =
          invoiceBatchDetail?.map((v) => v.toJson()).toList();
    }
    map['IsUpdate'] = isUpdate;
    map['CustomerShipToId'] = customerShipToId;
    map['CustomerShipToAddress'] = customerShipToAddress;
    map['PriceSettingCode'] = priceSettingCode;
    map['TermCode'] = termCode;
    map['InvoiceType'] = invoiceType;
    map['BillDiscount'] = billDiscount;
    map['CreditLimit'] = creditLimit;
    map['OutStanding'] = outStanding;
    map['Latitude'] = latitude;
    map['Longitude'] = longitude;
    map['Signatureimage'] = signatureimage;
    map['SONo'] = sONo;
    map['DONo'] = dONo;
    map['SQNo'] = sQNo;
    map['Cameraimage'] = cameraimage;
    map['SummaryRemarks'] = summaryRemarks;
    map['PLNo'] = pLNo;
    map['CustomerEmail'] = customerEmail;
    map['Salesman'] = salesman;
    map['FDiscountPerc'] = fDiscountPerc;
    map['FBillDiscount'] = fBillDiscount;
    map['CurrencyValue'] = currencyValue;
    map['IsDraft'] = isDraft;
    map['CashRegisterCode'] = cashRegisterCode;
    map['SettlementNo'] = settlementNo;
    map['AuthorizedSignature'] = authorizedSignature;
    map['AuthorizedImage'] = authorizedImage;
    map['CameraImage'] = cameraImage;
    map['SignImage'] = signImage;
    map['SignImg_Base64String'] = signImgBase64String;
    map['CameraImg_Base64String'] = cameraImgBase64String;
    map['AuthImg_Base64String'] = authImgBase64String;
    map['RoundOff'] = roundOff;
    return map;
  }
}
