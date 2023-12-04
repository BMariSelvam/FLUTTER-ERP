class StockQty {
  StockQty({
    this.orgId,
    this.code,
    this.name,
    this.stockQty,
    this.stockBoxQty,
    this.stockPcsQty,
    this.stockWQty,
    this.pcsPerCarton,
  });

  StockQty.fromJson(dynamic json) {
    orgId = json['OrgId'];
    code = json['Code'];
    name = json['Name'];
    stockQty = json['StockQty'];
    stockBoxQty = json['StockBoxQty'];
    stockPcsQty = json['StockPcsQty'];
    stockWQty = json['StockWQty'];
    pcsPerCarton = json['PcsPerCarton'];
  }
  int? orgId;
  String? code;
  String? name;
  double? stockQty;
  double? stockBoxQty;
  double? stockPcsQty;
  double? stockWQty;
  double? pcsPerCarton;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['Code'] = code;
    map['Name'] = name;
    map['StockQty'] = stockQty;
    map['StockBoxQty'] = stockBoxQty;
    map['StockPcsQty'] = stockPcsQty;
    map['StockWQty'] = stockWQty;
    map['PcsPerCarton'] = pcsPerCarton;
    return map;
  }
}
