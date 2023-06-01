class CouponModel {
  String? coupon;
  int? usedTime;
  int? limitedUse;
  bool? active;
  int? value;
  bool? valueType;
  int? totalMoneyOfBillFrom;
  int? totalMoneyOfBillTo;
  String? fetchStatus;
  int? id;

  CouponModel(
      {this.coupon,
      this.usedTime,
      this.limitedUse,
      this.active,
      this.value,
      this.valueType,
      this.totalMoneyOfBillFrom,
      this.totalMoneyOfBillTo,
      this.fetchStatus,
      this.id});

  CouponModel.fromJson(Map<String, dynamic> json) {
    coupon = json['Coupon'];
    usedTime = json['UsedTime'];
    limitedUse = json['LimitedUse'];
    active = json['Active'];
    value = json['Value'];
    valueType = json['ValueType'];
    totalMoneyOfBillFrom = json['TotalMoneyOfBillFrom'];
    totalMoneyOfBillTo = json['TotalMoneyOfBillTo'];
    fetchStatus = json['FetchStatus'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Coupon'] = coupon;
    data['UsedTime'] = usedTime;
    data['LimitedUse'] = limitedUse;
    data['Active'] = active;
    data['Value'] = value;
    data['ValueType'] = valueType;
    data['TotalMoneyOfBillFrom'] = totalMoneyOfBillFrom;
    data['TotalMoneyOfBillTo'] = totalMoneyOfBillTo;
    data['FetchStatus'] = fetchStatus;
    data['Id'] = id;
    return data;
  }
}
