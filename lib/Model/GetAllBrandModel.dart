class GetAllBrandModel {
  GetAllBrandModel({
    this.code,
    this.name,
    this.brandChineseDescription,
    this.brandDisplayOrder,
    this.countryId,
    this.logo,
    this.isActive,
    this.isPOS,
    this.isB2B,
    this.isB2C,
    this.isERP,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.orgId,
    this.itemImage,
    this.itemImageString,
    this.organisationId,
    this.itemBrandId,
    this.itemName,
    this.itemId,
  });

  GetAllBrandModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    name = json['Name'];
    brandChineseDescription = json['BrandChineseDescription'];
    brandDisplayOrder = json['BrandDisplayOrder'];
    countryId = json['CountryId'];
    logo = json['Logo'];
    isActive = json['IsActive'];
    isPOS = json['IsPOS'];
    isB2B = json['IsB2B'];
    isB2C = json['IsB2C'];
    isERP = json['IsERP'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    orgId = json['OrgId'];
    itemImage = json['ItemImage'];
    itemImageString = json['ItemImageString'];
    organisationId = json['OrganisationId'];
    itemBrandId = json['ItemBrandId'];
    itemName = json['ItemName'];
    itemId = json['ItemId'];
  }

  String? code;
  String? name;
  String? brandChineseDescription;
  int? brandDisplayOrder;
  dynamic countryId;
  dynamic logo;
  bool? isActive;
  bool? isPOS;
  bool? isB2B;
  bool? isB2C;
  bool? isERP;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  int? orgId;
  dynamic itemImage;
  dynamic itemImageString;
  int? organisationId;
  String? itemBrandId;
  dynamic itemName;
  dynamic itemId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Code'] = code;
    map['Name'] = name;
    map['BrandChineseDescription'] = brandChineseDescription;
    map['BrandDisplayOrder'] = brandDisplayOrder;
    map['CountryId'] = countryId;
    map['Logo'] = logo;
    map['IsActive'] = isActive;
    map['IsPOS'] = isPOS;
    map['IsB2B'] = isB2B;
    map['IsB2C'] = isB2C;
    map['IsERP'] = isERP;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['OrgId'] = orgId;
    map['ItemImage'] = itemImage;
    map['ItemImageString'] = itemImageString;
    map['OrganisationId'] = organisationId;
    map['ItemBrandId'] = itemBrandId;
    map['ItemName'] = itemName;
    map['ItemId'] = itemId;
    return map;
  }
}
