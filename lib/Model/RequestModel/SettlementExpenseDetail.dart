class SettlementExpenseDetail {
  SettlementExpenseDetail({
      this.orgId, 
      this.settlementNo, 
      this.slNo, 
      this.gLCode, 
      this.gLDescription, 
      this.amount, 
      this.createdBy, 
      this.createdOn, 
      this.changedBy, 
      this.changedOn,});

  SettlementExpenseDetail.fromJson(dynamic json) {
    orgId = json['OrgId'];
    settlementNo = json['SettlementNo'];
    slNo = json['SlNo'];
    gLCode = json['GLCode'];
    gLDescription = json['GLDescription'];
    amount = json['Amount'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
  }
  int? orgId;
  String? settlementNo;
  int? slNo;
  String? gLCode;
  String? gLDescription;
  int? amount;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['SettlementNo'] = settlementNo;
    map['SlNo'] = slNo;
    map['GLCode'] = gLCode;
    map['GLDescription'] = gLDescription;
    map['Amount'] = amount;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    return map;
  }

}