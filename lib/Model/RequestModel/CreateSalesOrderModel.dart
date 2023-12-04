import 'package:erp/Model/RequestModel/SalesOrderDetail.dart';

class SalesOrder {
  int? orgId;
  String? tranNo;
  String? tranDate;
  String? customerId;
  String? customerName;
  String? customerAddress;
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
  String? assignTo;
  String? tranDateString;
  int? status;
  List<SalesOrderDetail>? salesOrderDetail;
  bool? isUpdate;
  dynamic customerShipToId;
  dynamic customerShipToAddress;
  dynamic priceSettingCode;
  dynamic termCode;
  dynamic invoiceType;
  dynamic billDiscount;
  double? latitude;
  double? longitude;
  dynamic signatureimage;
  dynamic cameraimage;
  String? summaryRemarks;
  dynamic addressLine1;
  double? fBillDiscount;
  double? fDiscountPerc;
  double? currencyValue;
  dynamic authorizedSignature;
  dynamic authorizedImage;
  dynamic cameraImage;
  dynamic signImage;
  dynamic signImgBase64String;
  dynamic cameraImgBase64String;
  dynamic authImgBase64String;
  dynamic isView;

  SalesOrder({
    this.orgId,
    this.tranNo,
    this.tranDate,
    this.customerId,
    this.customerName,
    this.customerAddress,
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
    this.salesOrderDetail,
    this.isUpdate,
    this.customerShipToId,
    this.customerShipToAddress,
    this.priceSettingCode,
    this.termCode,
    this.invoiceType,
    this.billDiscount,
    this.latitude,
    this.longitude,
    this.signatureimage,
    this.cameraimage,
    this.summaryRemarks,
    this.addressLine1,
    this.fBillDiscount,
    this.fDiscountPerc,
    this.currencyValue,
    this.authorizedSignature,
    this.authorizedImage,
    this.cameraImage,
    this.signImage,
    this.signImgBase64String,
    this.cameraImgBase64String,
    this.authImgBase64String,
    this.isView,
  });

  SalesOrder.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    tranDate = json['TranDate'];
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    customerAddress = json['CustomerAddress'];
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
    if (json['SalesOrderDetail'] != null) {
      salesOrderDetail = [];
      json['SalesOrderDetail'].forEach((v) {
        salesOrderDetail?.add(SalesOrderDetail.fromJson(v));
      });
    }
    isUpdate = json['IsUpdate'];
    customerShipToId = json['CustomerShipToId'];
    customerShipToAddress = json['CustomerShipToAddress'];
    priceSettingCode = json['PriceSettingCode'];
    termCode = json['TermCode'];
    invoiceType = json['InvoiceType'];
    billDiscount = json['BillDiscount'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    signatureimage = json['Signatureimage'];
    cameraimage = json['Cameraimage'];
    summaryRemarks = json['SummaryRemarks'];
    addressLine1 = json['AddressLine1'];
    fBillDiscount = json['FBillDiscount'];
    fDiscountPerc = json['FDiscountPerc'];
    currencyValue = json['CurrencyValue'];
    authorizedSignature = json['AuthorizedSignature'];
    authorizedImage = json['AuthorizedImage'];
    cameraImage = json['CameraImage'];
    signImage = json['SignImage'];
    signImgBase64String = json['SignImg_Base64String'];
    cameraImgBase64String = json['CameraImg_Base64String'];
    authImgBase64String = json['AuthImg_Base64String'];
    isView = json['IsView'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['TranDate'] = tranDate;
    map['CustomerId'] = customerId;
    map['CustomerName'] = customerName;
    map['CustomerAddress'] = customerAddress;
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
    if (salesOrderDetail != null) {
      map['SalesOrderDetail'] =
          salesOrderDetail?.map((v) => v.toJson()).toList();
    }
    map['IsUpdate'] = isUpdate;
    map['CustomerShipToId'] = customerShipToId;
    map['CustomerShipToAddress'] = customerShipToAddress;
    map['PriceSettingCode'] = priceSettingCode;
    map['TermCode'] = termCode;
    map['InvoiceType'] = invoiceType;
    map['BillDiscount'] = billDiscount;
    map['Latitude'] = latitude;
    map['Longitude'] = longitude;
    map['Signatureimage'] = signatureimage;
    map['Cameraimage'] = cameraimage;
    map['SummaryRemarks'] = summaryRemarks;
    map['AddressLine1'] = addressLine1;
    map['FBillDiscount'] = fBillDiscount;
    map['FDiscountPerc'] = fDiscountPerc;
    map['CurrencyValue'] = currencyValue;
    map['AuthorizedSignature'] = authorizedSignature;
    map['AuthorizedImage'] = authorizedImage;
    map['CameraImage'] = cameraImage;
    map['SignImage'] = signImage;
    map['SignImg_Base64String'] = signImgBase64String;
    map['CameraImg_Base64String'] = cameraImgBase64String;
    map['AuthImg_Base64String'] = authImgBase64String;
    map['IsView'] = isView;
    return map;
  }
}
