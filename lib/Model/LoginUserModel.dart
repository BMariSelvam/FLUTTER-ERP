import 'dart:convert';

/// OrganisationName : "string"
/// OrgId : 0
/// Username : "string"
/// UserRolecode : "string"
/// UniqueNo : "string"
/// Name : "string"
/// Password : "string"
/// Mail : "string"
/// AddressLine1 : "string"
/// AddressLine2 : "string"
/// AddressLine3 : "string"
/// Country : "string"
/// CountryName : "string"
/// PostalCode : "string"
/// Mobile : "string"
/// Phone : "string"
/// Fax : "string"
/// Facebook : "string"
/// LinkedIn : "string"
/// IsActive : true
/// CreatedBy : "string"
/// CreatedOn : "2023-09-27T11:17:05.264Z"
/// ChangedBy : "string"
/// ChangedOn : "2023-09-27T11:17:05.264Z"
/// ItemImage : "string"
/// ItemImageString : "string"
/// BranchCode : "string"
/// Location : "string"
/// CompanyImageString : "string"

LoginUserModel loginUserModelFromJson(String str) =>
    LoginUserModel.fromJson(json.decode(str));
String loginUserModelToJson(LoginUserModel data) => json.encode(data.toJson());

class LoginUserModel {
  LoginUserModel({
    String? organisationName,
    int? orgId,
    String? username,
    String? userRolecode,
    String? uniqueNo,
    String? name,
    String? password,
    String? mail,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? country,
    String? countryName,
    String? postalCode,
    String? mobile,
    String? phone,
    String? fax,
    String? facebook,
    String? linkedIn,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    String? itemImage,
    String? itemImageString,
    String? branchCode,
    String? location,
    String? companyImageString,
  }) {
    _organisationName = organisationName;
    _orgId = orgId;
    _username = username;
    _userRolecode = userRolecode;
    _uniqueNo = uniqueNo;
    _name = name;
    _password = password;
    _mail = mail;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _addressLine3 = addressLine3;
    _country = country;
    _countryName = countryName;
    _postalCode = postalCode;
    _mobile = mobile;
    _phone = phone;
    _fax = fax;
    _facebook = facebook;
    _linkedIn = linkedIn;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
    _itemImage = itemImage;
    _itemImageString = itemImageString;
    _branchCode = branchCode;
    _location = location;
    _companyImageString = companyImageString;
  }

  LoginUserModel.fromJson(dynamic json) {
    _organisationName = json['OrganisationName'];
    _orgId = json['OrgId'];
    _username = json['Username'];
    _userRolecode = json['UserRolecode'];
    _uniqueNo = json['UniqueNo'];
    _name = json['Name'];
    _password = json['Password'];
    _mail = json['Mail'];
    _addressLine1 = json['AddressLine1'];
    _addressLine2 = json['AddressLine2'];
    _addressLine3 = json['AddressLine3'];
    _country = json['Country'];
    _countryName = json['CountryName'];
    _postalCode = json['PostalCode'];
    _mobile = json['Mobile'];
    _phone = json['Phone'];
    _fax = json['Fax'];
    _facebook = json['Facebook'];
    _linkedIn = json['LinkedIn'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
    _itemImage = json['ItemImage'];
    _itemImageString = json['ItemImageString'];
    _branchCode = json['BranchCode'];
    _location = json['Location'];
    _companyImageString = json['CompanyImageString'];
  }
  String? _organisationName;
  int? _orgId;
  String? _username;
  String? _userRolecode;
  String? _uniqueNo;
  String? _name;
  String? _password;
  String? _mail;
  String? _addressLine1;
  String? _addressLine2;
  String? _addressLine3;
  String? _country;
  String? _countryName;
  String? _postalCode;
  String? _mobile;
  String? _phone;
  String? _fax;
  String? _facebook;
  String? _linkedIn;
  bool? _isActive;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;
  String? _itemImage;
  String? _itemImageString;
  String? _branchCode;
  String? _location;
  String? _companyImageString;
  LoginUserModel copyWith({
    String? organisationName,
    int? orgId,
    String? username,
    String? userRolecode,
    String? uniqueNo,
    String? name,
    String? password,
    String? mail,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? country,
    String? countryName,
    String? postalCode,
    String? mobile,
    String? phone,
    String? fax,
    String? facebook,
    String? linkedIn,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    String? itemImage,
    String? itemImageString,
    String? branchCode,
    String? location,
    String? companyImageString,
  }) =>
      LoginUserModel(
        organisationName: organisationName ?? _organisationName,
        orgId: orgId ?? _orgId,
        username: username ?? _username,
        userRolecode: userRolecode ?? _userRolecode,
        uniqueNo: uniqueNo ?? _uniqueNo,
        name: name ?? _name,
        password: password ?? _password,
        mail: mail ?? _mail,
        addressLine1: addressLine1 ?? _addressLine1,
        addressLine2: addressLine2 ?? _addressLine2,
        addressLine3: addressLine3 ?? _addressLine3,
        country: country ?? _country,
        countryName: countryName ?? _countryName,
        postalCode: postalCode ?? _postalCode,
        mobile: mobile ?? _mobile,
        phone: phone ?? _phone,
        fax: fax ?? _fax,
        facebook: facebook ?? _facebook,
        linkedIn: linkedIn ?? _linkedIn,
        isActive: isActive ?? _isActive,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
        itemImage: itemImage ?? _itemImage,
        itemImageString: itemImageString ?? _itemImageString,
        branchCode: branchCode ?? _branchCode,
        location: location ?? _location,
        companyImageString: companyImageString ?? _companyImageString,
      );
  String? get organisationName => _organisationName;
  int? get orgId => _orgId;
  String? get username => _username;
  String? get userRolecode => _userRolecode;
  String? get uniqueNo => _uniqueNo;
  String? get name => _name;
  String? get password => _password;
  String? get mail => _mail;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get addressLine3 => _addressLine3;
  String? get country => _country;
  String? get countryName => _countryName;
  String? get postalCode => _postalCode;
  String? get mobile => _mobile;
  String? get phone => _phone;
  String? get fax => _fax;
  String? get facebook => _facebook;
  String? get linkedIn => _linkedIn;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get changedBy => _changedBy;
  String? get changedOn => _changedOn;
  String? get itemImage => _itemImage;
  String? get itemImageString => _itemImageString;
  String? get branchCode => _branchCode;
  String? get location => _location;
  String? get companyImageString => _companyImageString;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrganisationName'] = _organisationName;
    map['OrgId'] = _orgId;
    map['Username'] = _username;
    map['UserRolecode'] = _userRolecode;
    map['UniqueNo'] = _uniqueNo;
    map['Name'] = _name;
    map['Password'] = _password;
    map['Mail'] = _mail;
    map['AddressLine1'] = _addressLine1;
    map['AddressLine2'] = _addressLine2;
    map['AddressLine3'] = _addressLine3;
    map['Country'] = _country;
    map['CountryName'] = _countryName;
    map['PostalCode'] = _postalCode;
    map['Mobile'] = _mobile;
    map['Phone'] = _phone;
    map['Fax'] = _fax;
    map['Facebook'] = _facebook;
    map['LinkedIn'] = _linkedIn;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    map['ItemImage'] = _itemImage;
    map['ItemImageString'] = _itemImageString;
    map['BranchCode'] = _branchCode;
    map['Location'] = _location;
    map['CompanyImageString'] = _companyImageString;
    return map;
  }
}
