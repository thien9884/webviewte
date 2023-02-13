class UserModel {
  String? accessToken;
  String? tokenType;
  String? createdAtUtc;
  String? expiresAtUtc;
  String? username;
  int? customerId;
  String? customerGuid;

  UserModel(
      {this.accessToken,
      this.tokenType,
      this.createdAtUtc,
      this.expiresAtUtc,
      this.username,
      this.customerId,
      this.customerGuid});

  UserModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    createdAtUtc = json['created_at_utc'];
    expiresAtUtc = json['expires_at_utc'];
    username = json['username'];
    customerId = json['customer_id'];
    customerGuid = json['customer_guid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['created_at_utc'] = createdAtUtc;
    data['expires_at_utc'] = expiresAtUtc;
    data['username'] = username;
    data['customer_id'] = customerId;
    data['customer_guid'] = customerGuid;
    return data;
  }
}
