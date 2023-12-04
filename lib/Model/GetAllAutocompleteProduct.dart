class GetAllAutocompleteProduct {
  GetAllAutocompleteProduct({
    this.orgId,
    this.code,
    this.name,
  });

  GetAllAutocompleteProduct.fromJson(dynamic json) {
    orgId = json['OrgId'];
    code = json['Code'];
    name = json['Name'];
  }
  int? orgId;
  String? code;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['Code'] = code;
    map['Name'] = name;
    return map;
  }

  @override
  String toString() {
    return "$name";
  }
}
