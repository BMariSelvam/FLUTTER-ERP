class CreateBankModel {
  CreateBankModel({
      this.orgId, 
      this.code, 
      this.name, 
      this.displayOrder, 
      this.isPOS, 
      this.isB2B, 
      this.isB2C, 
      this.isERP, 
      this.isActive, 
      this.createdBy, 
      this.createdOn, 
      this.createdOnString, 
      this.changedBy, 
      this.changedOn, 
      this.changedOnString, 
      this.remarks,});

  CreateBankModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    code = json['Code'];
    name = json['Name'];
    displayOrder = json['DisplayOrder'];
    isPOS = json['IsPOS'];
    isB2B = json['IsB2B'];
    isB2C = json['IsB2C'];
    isERP = json['IsERP'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    createdOnString = json['CreatedOnString'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    changedOnString = json['ChangedOnString'];
    remarks = json['Remarks'];
  }
  int? orgId;
  String? code;
  String? name;
  int? displayOrder;
  bool? isPOS;
  bool? isB2B;
  bool? isB2C;
  bool? isERP;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? createdOnString;
  String? changedBy;
  String? changedOn;
  String? changedOnString;
  String? remarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['Code'] = code;
    map['Name'] = name;
    map['DisplayOrder'] = displayOrder;
    map['IsPOS'] = isPOS;
    map['IsB2B'] = isB2B;
    map['IsB2C'] = isB2C;
    map['IsERP'] = isERP;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['CreatedOnString'] = createdOnString;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['ChangedOnString'] = changedOnString;
    map['Remarks'] = remarks;
    return map;
  }

}