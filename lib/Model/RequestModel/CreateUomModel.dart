class CreateUomModel {
  CreateUomModel({
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
      this.changedBy, 
      this.changedOn, 
      this.createdOnString, 
      this.changedOnString,});

  CreateUomModel.fromJson(dynamic json) {
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
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    createdOnString = json['CreatedOnString'];
    changedOnString = json['ChangedOnString'];
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
  String? changedBy;
  String? changedOn;
  String? createdOnString;
  String? changedOnString;

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
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['CreatedOnString'] = createdOnString;
    map['ChangedOnString'] = changedOnString;
    return map;
  }

}