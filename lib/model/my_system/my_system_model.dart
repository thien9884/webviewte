class MySystemModel {
  int? level;
  List<MySystemDetails>? details;
  int? totalRecords;
  bool expandLevel = false;

  MySystemModel({this.level, this.details, this.totalRecords, this.expandLevel = false});

  MySystemModel.fromJson(Map<String, dynamic> json) {
    level = json['Level'];
    if (json['Details'] != null) {
      details = <MySystemDetails>[];
      json['Details'].forEach((v) {
        details!.add(MySystemDetails.fromJson(v));
      });
    }
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Level'] = level;
    if (details != null) {
      data['Details'] = details!.map((v) => v.toJson()).toList();
    }
    data['TotalRecords'] = totalRecords;
    return data;
  }
}

class MySystemDetails {
  String? email;
  String? phone;
  String? fullName;

  MySystemDetails({this.email, this.phone, this.fullName});

  MySystemDetails.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    phone = json['Phone'];
    fullName = json['FullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Email'] = email;
    data['Phone'] = phone;
    data['FullName'] = fullName;
    return data;
  }
}
