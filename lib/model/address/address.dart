class AddAddressModel {
  String? firstName;
  String? lastName;
  String? email;
  String? company;
  int? countryId;
  dynamic country;
  dynamic stateProvinceId;
  String? city;
  String? address1;
  String? address2;
  String? zipPostalCode;
  String? phoneNumber;
  String? faxNumber;
  String? customerAttributes;
  String? createdOnUtc;
  dynamic province;
  int? id;

  AddAddressModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.company,
      this.countryId,
      this.country,
      this.stateProvinceId,
      this.city,
      this.address1,
      this.address2,
      this.zipPostalCode,
      this.phoneNumber,
      this.faxNumber,
      this.customerAttributes,
      this.createdOnUtc,
      this.province,
      this.id});

  AddAddressModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    company = json['company'];
    countryId = json['country_id'];
    country = json['country'];
    stateProvinceId = json['state_province_id'];
    city = json['city'];
    address1 = json['address1'];
    address2 = json['address2'];
    zipPostalCode = json['zip_postal_code'];
    phoneNumber = json['phone_number'];
    faxNumber = json['fax_number'];
    customerAttributes = json['customer_attributes'];
    createdOnUtc = json['created_on_utc'];
    province = json['province'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['company'] = company;
    data['country_id'] = countryId;
    data['country'] = country;
    data['state_province_id'] = stateProvinceId;
    data['city'] = city;
    data['address1'] = address1;
    data['address2'] = address2;
    data['zip_postal_code'] = zipPostalCode;
    data['phone_number'] = phoneNumber;
    data['fax_number'] = faxNumber;
    data['customer_attributes'] = customerAttributes;
    data['created_on_utc'] = createdOnUtc;
    data['province'] = province;
    data['id'] = id;
    return data;
  }
}
