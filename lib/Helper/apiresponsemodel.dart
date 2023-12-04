class ApiResponseModel {
  int? code;
  bool status = false;
  String? message;
  dynamic data;
  dynamic result;
  int? totalNumberOfPages;
  int? totalNumberOfRecords;

  ApiResponseModel(
      {required this.code,
      required this.status,
      required this.message,
      required this.data,
      required this.result,
      this.totalNumberOfPages,
      this.totalNumberOfRecords});

  ApiResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    status = json['Status'];
    message = json['Message'];
    data = json['Data'];
    result = json['Result'];
    totalNumberOfPages = json['TotalNumberOfPages'];
    totalNumberOfRecords = json['TotalNumberOfRecords'];
  }
}
