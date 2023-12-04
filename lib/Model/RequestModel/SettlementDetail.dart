class SettlementDetail {
  SettlementDetail({
      this.orgId, 
      this.settlementNo, 
      this.slNo, 
      this.denomination, 
      this.denominationCount, 
      this.total, 
      this.createdBy, 
      this.createdOn, 
      this.changedBy, 
      this.changedOn, 
      this.isActive,});

  SettlementDetail.fromJson(dynamic json) {
    orgId = json['OrgId'];
    settlementNo = json['SettlementNo'];
    slNo = json['SlNo'];
    denomination = json['Denomination'];
    denominationCount = json['DenominationCount'];
    total = json['Total'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    isActive = json['IsActive'];
  }
  int? orgId;
  String? settlementNo;
  int? slNo;
  int? denomination;
  int? denominationCount;
  int? total;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['SettlementNo'] = settlementNo;
    map['SlNo'] = slNo;
    map['Denomination'] = denomination;
    map['DenominationCount'] = denominationCount;
    map['Total'] = total;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['IsActive'] = isActive;
    return map;
  }

}