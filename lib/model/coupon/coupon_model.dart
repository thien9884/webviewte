class TotalCoupon {
  List<CouponModel>? coupons;
  int? totalCoupons;

  TotalCoupon({this.coupons, this.totalCoupons});

  TotalCoupon.fromJson(Map<String, dynamic> json) {
    if (json['Coupons'] != null) {
      coupons = <CouponModel>[];
      json['Coupons'].forEach((v) {
        coupons!.add(CouponModel.fromJson(v));
      });
    }
    totalCoupons = json['TotalCoupons'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coupons != null) {
      data['Coupons'] = coupons!.map((v) => v.toJson()).toList();
    }
    data['TotalCoupons'] = totalCoupons;
    return data;
  }
}

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
  bool showCoupon = false;

  CouponModel({
    this.coupon,
    this.usedTime,
    this.limitedUse,
    this.active,
    this.value,
    this.valueType,
    this.totalMoneyOfBillFrom,
    this.totalMoneyOfBillTo,
    this.fetchStatus,
    this.id,
    this.showCoupon = false,
  });

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
