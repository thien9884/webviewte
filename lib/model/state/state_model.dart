class StateModel {
  bool? disabled;
  dynamic group;
  bool? selected;
  String? text;
  String? value;

  StateModel({this.disabled, this.group, this.selected, this.text, this.value});

  StateModel.fromJson(Map<String, dynamic> json) {
    disabled = json['Disabled'];
    group = json['Group'];
    selected = json['Selected'];
    text = json['Text'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Disabled'] = disabled;
    data['Group'] = group;
    data['Selected'] = selected;
    data['Text'] = text;
    data['Value'] = value;
    return data;
  }
}
