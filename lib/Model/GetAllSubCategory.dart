class GetAllSubCategory {
  GetAllSubCategory({
    this.orgId,
    this.code,
    this.name,
    this.categoryName,
    this.chineseDescription,
    this.categoryCode,
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
    this.changedOnString,
    this.iconImageFileName,
    this.iconImageFilePath,
    this.iconImgBase64String,
    this.iconImage,
    this.subCategoryImageFileName,
    this.subCategoryImageFilePath,
    this.subCategoryImgBase64String,
    this.subCategoryImage,
  });

  GetAllSubCategory.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    code = json['Code'];
    name = json['Name'];
    categoryName = json['CategoryName'];
    chineseDescription = json['ChineseDescription'];
    categoryCode = json['CategoryCode'];
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
    iconImageFileName = json['IconImageFileName'];
    iconImageFilePath = json['IconImageFilePath'];
    iconImgBase64String = json['IconImg_Base64String'];
    iconImage = json['IconImage'];
    subCategoryImageFileName = json['SubCategoryImageFileName'];
    subCategoryImageFilePath = json['SubCategoryImageFilePath'];
    subCategoryImgBase64String = json['SubCategoryImg_Base64String'];
    subCategoryImage = json['SubCategoryImage'];
  }

  int? orgId;
  String? code;
  String? name;
  String? categoryName;
  String? chineseDescription;
  String? categoryCode;
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
  dynamic iconImageFileName;
  String? iconImageFilePath;
  dynamic iconImgBase64String;
  dynamic iconImage;
  dynamic subCategoryImageFileName;
  String? subCategoryImageFilePath;
  dynamic subCategoryImgBase64String;
  dynamic subCategoryImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['Code'] = code;
    map['Name'] = name;
    map['CategoryName'] = categoryName;
    map['ChineseDescription'] = chineseDescription;
    map['CategoryCode'] = categoryCode;
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
    map['IconImageFileName'] = iconImageFileName;
    map['IconImageFilePath'] = iconImageFilePath;
    map['IconImg_Base64String'] = iconImgBase64String;
    map['IconImage'] = iconImage;
    map['SubCategoryImageFileName'] = subCategoryImageFileName;
    map['SubCategoryImageFilePath'] = subCategoryImageFilePath;
    map['SubCategoryImg_Base64String'] = subCategoryImgBase64String;
    map['SubCategoryImage'] = subCategoryImage;
    return map;
  }
}
