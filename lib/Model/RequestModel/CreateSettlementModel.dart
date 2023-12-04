import 'SettlementDetail.dart';
import 'SettlementExpenseDetail.dart';

class CreateSettlementModel {
  CreateSettlementModel({
      this.orgId, 
      this.branchCode, 
      this.settlementNo, 
      this.settlementDate, 
      this.totalCashAmount, 
      this.settlementBy, 
      this.createdBy, 
      this.createdOn, 
      this.changedBy, 
      this.changedOn, 
      this.isActive, 
      this.settlementDatestring, 
      this.settlementDetail, 
      this.settlementExpenseDetail,});

  CreateSettlementModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    branchCode = json['BranchCode'];
    settlementNo = json['SettlementNo'];
    settlementDate = json['SettlementDate'];
    totalCashAmount = json['TotalCashAmount'];
    settlementBy = json['SettlementBy'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    isActive = json['IsActive'];
    settlementDatestring = json['SettlementDatestring'];
    if (json['SettlementDetail'] != null) {
      settlementDetail = [];
      json['SettlementDetail'].forEach((v) {
        settlementDetail?.add(SettlementDetail.fromJson(v));
      });
    }
    if (json['SettlementExpenseDetail'] != null) {
      settlementExpenseDetail = [];
      json['SettlementExpenseDetail'].forEach((v) {
        settlementExpenseDetail?.add(SettlementExpenseDetail.fromJson(v));
      });
    }
  }
  int? orgId;
  String? branchCode;
  String? settlementNo;
  String? settlementDate;
  int? totalCashAmount;
  String? settlementBy;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  bool? isActive;
  String? settlementDatestring;
  List<SettlementDetail>? settlementDetail;
  List<SettlementExpenseDetail>? settlementExpenseDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['BranchCode'] = branchCode;
    map['SettlementNo'] = settlementNo;
    map['SettlementDate'] = settlementDate;
    map['TotalCashAmount'] = totalCashAmount;
    map['SettlementBy'] = settlementBy;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['IsActive'] = isActive;
    map['SettlementDatestring'] = settlementDatestring;
    if (settlementDetail != null) {
      map['SettlementDetail'] = settlementDetail?.map((v) => v.toJson()).toList();
    }
    if (settlementExpenseDetail != null) {
      map['SettlementExpenseDetail'] = settlementExpenseDetail?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}