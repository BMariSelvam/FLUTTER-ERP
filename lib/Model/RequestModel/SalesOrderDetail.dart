class SalesOrderDetail {
  SalesOrderDetail({
    this.orgId,
    this.tranNo,
    this.slNo,
    this.productCode,
    this.productName,
    this.boxQty,
    this.pcsQty,
    this.qty,
    this.boxCount,
    this.boxPrice,
    this.price,
    this.foc,
    this.exchange,
    this.total,
    this.itemDiscount,
    this.itemDiscountPerc,
    this.subTotal,
    this.tax,
    this.netTotal,
    this.fBoxPrice,
    this.fPrice,
    this.fTotal,
    this.fItemDiscount,
    this.fSubTotal,
    this.fTax,
    this.fNetTotal,
    this.remarks,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.stockQty,
    this.stockBoxQty,
    this.stockPcsQty,
    this.weight,
    this.isWeight,
    this.fItemDiscountPerc,
  });

  SalesOrderDetail.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    slNo = json['SlNo'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    boxQty = json['BoxQty'];
    pcsQty = json['PcsQty'];
    qty = json['Qty'];
    boxCount = json['BoxCount'];
    boxPrice = json['BoxPrice'];
    price = json['Price'];
    foc = json['Foc'];
    exchange = json['Exchange'];
    total = json['Total'];
    itemDiscount = json['ItemDiscount'];
    itemDiscountPerc = json['ItemDiscountPerc'];
    subTotal = json['SubTotal'];
    tax = json['Tax'];
    netTotal = json['NetTotal'];
    fBoxPrice = json['FBoxPrice'];
    fPrice = json['FPrice'];
    fTotal = json['FTotal'];
    fItemDiscount = json['FItemDiscount'];
    fSubTotal = json['FSubTotal'];
    fTax = json['FTax'];
    fNetTotal = json['FNetTotal'];
    remarks = json['Remarks'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    stockQty = json['StockQty'];
    stockBoxQty = json['StockBoxQty'];
    stockPcsQty = json['StockPcsQty'];
    weight = json['Weight'];
    isWeight = json['IsWeight'];
    fItemDiscountPerc = json['FItemDiscountPerc'];
  }

  int? orgId;
  String? tranNo;
  int? slNo;
  String? productCode;
  String? productName;
  int? boxQty;
  int? pcsQty;
  int? qty;
  int? boxCount;
  double? boxPrice;
  double? price;
  int? foc;
  int? exchange;
  double? total;
  double? itemDiscount;
  double? itemDiscountPerc;
  double? subTotal;
  double? tax;
  double? netTotal;
  double? fBoxPrice;
  double? fPrice;
  double? fTotal;
  double? fItemDiscount;
  double? fSubTotal;
  double? fTax;
  double? fNetTotal;
  String? remarks;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  double? stockQty;
  int? stockBoxQty;
  int? stockPcsQty;
  double? weight;
  bool? isWeight;
  double? fItemDiscountPerc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['SlNo'] = slNo;
    map['ProductCode'] = productCode;
    map['ProductName'] = productName;
    map['BoxQty'] = boxQty;
    map['PcsQty'] = pcsQty;
    map['Qty'] = qty;
    map['BoxCount'] = boxCount;
    map['BoxPrice'] = boxPrice;
    map['Price'] = price;
    map['Foc'] = foc;
    map['Exchange'] = exchange;
    map['Total'] = total;
    map['ItemDiscount'] = itemDiscount;
    map['ItemDiscountPerc'] = itemDiscountPerc;
    map['SubTotal'] = subTotal;
    map['Tax'] = tax;
    map['NetTotal'] = netTotal;
    map['FBoxPrice'] = fBoxPrice;
    map['FPrice'] = fPrice;
    map['FTotal'] = fTotal;
    map['FItemDiscount'] = fItemDiscount;
    map['FSubTotal'] = fSubTotal;
    map['FTax'] = fTax;
    map['FNetTotal'] = fNetTotal;
    map['Remarks'] = remarks;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['StockQty'] = stockQty;
    map['StockBoxQty'] = stockBoxQty;
    map['StockPcsQty'] = stockPcsQty;
    map['Weight'] = weight;
    map['IsWeight'] = isWeight;
    map['FItemDiscountPerc'] = fItemDiscountPerc;
    return map;
  }
}
