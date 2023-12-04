import 'SubCategoryDetail.dart';

class GetAllCategory {
  GetAllCategory({
    this.orgId,
    this.code,
    this.name,
    this.chineseDescription,
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
    this.categoryImageFileName,
    this.categoryImageFilePath,
    this.categoryImgBase64String,
    this.categoryImage,
    this.subCategoryDetail,
  });

  GetAllCategory.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    code = json['Code'];
    name = json['Name'];
    chineseDescription = json['ChineseDescription'];
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
    categoryImageFileName = json['CategoryImageFileName'];
    categoryImageFilePath = json['CategoryImageFilePath'];
    categoryImgBase64String = json['CategoryImg_Base64String'];
    categoryImage = json['CategoryImage'];
    if (json['SubCategoryDetail'] != null) {
      subCategoryDetail = [];
      json['SubCategoryDetail'].forEach((v) {
        subCategoryDetail?.add(SubCategoryDetail.fromJson(v));
      });
    }
  }

  int? orgId;
  String? code;
  String? name;
  String? chineseDescription;
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
  dynamic categoryImageFileName;
  String? categoryImageFilePath;
  dynamic categoryImgBase64String;
  dynamic categoryImage;
  List<SubCategoryDetail>? subCategoryDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['Code'] = code;
    map['Name'] = name;
    map['ChineseDescription'] = chineseDescription;
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
    map['CategoryImageFileName'] = categoryImageFileName;
    map['CategoryImageFilePath'] = categoryImageFilePath;
    map['CategoryImg_Base64String'] = categoryImgBase64String;
    map['CategoryImage'] = categoryImage;
    if (subCategoryDetail != null) {
      map['SubCategoryDetail'] =
          subCategoryDetail?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return "$name";
  }
}
