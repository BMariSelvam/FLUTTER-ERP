class GetAllBranchModel {
  GetAllBranchModel({
    this.orgId,
    this.code,
    this.name,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.countryId,
    this.countryName,
    this.postalCode,
    this.mobile,
    this.phone,
    this.fax,
    this.mail,
    this.displayOrder,
    this.isActive,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.haveStock,
    this.isDefault,
  });

  GetAllBranchModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    code = json['Code'];
    name = json['Name'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    countryId = json['CountryId'];
    countryName = json['CountryName'];
    postalCode = json['PostalCode'];
    mobile = json['Mobile'];
    phone = json['Phone'];
    fax = json['Fax'];
    mail = json['Mail'];
    displayOrder = json['DisplayOrder'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    haveStock = json['HaveStock'];
    isDefault = json['IsDefault'];
  }

  int? orgId;
  String? code;
  String? name;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? countryId;
  dynamic countryName;
  String? postalCode;
  String? mobile;
  String? phone;
  String? fax;
  String? mail;
  int? displayOrder;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  bool? haveStock;
  bool? isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['Code'] = code;
    map['Name'] = name;
    map['AddressLine1'] = addressLine1;
    map['AddressLine2'] = addressLine2;
    map['AddressLine3'] = addressLine3;
    map['CountryId'] = countryId;
    map['CountryName'] = countryName;
    map['PostalCode'] = postalCode;
    map['Mobile'] = mobile;
    map['Phone'] = phone;
    map['Fax'] = fax;
    map['Mail'] = mail;
    map['DisplayOrder'] = displayOrder;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['HaveStock'] = haveStock;
    map['IsDefault'] = isDefault;
    return map;
  }

  @override
  String toString() {
    return "$name";
  }
}

// class GetAllBranchModel {
//   GetAllBranchModel({
//     this.orgId,
//     this.branchCode,
//     this.branchName,
//     this.addressLine1,
//     this.addressLine2,
//     this.addressLine3,
//     this.country,
//     this.postalCode,
//     this.phoneNo,
//     this.mobileNo,
//     this.fax,
//     this.email,
//     this.contactPerson,
//     this.contactNo,
//     this.isActive,
//     this.isMainBranch,
//     this.haveStock,
//     this.createdBy,
//     this.createdOn,
//     this.changedBy,
//     this.changedOn,
//   });
//
//   GetAllBranchModel.fromJson(dynamic json) {
//     orgId = json['OrgId'];
//     branchCode = json['BranchCode'];
//     branchName = json['BranchName'];
//     addressLine1 = json['AddressLine1'];
//     addressLine2 = json['AddressLine2'];
//     addressLine3 = json['AddressLine3'];
//     country = json['Country'];
//     postalCode = json['PostalCode'];
//     phoneNo = json['PhoneNo'];
//     mobileNo = json['MobileNo'];
//     fax = json['Fax'];
//     email = json['Email'];
//     contactPerson = json['ContactPerson'];
//     contactNo = json['ContactNo'];
//     isActive = json['IsActive'];
//     isMainBranch = json['IsMainBranch'];
//     haveStock = json['HaveStock'];
//     createdBy = json['CreatedBy'];
//     createdOn = json['CreatedOn'];
//     changedBy = json['ChangedBy'];
//     changedOn = json['ChangedOn'];
//   }
//   int? orgId;
//   String? branchCode;
//   String? branchName;
//   String? addressLine1;
//   String? addressLine2;
//   String? addressLine3;
//   String? country;
//   String? postalCode;
//   String? phoneNo;
//   String? mobileNo;
//   String? fax;
//   String? email;
//   String? contactPerson;
//   String? contactNo;
//   bool? isActive;
//   bool? isMainBranch;
//   bool? haveStock;
//   String? createdBy;
//   String? createdOn;
//   String? changedBy;
//   String? changedOn;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['OrgId'] = orgId;
//     map['BranchCode'] = branchCode;
//     map['BranchName'] = branchName;
//     map['AddressLine1'] = addressLine1;
//     map['AddressLine2'] = addressLine2;
//     map['AddressLine3'] = addressLine3;
//     map['Country'] = country;
//     map['PostalCode'] = postalCode;
//     map['PhoneNo'] = phoneNo;
//     map['MobileNo'] = mobileNo;
//     map['Fax'] = fax;
//     map['Email'] = email;
//     map['ContactPerson'] = contactPerson;
//     map['ContactNo'] = contactNo;
//     map['IsActive'] = isActive;
//     map['IsMainBranch'] = isMainBranch;
//     map['HaveStock'] = haveStock;
//     map['CreatedBy'] = createdBy;
//     map['CreatedOn'] = createdOn;
//     map['ChangedBy'] = changedBy;
//     map['ChangedOn'] = changedOn;
//     return map;
//   }
//
//   @override
//   String toString() {
//     return "$branchName";
//   }
// }
