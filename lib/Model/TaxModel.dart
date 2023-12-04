class TaxModel {
  TaxModel({
    this.orgId,
    this.taxCode,
    this.taxName,
    this.taxPercentage,
    this.taxType,
    this.isActive,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.displayOrder,
  });

  TaxModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    taxCode = json['TaxCode'];
    taxName = json['TaxName'];
    taxPercentage = json['TaxPercentage'];
    taxType = json['TaxType'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    displayOrder = json['DisplayOrder'];
  }

  int? orgId;
  int? taxCode;
  String? taxName;
  double? taxPercentage;
  String? taxType;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  int? displayOrder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TaxCode'] = taxCode;
    map['TaxName'] = taxName;
    map['TaxPercentage'] = taxPercentage;
    map['TaxType'] = taxType;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['DisplayOrder'] = displayOrder;
    return map;
  }
}
