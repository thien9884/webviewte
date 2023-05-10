class CustomerModel {
  ObjectPropertyNameValuePairs? objectPropertyNameValuePairs;
  List<Customers>? customers;

  CustomerModel({this.objectPropertyNameValuePairs, this.customers});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    objectPropertyNameValuePairs = json['ObjectPropertyNameValuePairs'] != null
        ? ObjectPropertyNameValuePairs.fromJson(
            json['ObjectPropertyNameValuePairs'])
        : null;
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers!.add(Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (objectPropertyNameValuePairs != null) {
      data['ObjectPropertyNameValuePairs'] =
          objectPropertyNameValuePairs!.toJson();
    }
    if (customers != null) {
      data['customers'] = customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ObjectPropertyNameValuePairs {
  ObjectPropertyNameValuePairs();

  ObjectPropertyNameValuePairs.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}

class Customers {
  BillingAddress? billingAddress;
  dynamic shippingAddress;
  List<Addresses>? addresses;
  String? customerGuid;
  String? username;
  String? email;
  String? firstName;
  dynamic lastName;
  int? languageId;
  dynamic currencyId;
  String? dateOfBirth;
  String? gender;
  dynamic adminComment;
  bool? isTaxExempt;
  bool? hasShoppingCartItems;
  bool? active;
  bool? deleted;
  bool? isSystemAccount;
  dynamic systemName;
  String? lastIpAddress;
  String? createdOnUtc;
  String? lastLoginDateUtc;
  String? lastActivityDateUtc;
  int? registeredInStoreId;
  bool? subscribedToNewsletter;
  dynamic vatNumber;
  dynamic vatNumberStatusId;
  dynamic euCookieLawAccepted;
  dynamic company;
  dynamic roleIds;
  int? id;

  Customers(
      {this.billingAddress,
      this.shippingAddress,
      this.addresses,
      this.customerGuid,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.languageId,
      this.currencyId,
      this.dateOfBirth,
      this.gender,
      this.adminComment,
      this.isTaxExempt,
      this.hasShoppingCartItems,
      this.active,
      this.deleted,
      this.isSystemAccount,
      this.systemName,
      this.lastIpAddress,
      this.createdOnUtc,
      this.lastLoginDateUtc,
      this.lastActivityDateUtc,
      this.registeredInStoreId,
      this.subscribedToNewsletter,
      this.vatNumber,
      this.vatNumberStatusId,
      this.euCookieLawAccepted,
      this.company,
      this.roleIds,
      this.id});

  Customers.fromJson(Map<String, dynamic> json) {
    billingAddress = json['billing_address'] != null
        ? BillingAddress.fromJson(json['billing_address'])
        : null;
    shippingAddress = json['shipping_address'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    customerGuid = json['customer_guid'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    languageId = json['language_id'];
    currencyId = json['currency_id'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    adminComment = json['admin_comment'];
    isTaxExempt = json['is_tax_exempt'];
    hasShoppingCartItems = json['has_shopping_cart_items'];
    active = json['active'];
    deleted = json['deleted'];
    isSystemAccount = json['is_system_account'];
    systemName = json['system_name'];
    lastIpAddress = json['last_ip_address'];
    createdOnUtc = json['created_on_utc'];
    lastLoginDateUtc = json['last_login_date_utc'];
    lastActivityDateUtc = json['last_activity_date_utc'];
    registeredInStoreId = json['registered_in_store_id'];
    subscribedToNewsletter = json['subscribed_to_newsletter'];
    vatNumber = json['vat_number'];
    vatNumberStatusId = json['vat_number_status_id'];
    euCookieLawAccepted = json['eu_cookie_law_accepted'];
    company = json['company'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (billingAddress != null) {
      data['billing_address'] = billingAddress!.toJson();
    }
    data['shipping_address'] = shippingAddress;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['customer_guid'] = customerGuid;
    data['username'] = username;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['language_id'] = languageId;
    data['currency_id'] = currencyId;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['admin_comment'] = adminComment;
    data['is_tax_exempt'] = isTaxExempt;
    data['has_shopping_cart_items'] = hasShoppingCartItems;
    data['active'] = active;
    data['deleted'] = deleted;
    data['is_system_account'] = isSystemAccount;
    data['system_name'] = systemName;
    data['last_ip_address'] = lastIpAddress;
    data['created_on_utc'] = createdOnUtc;
    data['last_login_date_utc'] = lastLoginDateUtc;
    data['last_activity_date_utc'] = lastActivityDateUtc;
    data['registered_in_store_id'] = registeredInStoreId;
    data['subscribed_to_newsletter'] = subscribedToNewsletter;
    data['vat_number'] = vatNumber;
    data['vat_number_status_id'] = vatNumberStatusId;
    data['eu_cookie_law_accepted'] = euCookieLawAccepted;
    data['company'] = company;
    if (roleIds != null) {
      data['role_ids'] = roleIds!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class BillingAddress {
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

  BillingAddress(
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

  BillingAddress.fromJson(Map<String, dynamic> json) {
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

class Addresses {
  String? firstName;
  String? lastName;
  String? email;
  String? company;
  int? countryId;
  dynamic country;
  int? stateProvinceId;
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

  Addresses(
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

  Addresses.fromJson(Map<String, dynamic> json) {
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
