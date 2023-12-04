class GetSupplierModel {
  GetSupplierModel({
    this.orgId,
    this.code,
    this.name,
    this.uniqueNo,
    this.mail,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.countryId,
    this.countryName,
    this.postalCode,
    this.mobile,
    this.phone,
    this.fax,
    this.taxTypeId,
    this.currencyId,
    this.paymentTerms,
    this.salesPerson,
    this.source,
    this.isActive,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.activity1,
    this.activity2,
    this.contactPerson,
    this.account,
    this.isBothSave,
  });

  GetSupplierModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    code = json['Code'];
    name = json['Name'];
    uniqueNo = json['UniqueNo'];
    mail = json['Mail'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    countryId = json['CountryId'];
    countryName = json['CountryName'];
    postalCode = json['PostalCode'];
    mobile = json['Mobile'];
    phone = json['Phone'];
    fax = json['Fax'];
    taxTypeId = json['TaxTypeId'];
    currencyId = json['CurrencyId'];
    paymentTerms = json['PaymentTerms'];
    salesPerson = json['SalesPerson'];
    source = json['Source'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    activity1 = json['Activity1'];
    activity2 = json['Activity2'];
    contactPerson = json['ContactPerson'];
    account = json['Account'];
    isBothSave = json['IsBothSave'];
  }

  int? orgId;
  String? code;
  String? name;
  String? uniqueNo;
  String? mail;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? countryId;
  String? countryName;
  String? postalCode;
  String? mobile;
  String? phone;
  String? fax;
  int? taxTypeId;
  String? currencyId;
  String? paymentTerms;
  String? salesPerson;
  String? source;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  String? activity1;
  String? activity2;
  String? contactPerson;
  String? account;
  bool? isBothSave;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['Code'] = code;
    map['Name'] = name;
    map['UniqueNo'] = uniqueNo;
    map['Mail'] = mail;
    map['AddressLine1'] = addressLine1;
    map['AddressLine2'] = addressLine2;
    map['AddressLine3'] = addressLine3;
    map['CountryId'] = countryId;
    map['CountryName'] = countryName;
    map['PostalCode'] = postalCode;
    map['Mobile'] = mobile;
    map['Phone'] = phone;
    map['Fax'] = fax;
    map['TaxTypeId'] = taxTypeId;
    map['CurrencyId'] = currencyId;
    map['PaymentTerms'] = paymentTerms;
    map['SalesPerson'] = salesPerson;
    map['Source'] = source;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['Activity1'] = activity1;
    map['Activity2'] = activity2;
    map['ContactPerson'] = contactPerson;
    map['Account'] = account;
    map['IsBothSave'] = isBothSave;
    return map;
  }
}
