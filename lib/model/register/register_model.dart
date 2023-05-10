class RegisterModel {
  String? email;
  bool? enteringEmailTwice;
  String? confirmEmail;
  bool? usernamesEnabled;
  String? username;
  bool? checkUsernameAvailabilityEnabled;
  String? password;
  String? confirmPassword;
  bool? genderEnabled;
  String? gender;
  bool? firstNameEnabled;
  String? firstName;
  bool? firstNameRequired;
  bool? lastNameEnabled;
  String? lastName;
  bool? lastNameRequired;
  bool? dateOfBirthEnabled;
  int? dateOfBirthDay;
  int? dateOfBirthMonth;
  int? dateOfBirthYear;
  bool? dateOfBirthRequired;
  bool? companyEnabled;
  bool? companyRequired;
  String? company;
  bool? streetAddressEnabled;
  bool? streetAddressRequired;
  String? streetAddress;
  bool? streetAddress2Enabled;
  bool? streetAddress2Required;
  String? streetAddress2;
  bool? zipPostalCodeEnabled;
  bool? zipPostalCodeRequired;
  String? zipPostalCode;
  bool? cityEnabled;
  bool? cityRequired;
  String? city;
  bool? countyEnabled;
  bool? countyRequired;
  String? county;
  bool? countryEnabled;
  bool? countryRequired;
  int? countryId;
  String? referralCode;
  List<AvailableCountries>? availableCountries;
  bool? stateProvinceEnabled;
  bool? stateProvinceRequired;
  int? stateProvinceId;
  List<AvailableStates>? availableStates;
  bool? phoneEnabled;
  bool? phoneRequired;
  String? phone;
  bool? faxEnabled;
  bool? faxRequired;
  String? fax;
  bool? newsletterEnabled;
  bool? newsletter;
  bool? acceptPrivacyPolicyEnabled;
  bool? acceptPrivacyPolicyPopup;
  String? timeZoneId;
  bool? allowCustomersToSetTimeZone;
  List<AvailableTimeZones>? availableTimeZones;
  String? vatNumber;
  bool? displayVatNumber;
  bool? honeypotEnabled;
  bool? displayCaptcha;
  List<CustomerAttributes>? customerAttributes;
  List<GdprConsents>? gdprConsents;

  RegisterModel(
      {this.email,
      this.enteringEmailTwice,
      this.confirmEmail,
      this.usernamesEnabled,
      this.username,
      this.checkUsernameAvailabilityEnabled,
      this.password,
      this.confirmPassword,
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
      this.referralCode,
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
      this.acceptPrivacyPolicyEnabled,
      this.acceptPrivacyPolicyPopup,
      this.timeZoneId,
      this.allowCustomersToSetTimeZone,
      this.availableTimeZones,
      this.vatNumber,
      this.displayVatNumber,
      this.honeypotEnabled,
      this.displayCaptcha,
      this.customerAttributes,
      this.gdprConsents});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    enteringEmailTwice = json['EnteringEmailTwice'];
    confirmEmail = json['ConfirmEmail'];
    usernamesEnabled = json['UsernamesEnabled'];
    username = json['Username'];
    checkUsernameAvailabilityEnabled = json['CheckUsernameAvailabilityEnabled'];
    password = json['Password'];
    confirmPassword = json['ConfirmPassword'];
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
    referralCode = json['ReferralCode'];
    if (json['AvailableCountries'] != null) {
      availableCountries = <AvailableCountries>[];
      json['AvailableCountries'].forEach((v) {
        availableCountries!.add(AvailableCountries.fromJson(v));
      });
    }
    stateProvinceEnabled = json['StateProvinceEnabled'];
    stateProvinceRequired = json['StateProvinceRequired'];
    stateProvinceId = json['StateProvinceId'];
    if (json['AvailableStates'] != null) {
      availableStates = <AvailableStates>[];
      json['AvailableStates'].forEach((v) {
        availableStates!.add(AvailableStates.fromJson(v));
      });
    }
    phoneEnabled = json['PhoneEnabled'];
    phoneRequired = json['PhoneRequired'];
    phone = json['Phone'];
    faxEnabled = json['FaxEnabled'];
    faxRequired = json['FaxRequired'];
    fax = json['Fax'];
    newsletterEnabled = json['NewsletterEnabled'];
    newsletter = json['Newsletter'];
    acceptPrivacyPolicyEnabled = json['AcceptPrivacyPolicyEnabled'];
    acceptPrivacyPolicyPopup = json['AcceptPrivacyPolicyPopup'];
    timeZoneId = json['TimeZoneId'];
    allowCustomersToSetTimeZone = json['AllowCustomersToSetTimeZone'];
    if (json['AvailableTimeZones'] != null) {
      availableTimeZones = <AvailableTimeZones>[];
      json['AvailableTimeZones'].forEach((v) {
        availableTimeZones!.add(AvailableTimeZones.fromJson(v));
      });
    }
    vatNumber = json['VatNumber'];
    displayVatNumber = json['DisplayVatNumber'];
    honeypotEnabled = json['HoneypotEnabled'];
    displayCaptcha = json['DisplayCaptcha'];
    if (json['CustomerAttributes'] != null) {
      customerAttributes = <CustomerAttributes>[];
      json['CustomerAttributes'].forEach((v) {
        customerAttributes!.add(CustomerAttributes.fromJson(v));
      });
    }
    if (json['GdprConsents'] != null) {
      gdprConsents = <GdprConsents>[];
      json['GdprConsents'].forEach((v) {
        gdprConsents!.add(GdprConsents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Email'] = email;
    data['EnteringEmailTwice'] = enteringEmailTwice;
    data['ConfirmEmail'] = confirmEmail;
    data['UsernamesEnabled'] = usernamesEnabled;
    data['Username'] = username;
    data['CheckUsernameAvailabilityEnabled'] = checkUsernameAvailabilityEnabled;
    data['Password'] = password;
    data['ConfirmPassword'] = confirmPassword;
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
    data['ReferralCode'] = referralCode;
    if (availableCountries != null) {
      data['AvailableCountries'] =
          availableCountries!.map((v) => v.toJson()).toList();
    }
    data['StateProvinceEnabled'] = stateProvinceEnabled;
    data['StateProvinceRequired'] = stateProvinceRequired;
    data['StateProvinceId'] = stateProvinceId;
    if (availableStates != null) {
      data['AvailableStates'] =
          availableStates!.map((v) => v.toJson()).toList();
    }
    data['PhoneEnabled'] = phoneEnabled;
    data['PhoneRequired'] = phoneRequired;
    data['Phone'] = phone;
    data['FaxEnabled'] = faxEnabled;
    data['FaxRequired'] = faxRequired;
    data['Fax'] = fax;
    data['NewsletterEnabled'] = newsletterEnabled;
    data['Newsletter'] = newsletter;
    data['AcceptPrivacyPolicyEnabled'] = acceptPrivacyPolicyEnabled;
    data['AcceptPrivacyPolicyPopup'] = acceptPrivacyPolicyPopup;
    data['TimeZoneId'] = timeZoneId;
    data['AllowCustomersToSetTimeZone'] = allowCustomersToSetTimeZone;
    if (availableTimeZones != null) {
      data['AvailableTimeZones'] =
          availableTimeZones!.map((v) => v.toJson()).toList();
    }
    data['VatNumber'] = vatNumber;
    data['DisplayVatNumber'] = displayVatNumber;
    data['HoneypotEnabled'] = honeypotEnabled;
    data['DisplayCaptcha'] = displayCaptcha;
    if (customerAttributes != null) {
      data['CustomerAttributes'] =
          customerAttributes!.map((v) => v.toJson()).toList();
    }
    if (gdprConsents != null) {
      data['GdprConsents'] = gdprConsents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailableCountries {
  bool? disabled;
  Group? group;
  bool? selected;
  String? text;
  String? value;

  AvailableCountries(
      {this.disabled, this.group, this.selected, this.text, this.value});

  AvailableCountries.fromJson(Map<String, dynamic> json) {
    disabled = json['Disabled'];
    group = json['Group'] != null ? Group.fromJson(json['Group']) : null;
    selected = json['Selected'];
    text = json['Text'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Disabled'] = disabled;
    if (group != null) {
      data['Group'] = group!.toJson();
    }
    data['Selected'] = selected;
    data['Text'] = text;
    data['Value'] = value;
    return data;
  }
}

class AvailableStates {
  bool? disabled;
  Group? group;
  bool? selected;
  String? text;
  String? value;

  AvailableStates(
      {this.disabled, this.group, this.selected, this.text, this.value});

  AvailableStates.fromJson(Map<String, dynamic> json) {
    disabled = json['Disabled'];
    group = json['Group'] != null ? Group.fromJson(json['Group']) : null;
    selected = json['Selected'];
    text = json['Text'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Disabled'] = disabled;
    if (group != null) {
      data['Group'] = group!.toJson();
    }
    data['Selected'] = selected;
    data['Text'] = text;
    data['Value'] = value;
    return data;
  }
}

class AvailableTimeZones {
  bool? disabled;
  Group? group;
  bool? selected;
  String? text;
  String? value;

  AvailableTimeZones(
      {this.disabled, this.group, this.selected, this.text, this.value});

  AvailableTimeZones.fromJson(Map<String, dynamic> json) {
    disabled = json['Disabled'];
    group = json['Group'] != null ? Group.fromJson(json['Group']) : null;
    selected = json['Selected'];
    text = json['Text'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Disabled'] = disabled;
    if (group != null) {
      data['Group'] = group!.toJson();
    }
    data['Selected'] = selected;
    data['Text'] = text;
    data['Value'] = value;
    return data;
  }
}

class Group {
  bool? disabled;
  String? name;

  Group({this.disabled, this.name});

  Group.fromJson(Map<String, dynamic> json) {
    disabled = json['Disabled'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Disabled'] = disabled;
    data['Name'] = name;
    return data;
  }
}

class CustomerAttributes {
  String? name;
  bool? isRequired;
  String? defaultValue;
  String? attributeControlType;
  List<Values>? values;

  CustomerAttributes(
      {this.name,
      this.isRequired,
      this.defaultValue,
      this.attributeControlType,
      this.values});

  CustomerAttributes.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    isRequired = json['IsRequired'];
    defaultValue = json['DefaultValue'];
    attributeControlType = json['AttributeControlType'];
    if (json['Values'] != null) {
      values = <Values>[];
      json['Values'].forEach((v) {
        values!.add(Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['IsRequired'] = isRequired;
    data['DefaultValue'] = defaultValue;
    data['AttributeControlType'] = attributeControlType;
    if (values != null) {
      data['Values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String? name;
  bool? isPreSelected;

  Values({this.name, this.isPreSelected});

  Values.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    isPreSelected = json['IsPreSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['IsPreSelected'] = isPreSelected;
    return data;
  }
}

class GdprConsents {
  String? message;
  bool? isRequired;
  String? requiredMessage;
  bool? accepted;

  GdprConsents(
      {this.message, this.isRequired, this.requiredMessage, this.accepted});

  GdprConsents.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    isRequired = json['IsRequired'];
    requiredMessage = json['RequiredMessage'];
    accepted = json['Accepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['IsRequired'] = isRequired;
    data['RequiredMessage'] = requiredMessage;
    data['Accepted'] = accepted;
    return data;
  }
}
