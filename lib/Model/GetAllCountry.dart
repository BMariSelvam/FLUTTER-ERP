class GetAllCountry {
  GetAllCountry({
    this.countryCode,
    this.countryName,
    this.isActive,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.countryCurrencyCode,
    this.countryCurrencyName,
    this.countryCurrencySymbol,
    this.countryDialCode,
    this.countryCultureInfo,
    this.countryDisplayOrder,
  });

  GetAllCountry.fromJson(dynamic json) {
    countryCode = json['CountryCode'];
    countryName = json['CountryName'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    countryCurrencyCode = json['CountryCurrencyCode'];
    countryCurrencyName = json['CountryCurrencyName'];
    countryCurrencySymbol = json['CountryCurrencySymbol'];
    countryDialCode = json['CountryDialCode'];
    countryCultureInfo = json['CountryCultureInfo'];
    countryDisplayOrder = json['CountryDisplayOrder'];
  }

  String? countryCode;
  String? countryName;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  dynamic countryCurrencyCode;
  dynamic countryCurrencyName;
  dynamic countryCurrencySymbol;
  String? countryDialCode;
  dynamic countryCultureInfo;
  dynamic countryDisplayOrder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CountryCode'] = countryCode;
    map['CountryName'] = countryName;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['CountryCurrencyCode'] = countryCurrencyCode;
    map['CountryCurrencyName'] = countryCurrencyName;
    map['CountryCurrencySymbol'] = countryCurrencySymbol;
    map['CountryDialCode'] = countryDialCode;
    map['CountryCultureInfo'] = countryCultureInfo;
    map['CountryDisplayOrder'] = countryDisplayOrder;
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$countryName';
  }
}
