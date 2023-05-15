class PutAddress {
  String? firstName;
  String? lastName;
  String? email;
  String? company;
  int? countryId;
  int? stateProvinceId;
  String? county;
  String? city;
  String? address1;
  String? address2;
  String? zipPostalCode;
  String? phoneNumber;
  String? faxNumber;
  String? customAttributes;
  String? createdOnUtc;
  int? countyId;
  int? id;

  PutAddress(
      {this.firstName,
        this.lastName,
        this.email,
        this.company,
        this.countryId,
        this.stateProvinceId,
        this.county,
        this.city,
        this.address1,
        this.address2,
        this.zipPostalCode,
        this.phoneNumber,
        this.faxNumber,
        this.customAttributes,
        this.createdOnUtc,
        this.countyId,
        this.id});

  PutAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    company = json['Company'];
    countryId = json['CountryId'];
    stateProvinceId = json['StateProvinceId'];
    county = json['County'];
    city = json['City'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    zipPostalCode = json['ZipPostalCode'];
    phoneNumber = json['PhoneNumber'];
    faxNumber = json['FaxNumber'];
    customAttributes = json['CustomAttributes'];
    createdOnUtc = json['CreatedOnUtc'];
    countyId = json['CountyId'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Email'] = email;
    data['Company'] = company;
    data['CountryId'] = countryId;
    data['StateProvinceId'] = stateProvinceId;
    data['County'] = county;
    data['City'] = city;
    data['Address1'] = address1;
    data['Address2'] = address2;
    data['ZipPostalCode'] = zipPostalCode;
    data['PhoneNumber'] = phoneNumber;
    data['FaxNumber'] = faxNumber;
    data['CustomAttributes'] = customAttributes;
    data['CreatedOnUtc'] = createdOnUtc;
    data['CountyId'] = countyId;
    data['Id'] = id;
    return data;
  }
}
