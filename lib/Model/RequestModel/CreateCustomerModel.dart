class CreateCustomerModel {
  CreateCustomerModel({
      this.orgId, 
      this.code, 
      this.name, 
      this.customerGroup, 
      this.remarks, 
      this.customerType, 
      this.taxType, 
      this.uniqueNo, 
      this.mail, 
      this.addressLine1, 
      this.addressLine2, 
      this.addressLine3, 
      this.countryId, 
      this.postalCode, 
      this.mobile, 
      this.phone, 
      this.fax, 
      this.currencyId, 
      this.taxTypeId, 
      this.directorName, 
      this.directorPhone, 
      this.directorMobile, 
      this.directorMail, 
      this.salesPerson, 
      this.paymentTerms, 
      this.source, 
      this.isActive, 
      this.isOutStanding, 
      this.createdBy, 
      this.createdOn, 
      this.changedBy, 
      this.changedOn, 
      this.activity1, 
      this.activity2, 
      this.contactPerson, 
      this.countryName, 
      this.priceSettings, 
      this.creditLimit, 
      this.outstandingAmount, 
      this.taxPerc, 
      this.account, 
      this.isVisited, 
      this.visitedNo, 
      this.visitedDate, 
      this.password, 
      this.contactType, 
      this.currencyRate, 
      this.currencyValue, 
      this.orgRefCode,});

  CreateCustomerModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    code = json['Code'];
    name = json['Name'];
    customerGroup = json['CustomerGroup'];
    remarks = json['Remarks'];
    customerType = json['CustomerType'];
    taxType = json['TaxType'];
    uniqueNo = json['UniqueNo'];
    mail = json['Mail'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    countryId = json['CountryId'];
    postalCode = json['PostalCode'];
    mobile = json['Mobile'];
    phone = json['Phone'];
    fax = json['Fax'];
    currencyId = json['CurrencyId'];
    taxTypeId = json['TaxTypeId'];
    directorName = json['DirectorName'];
    directorPhone = json['DirectorPhone'];
    directorMobile = json['DirectorMobile'];
    directorMail = json['DirectorMail'];
    salesPerson = json['SalesPerson'];
    paymentTerms = json['PaymentTerms'];
    source = json['Source'];
    isActive = json['IsActive'];
    isOutStanding = json['IsOutStanding'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    activity1 = json['Activity1'];
    activity2 = json['Activity2'];
    contactPerson = json['ContactPerson'];
    countryName = json['CountryName'];
    priceSettings = json['PriceSettings'];
    creditLimit = json['CreditLimit'];
    outstandingAmount = json['OutstandingAmount'];
    taxPerc = json['TaxPerc'];
    account = json['Account'];
    isVisited = json['IsVisited'];
    visitedNo = json['VisitedNo'];
    visitedDate = json['VisitedDate'];
    password = json['Password'];
    contactType = json['ContactType'];
    currencyRate = json['CurrencyRate'];
    currencyValue = json['CurrencyValue'];
    orgRefCode = json['OrgRefCode'];
  }
  int? orgId;
  String? code;
  String? name;
  String? customerGroup;
  String? remarks;
  String? customerType;
  String? taxType;
  String? uniqueNo;
  String? mail;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? countryId;
  String? postalCode;
  String? mobile;
  String? phone;
  String? fax;
  String? currencyId;
  String? taxTypeId;
  String? directorName;
  String? directorPhone;
  String? directorMobile;
  String? directorMail;
  String? salesPerson;
  String? paymentTerms;
  String? source;
  bool? isActive;
  bool? isOutStanding;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  String? activity1;
  String? activity2;
  String? contactPerson;
  String? countryName;
  String? priceSettings;
  int? creditLimit;
  int? outstandingAmount;
  int? taxPerc;
  String? account;
  int? isVisited;
  int? visitedNo;
  String? visitedDate;
  String? password;
  String? contactType;
  int? currencyRate;
  int? currencyValue;
  String? orgRefCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['Code'] = code;
    map['Name'] = name;
    map['CustomerGroup'] = customerGroup;
    map['Remarks'] = remarks;
    map['CustomerType'] = customerType;
    map['TaxType'] = taxType;
    map['UniqueNo'] = uniqueNo;
    map['Mail'] = mail;
    map['AddressLine1'] = addressLine1;
    map['AddressLine2'] = addressLine2;
    map['AddressLine3'] = addressLine3;
    map['CountryId'] = countryId;
    map['PostalCode'] = postalCode;
    map['Mobile'] = mobile;
    map['Phone'] = phone;
    map['Fax'] = fax;
    map['CurrencyId'] = currencyId;
    map['TaxTypeId'] = taxTypeId;
    map['DirectorName'] = directorName;
    map['DirectorPhone'] = directorPhone;
    map['DirectorMobile'] = directorMobile;
    map['DirectorMail'] = directorMail;
    map['SalesPerson'] = salesPerson;
    map['PaymentTerms'] = paymentTerms;
    map['Source'] = source;
    map['IsActive'] = isActive;
    map['IsOutStanding'] = isOutStanding;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['Activity1'] = activity1;
    map['Activity2'] = activity2;
    map['ContactPerson'] = contactPerson;
    map['CountryName'] = countryName;
    map['PriceSettings'] = priceSettings;
    map['CreditLimit'] = creditLimit;
    map['OutstandingAmount'] = outstandingAmount;
    map['TaxPerc'] = taxPerc;
    map['Account'] = account;
    map['IsVisited'] = isVisited;
    map['VisitedNo'] = visitedNo;
    map['VisitedDate'] = visitedDate;
    map['Password'] = password;
    map['ContactType'] = contactType;
    map['CurrencyRate'] = currencyRate;
    map['CurrencyValue'] = currencyValue;
    map['OrgRefCode'] = orgRefCode;
    return map;
  }

}