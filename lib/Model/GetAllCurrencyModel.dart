class GetAllCurrencyModel {
  GetAllCurrencyModel({
    this.orgId,
    this.code,
    this.name,
    this.shortCode,
    this.currencyRate,
    this.currencyValue,
    this.displayOrder,
    this.isActive,
    this.isPOS,
    this.isB2B,
    this.isB2C,
    this.isERP,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.isDefault,
  });

  GetAllCurrencyModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    code = json['Code'];
    name = json['Name'];
    shortCode = json['ShortCode'];
    currencyRate = json['CurrencyRate'];
    currencyValue = json['CurrencyValue'];
    displayOrder = json['DisplayOrder'];
    isActive = json['IsActive'];
    isPOS = json['IsPOS'];
    isB2B = json['IsB2B'];
    isB2C = json['IsB2C'];
    isERP = json['IsERP'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    isDefault = json['IsDefault'];
  }

  int? orgId;
  String? code;
  String? name;
  String? shortCode;
  double? currencyRate;
  double? currencyValue;
  int? displayOrder;
  bool? isActive;
  bool? isPOS;
  bool? isB2B;
  bool? isB2C;
  bool? isERP;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  bool? isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['Code'] = code;
    map['Name'] = name;
    map['ShortCode'] = shortCode;
    map['CurrencyRate'] = currencyRate;
    map['CurrencyValue'] = currencyValue;
    map['DisplayOrder'] = displayOrder;
    map['IsActive'] = isActive;
    map['IsPOS'] = isPOS;
    map['IsB2B'] = isB2B;
    map['IsB2C'] = isB2C;
    map['IsERP'] = isERP;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['IsDefault'] = isDefault;
    return map;
  }

  @override
  String toString() {
    return '$name';
  }
}
