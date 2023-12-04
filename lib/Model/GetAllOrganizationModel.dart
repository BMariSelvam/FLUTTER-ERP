class GetAllOrganization {
  GetAllOrganization({
    this.orgId,
    this.uniqueNo,
    this.name,
    this.activity1,
    this.activity2,
    this.directorName,
    this.contactPersonName,
    this.contactPersonDesignation,
    this.contactPersonPhone,
    this.contactPersonMail,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.countryId,
    this.countryName,
    this.postalCode,
    this.landMark,
    this.phone,
    this.mobile,
    this.fax,
    this.mail,
    this.website,
    this.facebook,
    this.linkedIn,
    this.url,
    this.logo,
    this.isTax,
    this.taxCode,
    this.orgRefCode,
    this.businessRegNo,
    this.taxRegNo,
    this.isFunctional,
    this.employeeSize,
    this.payNowQR,
    this.expiredOn,
    this.displayOrder,
    this.isActive,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.taxPerc,
    this.currencyId,
    this.isB2B,
    this.isB2C,
    this.isERP,
    this.isPos,
    this.image,
    this.imageString,
    this.qRImage,
    this.qRImageString,
    this.qRUENNo,
    this.qRMobileNo,
    this.orgLogoString,
  });

  GetAllOrganization.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    uniqueNo = json['UniqueNo'];
    name = json['Name'];
    activity1 = json['Activity1'];
    activity2 = json['Activity2'];
    directorName = json['DirectorName'];
    contactPersonName = json['ContactPersonName'];
    contactPersonDesignation = json['ContactPersonDesignation'];
    contactPersonPhone = json['ContactPersonPhone'];
    contactPersonMail = json['ContactPersonMail'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    countryId = json['CountryId'];
    countryName = json['CountryName'];
    postalCode = json['PostalCode'];
    landMark = json['LandMark'];
    phone = json['Phone'];
    mobile = json['Mobile'];
    fax = json['Fax'];
    mail = json['Mail'];
    website = json['Website'];
    facebook = json['Facebook'];
    linkedIn = json['LinkedIn'];
    url = json['Url'];
    logo = json['Logo'];
    isTax = json['IsTax'];
    taxCode = json['TaxCode'];
    orgRefCode = json['OrgRefCode'];
    businessRegNo = json['BusinessRegNo'];
    taxRegNo = json['TaxRegNo'];
    isFunctional = json['IsFunctional'];
    employeeSize = json['EmployeeSize'];
    payNowQR = json['PayNowQR'];
    expiredOn = json['ExpiredOn'];
    displayOrder = json['DisplayOrder'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    taxPerc = json['TaxPerc'];
    currencyId = json['CurrencyId'];
    isB2B = json['IsB2B'];
    isB2C = json['IsB2C'];
    isERP = json['IsERP'];
    isPos = json['IsPos'];
    image = json['Image'];
    imageString = json['ImageString'];
    qRImage = json['QRImage'];
    qRImageString = json['QRImageString'];
    qRUENNo = json['QRUENNo'];
    qRMobileNo = json['QRMobileNo'];
    orgLogoString = json['OrgLogoString'];
  }

  int? orgId;
  String? uniqueNo;
  String? name;
  String? activity1;
  String? activity2;
  String? directorName;
  String? contactPersonName;
  String? contactPersonDesignation;
  String? contactPersonPhone;
  String? contactPersonMail;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? countryId;
  String? countryName;
  String? postalCode;
  dynamic landMark;
  String? phone;
  String? mobile;
  String? fax;
  String? mail;
  String? website;
  dynamic facebook;
  dynamic linkedIn;
  dynamic url;
  dynamic logo;
  bool? isTax;
  int? taxCode;
  String? orgRefCode;
  String? businessRegNo;
  String? taxRegNo;
  bool? isFunctional;
  int? employeeSize;
  dynamic payNowQR;
  dynamic expiredOn;
  dynamic displayOrder;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  dynamic changedBy;
  String? changedOn;
  double? taxPerc;
  String? currencyId;
  bool? isB2B;
  bool? isB2C;
  bool? isERP;
  bool? isPos;
  dynamic image;
  dynamic imageString;
  dynamic qRImage;
  dynamic qRImageString;
  dynamic qRUENNo;
  dynamic qRMobileNo;
  dynamic orgLogoString;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['UniqueNo'] = uniqueNo;
    map['Name'] = name;
    map['Activity1'] = activity1;
    map['Activity2'] = activity2;
    map['DirectorName'] = directorName;
    map['ContactPersonName'] = contactPersonName;
    map['ContactPersonDesignation'] = contactPersonDesignation;
    map['ContactPersonPhone'] = contactPersonPhone;
    map['ContactPersonMail'] = contactPersonMail;
    map['AddressLine1'] = addressLine1;
    map['AddressLine2'] = addressLine2;
    map['AddressLine3'] = addressLine3;
    map['CountryId'] = countryId;
    map['CountryName'] = countryName;
    map['PostalCode'] = postalCode;
    map['LandMark'] = landMark;
    map['Phone'] = phone;
    map['Mobile'] = mobile;
    map['Fax'] = fax;
    map['Mail'] = mail;
    map['Website'] = website;
    map['Facebook'] = facebook;
    map['LinkedIn'] = linkedIn;
    map['Url'] = url;
    map['Logo'] = logo;
    map['IsTax'] = isTax;
    map['TaxCode'] = taxCode;
    map['OrgRefCode'] = orgRefCode;
    map['BusinessRegNo'] = businessRegNo;
    map['TaxRegNo'] = taxRegNo;
    map['IsFunctional'] = isFunctional;
    map['EmployeeSize'] = employeeSize;
    map['PayNowQR'] = payNowQR;
    map['ExpiredOn'] = expiredOn;
    map['DisplayOrder'] = displayOrder;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['TaxPerc'] = taxPerc;
    map['CurrencyId'] = currencyId;
    map['IsB2B'] = isB2B;
    map['IsB2C'] = isB2C;
    map['IsERP'] = isERP;
    map['IsPos'] = isPos;
    map['Image'] = image;
    map['ImageString'] = imageString;
    map['QRImage'] = qRImage;
    map['QRImageString'] = qRImageString;
    map['QRUENNo'] = qRUENNo;
    map['QRMobileNo'] = qRMobileNo;
    map['OrgLogoString'] = orgLogoString;
    return map;
  }

  @override
  String toString() {
    return "$name";
  }
}

// class GetAllOrganization {
//   GetAllOrganization({
//     this.orgId,
//     this.orgName,
//     this.regNo,
//     this.taxRegNo,
//     this.orgRefCode,
//     this.addressLine1,
//     this.addressLine2,
//     this.addressLine3,
//     this.country,
//     this.postalCode,
//     this.phoneNo,
//     this.mobileNo,
//     this.fax,
//     this.email,
//     this.website,
//     this.orgLogo,
//     this.taxCode,
//     this.taxType,
//     this.taxPerc,
//     this.currency,
//     this.contactPerson,
//     this.contactNo,
//     this.isActive,
//     this.createdBy,
//     this.createdOn,
//     this.changedBy,
//     this.changedOn,
//     this.orgLogoString,
//   });
//
//   GetAllOrganization.fromJson(dynamic json) {
//     orgId = json['OrgId'];
//     orgName = json['OrgName'];
//     regNo = json['RegNo'];
//     taxRegNo = json['TaxRegNo'];
//     orgRefCode = json['OrgRefCode'];
//     addressLine1 = json['AddressLine1'];
//     addressLine2 = json['AddressLine2'];
//     addressLine3 = json['AddressLine3'];
//     country = json['Country'];
//     postalCode = json['PostalCode'];
//     phoneNo = json['PhoneNo'];
//     mobileNo = json['MobileNo'];
//     fax = json['Fax'];
//     email = json['Email'];
//     website = json['Website'];
//     orgLogo = json['OrgLogo'];
//     taxCode = json['TaxCode'];
//     taxType = json['TaxType'];
//     taxPerc = json['TaxPerc'];
//     currency = json['Currency'];
//     contactPerson = json['ContactPerson'];
//     contactNo = json['ContactNo'];
//     isActive = json['IsActive'];
//     createdBy = json['CreatedBy'];
//     createdOn = json['CreatedOn'];
//     changedBy = json['ChangedBy'];
//     changedOn = json['ChangedOn'];
//     orgLogoString = json['OrgLogoString'];
//   }
//   int? orgId;
//   String? orgName;
//   String? regNo;
//   String? taxRegNo;
//   String? orgRefCode;
//   String? addressLine1;
//   String? addressLine2;
//   String? addressLine3;
//   String? country;
//   String? postalCode;
//   String? phoneNo;
//   String? mobileNo;
//   String? fax;
//   String? email;
//   String? website;
//   String? orgLogo;
//   int? taxCode;
//   String? taxType;
//   double? taxPerc;
//   String? currency;
//   String? contactPerson;
//   String? contactNo;
//   bool? isActive;
//   String? createdBy;
//   String? createdOn;
//   String? changedBy;
//   String? changedOn;
//   String? orgLogoString;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['OrgId'] = orgId;
//     map['OrgName'] = orgName;
//     map['RegNo'] = regNo;
//     map['TaxRegNo'] = taxRegNo;
//     map['OrgRefCode'] = orgRefCode;
//     map['AddressLine1'] = addressLine1;
//     map['AddressLine2'] = addressLine2;
//     map['AddressLine3'] = addressLine3;
//     map['Country'] = country;
//     map['PostalCode'] = postalCode;
//     map['PhoneNo'] = phoneNo;
//     map['MobileNo'] = mobileNo;
//     map['Fax'] = fax;
//     map['Email'] = email;
//     map['Website'] = website;
//     map['OrgLogo'] = orgLogo;
//     map['TaxCode'] = taxCode;
//     map['TaxType'] = taxType;
//     map['TaxPerc'] = taxPerc;
//     map['Currency'] = currency;
//     map['ContactPerson'] = contactPerson;
//     map['ContactNo'] = contactNo;
//     map['IsActive'] = isActive;
//     map['CreatedBy'] = createdBy;
//     map['CreatedOn'] = createdOn;
//     map['ChangedBy'] = changedBy;
//     map['ChangedOn'] = changedOn;
//     map['OrgLogoString'] = orgLogoString;
//     return map;
//   }
//
//   @override
//   String toString() {
//     return "$orgName";
//   }
// }
