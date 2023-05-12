class InfoModel {
  String? email;
  dynamic emailToRevalidate;
  bool? checkUsernameAvailabilityEnabled;
  bool? allowUsersToChangeUsernames;
  bool? usernamesEnabled;
  String? username;
  bool? genderEnabled;
  String? gender;
  bool? firstNameEnabled;
  String? firstName;
  bool? firstNameRequired;
  bool? lastNameEnabled;
  dynamic lastName;
  bool? lastNameRequired;
  bool? dateOfBirthEnabled;
  int? dateOfBirthDay;
  int? dateOfBirthMonth;
  int? dateOfBirthYear;
  bool? dateOfBirthRequired;
  bool? companyEnabled;
  bool? companyRequired;
  dynamic company;
  bool? streetAddressEnabled;
  bool? streetAddressRequired;
  dynamic streetAddress;
  bool? streetAddress2Enabled;
  bool? streetAddress2Required;
  dynamic streetAddress2;
  bool? zipPostalCodeEnabled;
  bool? zipPostalCodeRequired;
  dynamic zipPostalCode;
  bool? cityEnabled;
  bool? cityRequired;
  dynamic city;
  bool? countyEnabled;
  bool? countyRequired;
  dynamic county;
  bool? countryEnabled;
  bool? countryRequired;
  int? countryId;
  dynamic availableCountries;
  bool? stateProvinceEnabled;
  bool? stateProvinceRequired;
  int? stateProvinceId;
  dynamic availableStates;
  bool? phoneEnabled;
  bool? phoneRequired;
  String? phone;
  bool? faxEnabled;
  bool? faxRequired;
  dynamic fax;
  bool? newsletterEnabled;
  bool? newsletter;
  bool? signatureEnabled;
  dynamic signature;
  dynamic timeZoneId;
  bool? allowCustomersToSetTimeZone;
  dynamic availableTimeZones;
  dynamic vatNumber;
  String? vatNumberStatusNote;
  bool? displayVatNumber;
  dynamic associatedExternalAuthRecords;
  int? numberOfExternalAuthenticationProviders;
  bool? allowCustomersToRemoveAssociations;
  dynamic customerAttributes;
  dynamic gdprConsents;
  String? referralCode;

  InfoModel(
      {this.email,
        this.emailToRevalidate,
        this.checkUsernameAvailabilityEnabled,
        this.allowUsersToChangeUsernames,
        this.usernamesEnabled,
        this.username,
        this.genderEnabled,
        this.gender,
        this.firstNameEnabled,
        this.firstName,
        this.firstNameRequired,
        this.lastNameEnabled,
        this.lastName,
        this.lastNameRequired,
        this.dateOfBirthEnabled,
        this.dateOfBirthDay,
        this.dateOfBirthMonth,
        this.dateOfBirthYear,
        this.dateOfBirthRequired,
        this.companyEnabled,
        this.companyRequired,
        this.company,
        this.streetAddressEnabled,
        this.streetAddressRequired,
        this.streetAddress,
        this.streetAddress2Enabled,
        this.streetAddress2Required,
        this.streetAddress2,
        this.zipPostalCodeEnabled,
        this.zipPostalCodeRequired,
        this.zipPostalCode,
        this.cityEnabled,
        this.cityRequired,
        this.city,
        this.countyEnabled,
        this.countyRequired,
        this.county,
        this.countryEnabled,
        this.countryRequired,
        this.countryId,
        this.availableCountries,
        this.stateProvinceEnabled,
        this.stateProvinceRequired,
        this.stateProvinceId,
        this.availableStates,
        this.phoneEnabled,
        this.phoneRequired,
        this.phone,
        this.faxEnabled,
        this.faxRequired,
        this.fax,
        this.newsletterEnabled,
        this.newsletter,
        this.signatureEnabled,
        this.signature,
        this.timeZoneId,
        this.allowCustomersToSetTimeZone,
        this.availableTimeZones,
        this.vatNumber,
        this.vatNumberStatusNote,
        this.displayVatNumber,
        this.associatedExternalAuthRecords,
        this.numberOfExternalAuthenticationProviders,
        this.allowCustomersToRemoveAssociations,
        this.customerAttributes,
        this.gdprConsents,
        this.referralCode});

  InfoModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    emailToRevalidate = json['EmailToRevalidate'];
    checkUsernameAvailabilityEnabled = json['CheckUsernameAvailabilityEnabled'];
    allowUsersToChangeUsernames = json['AllowUsersToChangeUsernames'];
    usernamesEnabled = json['UsernamesEnabled'];
    username = json['Username'];
    genderEnabled = json['GenderEnabled'];
    gender = json['Gender'];
    firstNameEnabled = json['FirstNameEnabled'];
    firstName = json['FirstName'];
    firstNameRequired = json['FirstNameRequired'];
    lastNameEnabled = json['LastNameEnabled'];
    lastName = json['LastName'];
    lastNameRequired = json['LastNameRequired'];
    dateOfBirthEnabled = json['DateOfBirthEnabled'];
    dateOfBirthDay = json['DateOfBirthDay'];
    dateOfBirthMonth = json['DateOfBirthMonth'];
    dateOfBirthYear = json['DateOfBirthYear'];
    dateOfBirthRequired = json['DateOfBirthRequired'];
    companyEnabled = json['CompanyEnabled'];
    companyRequired = json['CompanyRequired'];
    company = json['Company'];
    streetAddressEnabled = json['StreetAddressEnabled'];
    streetAddressRequired = json['StreetAddressRequired'];
    streetAddress = json['StreetAddress'];
    streetAddress2Enabled = json['StreetAddress2Enabled'];
    streetAddress2Required = json['StreetAddress2Required'];
    streetAddress2 = json['StreetAddress2'];
    zipPostalCodeEnabled = json['ZipPostalCodeEnabled'];
    zipPostalCodeRequired = json['ZipPostalCodeRequired'];
    zipPostalCode = json['ZipPostalCode'];
    cityEnabled = json['CityEnabled'];
    cityRequired = json['CityRequired'];
    city = json['City'];
    countyEnabled = json['CountyEnabled'];
    countyRequired = json['CountyRequired'];
    county = json['County'];
    countryEnabled = json['CountryEnabled'];
    countryRequired = json['CountryRequired'];
    countryId = json['CountryId'];
    availableCountries = json['AvailableCountries'];
    stateProvinceEnabled = json['StateProvinceEnabled'];
    stateProvinceRequired = json['StateProvinceRequired'];
    stateProvinceId = json['StateProvinceId'];
    availableStates = json['AvailableStates'];
    phoneEnabled = json['PhoneEnabled'];
    phoneRequired = json['PhoneRequired'];
    phone = json['Phone'];
    faxEnabled = json['FaxEnabled'];
    faxRequired = json['FaxRequired'];
    fax = json['Fax'];
    newsletterEnabled = json['NewsletterEnabled'];
    newsletter = json['Newsletter'];
    signatureEnabled = json['SignatureEnabled'];
    signature = json['Signature'];
    timeZoneId = json['TimeZoneId'];
    allowCustomersToSetTimeZone = json['AllowCustomersToSetTimeZone'];
    availableTimeZones = json['AvailableTimeZones'];
    vatNumber = json['VatNumber'];
    vatNumberStatusNote = json['VatNumberStatusNote'];
    displayVatNumber = json['DisplayVatNumber'];
    associatedExternalAuthRecords = json['AssociatedExternalAuthRecords'];
    numberOfExternalAuthenticationProviders =
    json['NumberOfExternalAuthenticationProviders'];
    allowCustomersToRemoveAssociations =
    json['AllowCustomersToRemoveAssociations'];
    customerAttributes = json['CustomerAttributes'];
    gdprConsents = json['GdprConsents'];
    referralCode = json['ReferralCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Email'] = email;
    data['EmailToRevalidate'] = emailToRevalidate;
    data['CheckUsernameAvailabilityEnabled'] =
        checkUsernameAvailabilityEnabled;
    data['AllowUsersToChangeUsernames'] = allowUsersToChangeUsernames;
    data['UsernamesEnabled'] = usernamesEnabled;
    data['Username'] = username;
    data['GenderEnabled'] = genderEnabled;
    data['Gender'] = gender;
    data['FirstNameEnabled'] = firstNameEnabled;
    data['FirstName'] = firstName;
    data['FirstNameRequired'] = firstNameRequired;
    data['LastNameEnabled'] = lastNameEnabled;
    data['LastName'] = lastName;
    data['LastNameRequired'] = lastNameRequired;
    data['DateOfBirthEnabled'] = dateOfBirthEnabled;
    data['DateOfBirthDay'] = dateOfBirthDay;
    data['DateOfBirthMonth'] = dateOfBirthMonth;
    data['DateOfBirthYear'] = dateOfBirthYear;
    data['DateOfBirthRequired'] = dateOfBirthRequired;
    data['CompanyEnabled'] = companyEnabled;
    data['CompanyRequired'] = companyRequired;
    data['Company'] = company;
    data['StreetAddressEnabled'] = streetAddressEnabled;
    data['StreetAddressRequired'] = streetAddressRequired;
    data['StreetAddress'] = streetAddress;
    data['StreetAddress2Enabled'] = streetAddress2Enabled;
    data['StreetAddress2Required'] = streetAddress2Required;
    data['StreetAddress2'] = streetAddress2;
    data['ZipPostalCodeEnabled'] = zipPostalCodeEnabled;
    data['ZipPostalCodeRequired'] = zipPostalCodeRequired;
    data['ZipPostalCode'] = zipPostalCode;
    data['CityEnabled'] = cityEnabled;
    data['CityRequired'] = cityRequired;
    data['City'] = city;
    data['CountyEnabled'] = countyEnabled;
    data['CountyRequired'] = countyRequired;
    data['County'] = county;
    data['CountryEnabled'] = countryEnabled;
    data['CountryRequired'] = countryRequired;
    data['CountryId'] = countryId;
    data['AvailableCountries'] = availableCountries;
    data['StateProvinceEnabled'] = stateProvinceEnabled;
    data['StateProvinceRequired'] = stateProvinceRequired;
    data['StateProvinceId'] = stateProvinceId;
    data['AvailableStates'] = availableStates;
    data['PhoneEnabled'] = phoneEnabled;
    data['PhoneRequired'] = phoneRequired;
    data['Phone'] = phone;
    data['FaxEnabled'] = faxEnabled;
    data['FaxRequired'] = faxRequired;
    data['Fax'] = fax;
    data['NewsletterEnabled'] = newsletterEnabled;
    data['Newsletter'] = newsletter;
    data['SignatureEnabled'] = signatureEnabled;
    data['Signature'] = signature;
    data['TimeZoneId'] = timeZoneId;
    data['AllowCustomersToSetTimeZone'] = allowCustomersToSetTimeZone;
    data['AvailableTimeZones'] = availableTimeZones;
    data['VatNumber'] = vatNumber;
    data['VatNumberStatusNote'] = vatNumberStatusNote;
    data['DisplayVatNumber'] = displayVatNumber;
    data['AssociatedExternalAuthRecords'] = associatedExternalAuthRecords;
    data['NumberOfExternalAuthenticationProviders'] =
        numberOfExternalAuthenticationProviders;
    data['AllowCustomersToRemoveAssociations'] =
        allowCustomersToRemoveAssociations;
    data['CustomerAttributes'] = customerAttributes;
    data['GdprConsents'] = gdprConsents;
    data['ReferralCode'] = referralCode;
    return data;
  }
}
