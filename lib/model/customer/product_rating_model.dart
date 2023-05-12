class ProductRatingModel {
  List<ProductHistory>? products;

  ProductRatingModel({this.products});

  ProductRatingModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <ProductHistory>[];
      json['products'].forEach((v) {
        products!.add(ProductHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductHistory {
  bool? visibleIndividually;
  String? name;
  String? shortDescription;
  String? fullDescription;
  bool? showOnHomePage;
  dynamic metaKeywords;
  String? metaDescription;
  String? metaTitle;
  bool? allowCustomerReviews;
  int? approvedRatingSum;
  int? notApprovedRatingSum;
  int? approvedTotalReviews;
  int? notApprovedTotalReviews;
  dynamic sku;
  dynamic manufacturerPartNumber;
  dynamic gtin;
  bool? isGiftCard;
  bool? requireOtherProducts;
  bool? automaticallyAddRequiredProducts;
  dynamic requiredProductIds;
  bool? isDownload;
  bool? unlimitedDownloads;
  int? maxNumberOfDownloads;
  dynamic downloadExpirationDays;
  bool? hasSampleDownload;
  bool? hasUserAgreement;
  bool? isRecurring;
  int? recurringCycleLength;
  int? recurringTotalCycles;
  bool? isRental;
  int? rentalPriceLength;
  bool? isShipEnabled;
  bool? isFreeShipping;
  bool? shipSeparately;
  dynamic additionalShippingCharge;
  bool? isTaxExempt;
  int? taxCategoryId;
  bool? isTelecommunicationsOrBroadcastingOrElectronicServices;
  bool? useMultipleWarehouses;
  int? manageInventoryMethodId;
  int? stockQuantity;
  bool? displayStockAvailability;
  bool? displayStockQuantity;
  int? minStockQuantity;
  int? lowStockActivityId;
  int? notifyAdminForQuantityBelow;
  bool? allowBackInStockSubscriptions;
  int? orderMinimumQuantity;
  int? orderMaximumQuantity;
  dynamic allowedQuantities;
  bool? allowAddingOnlyExistingAttributeCombinations;
  bool? disableBuyButton;
  bool? disableWishlistButton;
  bool? availableForPreOrder;
  dynamic preOrderAvailabilityStartDateTimeUtc;
  bool? callForPrice;
  double? price;
  double? oldPrice;
  double? productCost;
  dynamic specialPrice;
  dynamic specialPriceStartDateTimeUtc;
  dynamic specialPriceEndDateTimeUtc;
  bool? customerEntersPrice;
  double? minimumCustomerEnteredPrice;
  double? maximumCustomerEnteredPrice;
  bool? basepriceEnabled;
  double? basepriceAmount;
  double? basepriceBaseAmount;
  bool? hasTierPrices;
  bool? hasDiscountsApplied;
  double? weight;
  double? length;
  double? width;
  double? height;
  dynamic availableStartDateTimeUtc;
  dynamic availableEndDateTimeUtc;
  int? displayOrder;
  bool? published;
  bool? deleted;
  String? createdOnUtc;
  String? updatedOnUtc;
  String? productType;
  int? parentGroupedProductId;
  dynamic roleIds;
  dynamic discountIds;
  dynamic storeIds;
  List<int>? manufacturerIds;
  List<Images>? images;
  List<Attributes>? attributes;
  List<ProductAttributeCombinations>? productAttributeCombinations;
  dynamic productSpecificationAttributes;
  dynamic associatedProductIds;
  List<String>? tags;
  int? vendorId;
  String? seName;
  int? id;

  ProductHistory(
      {this.visibleIndividually,
        this.name,
        this.shortDescription,
        this.fullDescription,
        this.showOnHomePage,
        this.metaKeywords,
        this.metaDescription,
        this.metaTitle,
        this.allowCustomerReviews,
        this.approvedRatingSum,
        this.notApprovedRatingSum,
        this.approvedTotalReviews,
        this.notApprovedTotalReviews,
        this.sku,
        this.manufacturerPartNumber,
        this.gtin,
        this.isGiftCard,
        this.requireOtherProducts,
        this.automaticallyAddRequiredProducts,
        this.requiredProductIds,
        this.isDownload,
        this.unlimitedDownloads,
        this.maxNumberOfDownloads,
        this.downloadExpirationDays,
        this.hasSampleDownload,
        this.hasUserAgreement,
        this.isRecurring,
        this.recurringCycleLength,
        this.recurringTotalCycles,
        this.isRental,
        this.rentalPriceLength,
        this.isShipEnabled,
        this.isFreeShipping,
        this.shipSeparately,
        this.additionalShippingCharge,
        this.isTaxExempt,
        this.taxCategoryId,
        this.isTelecommunicationsOrBroadcastingOrElectronicServices,
        this.useMultipleWarehouses,
        this.manageInventoryMethodId,
        this.stockQuantity,
        this.displayStockAvailability,
        this.displayStockQuantity,
        this.minStockQuantity,
        this.lowStockActivityId,
        this.notifyAdminForQuantityBelow,
        this.allowBackInStockSubscriptions,
        this.orderMinimumQuantity,
        this.orderMaximumQuantity,
        this.allowedQuantities,
        this.allowAddingOnlyExistingAttributeCombinations,
        this.disableBuyButton,
        this.disableWishlistButton,
        this.availableForPreOrder,
        this.preOrderAvailabilityStartDateTimeUtc,
        this.callForPrice,
        this.price,
        this.oldPrice,
        this.productCost,
        this.specialPrice,
        this.specialPriceStartDateTimeUtc,
        this.specialPriceEndDateTimeUtc,
        this.customerEntersPrice,
        this.minimumCustomerEnteredPrice,
        this.maximumCustomerEnteredPrice,
        this.basepriceEnabled,
        this.basepriceAmount,
        this.basepriceBaseAmount,
        this.hasTierPrices,
        this.hasDiscountsApplied,
        this.weight,
        this.length,
        this.width,
        this.height,
        this.availableStartDateTimeUtc,
        this.availableEndDateTimeUtc,
        this.displayOrder,
        this.published,
        this.deleted,
        this.createdOnUtc,
        this.updatedOnUtc,
        this.productType,
        this.parentGroupedProductId,
        this.roleIds,
        this.discountIds,
        this.storeIds,
        this.manufacturerIds,
        this.images,
        this.attributes,
        this.productAttributeCombinations,
        this.productSpecificationAttributes,
        this.associatedProductIds,
        this.tags,
        this.vendorId,
        this.seName,
        this.id});

  ProductHistory.fromJson(Map<String, dynamic> json) {
    visibleIndividually = json['visible_individually'];
    name = json['name'];
    shortDescription = json['short_description'];
    fullDescription = json['full_description'];
    showOnHomePage = json['show_on_home_page'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    metaTitle = json['meta_title'];
    allowCustomerReviews = json['allow_customer_reviews'];
    approvedRatingSum = json['approved_rating_sum'];
    notApprovedRatingSum = json['not_approved_rating_sum'];
    approvedTotalReviews = json['approved_total_reviews'];
    notApprovedTotalReviews = json['not_approved_total_reviews'];
    sku = json['sku'];
    manufacturerPartNumber = json['manufacturer_part_number'];
    gtin = json['gtin'];
    isGiftCard = json['is_gift_card'];
    requireOtherProducts = json['require_other_products'];
    automaticallyAddRequiredProducts =
    json['automatically_add_required_products'];
    isDownload = json['is_download'];
    unlimitedDownloads = json['unlimited_downloads'];
    maxNumberOfDownloads = json['max_number_of_downloads'];
    downloadExpirationDays = json['download_expiration_days'];
    hasSampleDownload = json['has_sample_download'];
    hasUserAgreement = json['has_user_agreement'];
    isRecurring = json['is_recurring'];
    recurringCycleLength = json['recurring_cycle_length'];
    recurringTotalCycles = json['recurring_total_cycles'];
    isRental = json['is_rental'];
    rentalPriceLength = json['rental_price_length'];
    isShipEnabled = json['is_ship_enabled'];
    isFreeShipping = json['is_free_shipping'];
    shipSeparately = json['ship_separately'];
    additionalShippingCharge = json['additional_shipping_charge'];
    isTaxExempt = json['is_tax_exempt'];
    taxCategoryId = json['tax_category_id'];
    isTelecommunicationsOrBroadcastingOrElectronicServices =
    json['is_telecommunications_or_broadcasting_or_electronic_services'];
    useMultipleWarehouses = json['use_multiple_warehouses'];
    manageInventoryMethodId = json['manage_inventory_method_id'];
    stockQuantity = json['stock_quantity'];
    displayStockAvailability = json['display_stock_availability'];
    displayStockQuantity = json['display_stock_quantity'];
    minStockQuantity = json['min_stock_quantity'];
    lowStockActivityId = json['low_stock_activity_id'];
    notifyAdminForQuantityBelow = json['notify_admin_for_quantity_below'];
    allowBackInStockSubscriptions = json['allow_back_in_stock_subscriptions'];
    orderMinimumQuantity = json['order_minimum_quantity'];
    orderMaximumQuantity = json['order_maximum_quantity'];
    allowedQuantities = json['allowed_quantities'];
    allowAddingOnlyExistingAttributeCombinations =
    json['allow_adding_only_existing_attribute_combinations'];
    disableBuyButton = json['disable_buy_button'];
    disableWishlistButton = json['disable_wishlist_button'];
    availableForPreOrder = json['available_for_pre_order'];
    preOrderAvailabilityStartDateTimeUtc =
    json['pre_order_availability_start_date_time_utc'];
    callForPrice = json['call_for_price'];
    price = json['price'];
    oldPrice = json['old_price'];
    productCost = json['product_cost'];
    specialPrice = json['special_price'];
    specialPriceStartDateTimeUtc = json['special_price_start_date_time_utc'];
    specialPriceEndDateTimeUtc = json['special_price_end_date_time_utc'];
    customerEntersPrice = json['customer_enters_price'];
    minimumCustomerEnteredPrice = json['minimum_customer_entered_price'];
    maximumCustomerEnteredPrice = json['maximum_customer_entered_price'];
    basepriceEnabled = json['baseprice_enabled'];
    basepriceAmount = json['baseprice_amount'];
    basepriceBaseAmount = json['baseprice_base_amount'];
    hasTierPrices = json['has_tier_prices'];
    hasDiscountsApplied = json['has_discounts_applied'];
    weight = json['weight'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    availableStartDateTimeUtc = json['available_start_date_time_utc'];
    availableEndDateTimeUtc = json['available_end_date_time_utc'];
    displayOrder = json['display_order'];
    published = json['published'];
    deleted = json['deleted'];
    createdOnUtc = json['created_on_utc'];
    updatedOnUtc = json['updated_on_utc'];
    productType = json['product_type'];
    parentGroupedProductId = json['parent_grouped_product_id'];
    manufacturerIds = json['manufacturer_ids'].cast<int>();
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    if (json['product_attribute_combinations'] != null) {
      productAttributeCombinations = <ProductAttributeCombinations>[];
      json['product_attribute_combinations'].forEach((v) {
        productAttributeCombinations!
            .add(ProductAttributeCombinations.fromJson(v));
      });
    }
    productSpecificationAttributes = json['product_specification_attributes'];
    tags = json['tags'].cast<String>();
    vendorId = json['vendor_id'];
    seName = json['se_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['visible_individually'] = visibleIndividually;
    data['name'] = name;
    data['short_description'] = shortDescription;
    data['full_description'] = fullDescription;
    data['show_on_home_page'] = showOnHomePage;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['meta_title'] = metaTitle;
    data['allow_customer_reviews'] = allowCustomerReviews;
    data['approved_rating_sum'] = approvedRatingSum;
    data['not_approved_rating_sum'] = notApprovedRatingSum;
    data['approved_total_reviews'] = approvedTotalReviews;
    data['not_approved_total_reviews'] = notApprovedTotalReviews;
    data['sku'] = sku;
    data['manufacturer_part_number'] = manufacturerPartNumber;
    data['gtin'] = gtin;
    data['is_gift_card'] = isGiftCard;
    data['require_other_products'] = requireOtherProducts;
    data['automatically_add_required_products'] =
        automaticallyAddRequiredProducts;
    if (requiredProductIds != null) {
      data['required_product_ids'] =
          requiredProductIds!.map((v) => v.toJson()).toList();
    }
    data['is_download'] = isDownload;
    data['unlimited_downloads'] = unlimitedDownloads;
    data['max_number_of_downloads'] = maxNumberOfDownloads;
    data['download_expiration_days'] = downloadExpirationDays;
    data['has_sample_download'] = hasSampleDownload;
    data['has_user_agreement'] = hasUserAgreement;
    data['is_recurring'] = isRecurring;
    data['recurring_cycle_length'] = recurringCycleLength;
    data['recurring_total_cycles'] = recurringTotalCycles;
    data['is_rental'] = isRental;
    data['rental_price_length'] = rentalPriceLength;
    data['is_ship_enabled'] = isShipEnabled;
    data['is_free_shipping'] = isFreeShipping;
    data['ship_separately'] = shipSeparately;
    data['additional_shipping_charge'] = additionalShippingCharge;
    data['is_tax_exempt'] = isTaxExempt;
    data['tax_category_id'] = taxCategoryId;
    data['is_telecommunications_or_broadcasting_or_electronic_services'] =
        isTelecommunicationsOrBroadcastingOrElectronicServices;
    data['use_multiple_warehouses'] = useMultipleWarehouses;
    data['manage_inventory_method_id'] = manageInventoryMethodId;
    data['stock_quantity'] = stockQuantity;
    data['display_stock_availability'] = displayStockAvailability;
    data['display_stock_quantity'] = displayStockQuantity;
    data['min_stock_quantity'] = minStockQuantity;
    data['low_stock_activity_id'] = lowStockActivityId;
    data['notify_admin_for_quantity_below'] = notifyAdminForQuantityBelow;
    data['allow_back_in_stock_subscriptions'] =
        allowBackInStockSubscriptions;
    data['order_minimum_quantity'] = orderMinimumQuantity;
    data['order_maximum_quantity'] = orderMaximumQuantity;
    data['allowed_quantities'] = allowedQuantities;
    data['allow_adding_only_existing_attribute_combinations'] =
        allowAddingOnlyExistingAttributeCombinations;
    data['disable_buy_button'] = disableBuyButton;
    data['disable_wishlist_button'] = disableWishlistButton;
    data['available_for_pre_order'] = availableForPreOrder;
    data['pre_order_availability_start_date_time_utc'] =
        preOrderAvailabilityStartDateTimeUtc;
    data['call_for_price'] = callForPrice;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['product_cost'] = productCost;
    data['special_price'] = specialPrice;
    data['special_price_start_date_time_utc'] =
        specialPriceStartDateTimeUtc;
    data['special_price_end_date_time_utc'] = specialPriceEndDateTimeUtc;
    data['customer_enters_price'] = customerEntersPrice;
    data['minimum_customer_entered_price'] = minimumCustomerEnteredPrice;
    data['maximum_customer_entered_price'] = maximumCustomerEnteredPrice;
    data['baseprice_enabled'] = basepriceEnabled;
    data['baseprice_amount'] = basepriceAmount;
    data['baseprice_base_amount'] = basepriceBaseAmount;
    data['has_tier_prices'] = hasTierPrices;
    data['has_discounts_applied'] = hasDiscountsApplied;
    data['weight'] = weight;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['available_start_date_time_utc'] = availableStartDateTimeUtc;
    data['available_end_date_time_utc'] = availableEndDateTimeUtc;
    data['display_order'] = displayOrder;
    data['published'] = published;
    data['deleted'] = deleted;
    data['created_on_utc'] = createdOnUtc;
    data['updated_on_utc'] = updatedOnUtc;
    data['product_type'] = productType;
    data['parent_grouped_product_id'] = parentGroupedProductId;
    if (roleIds != null) {
      data['role_ids'] = roleIds!.map((v) => v.toJson()).toList();
    }
    if (discountIds != null) {
      data['discount_ids'] = discountIds!.map((v) => v.toJson()).toList();
    }
    if (storeIds != null) {
      data['store_ids'] = storeIds!.map((v) => v.toJson()).toList();
    }
    data['manufacturer_ids'] = manufacturerIds;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    if (productAttributeCombinations != null) {
      data['product_attribute_combinations'] =
          productAttributeCombinations!.map((v) => v.toJson()).toList();
    }
    data['product_specification_attributes'] =
        productSpecificationAttributes;
    if (associatedProductIds != null) {
      data['associated_product_ids'] =
          associatedProductIds!.map((v) => v.toJson()).toList();
    }
    data['tags'] = tags;
    data['vendor_id'] = vendorId;
    data['se_name'] = seName;
    data['id'] = id;
    return data;
  }
}

class Images {
  int? id;
  int? pictureId;
  int? position;
  String? src;
  dynamic attachment;

  Images({this.id, this.pictureId, this.position, this.src, this.attachment});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pictureId = json['picture_id'];
    position = json['position'];
    src = json['src'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['picture_id'] = pictureId;
    data['position'] = position;
    data['src'] = src;
    data['attachment'] = attachment;
    return data;
  }
}

class Attributes {
  int? productAttributeId;
  String? productAttributeName;
  String? textPrompt;
  bool? isRequired;
  int? attributeControlTypeId;
  int? displayOrder;
  dynamic defaultValue;
  String? attributeControlTypeName;
  List<AttributeValues>? attributeValues;
  int? id;

  Attributes(
      {this.productAttributeId,
        this.productAttributeName,
        this.textPrompt,
        this.isRequired,
        this.attributeControlTypeId,
        this.displayOrder,
        this.defaultValue,
        this.attributeControlTypeName,
        this.attributeValues,
        this.id});

  Attributes.fromJson(Map<String, dynamic> json) {
    productAttributeId = json['product_attribute_id'];
    productAttributeName = json['product_attribute_name'];
    textPrompt = json['text_prompt'];
    isRequired = json['is_required'];
    attributeControlTypeId = json['attribute_control_type_id'];
    displayOrder = json['display_order'];
    defaultValue = json['default_value'];
    attributeControlTypeName = json['attribute_control_type_name'];
    if (json['attribute_values'] != null) {
      attributeValues = <AttributeValues>[];
      json['attribute_values'].forEach((v) {
        attributeValues!.add(AttributeValues.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_attribute_id'] = productAttributeId;
    data['product_attribute_name'] = productAttributeName;
    data['text_prompt'] = textPrompt;
    data['is_required'] = isRequired;
    data['attribute_control_type_id'] = attributeControlTypeId;
    data['display_order'] = displayOrder;
    data['default_value'] = defaultValue;
    data['attribute_control_type_name'] = attributeControlTypeName;
    if (attributeValues != null) {
      data['attribute_values'] =
          attributeValues!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class AttributeValues {
  int? typeId;
  int? associatedProductId;
  String? name;
  String? colorSquaresRgb;
  dynamic imageSquaresImage;
  double? priceAdjustment;
  double? weightAdjustment;
  double? cost;
  int? quantity;
  bool? isPreSelected;
  int? displayOrder;
  dynamic productImageId;
  String? type;
  int? id;

  AttributeValues(
      {this.typeId,
        this.associatedProductId,
        this.name,
        this.colorSquaresRgb,
        this.imageSquaresImage,
        this.priceAdjustment,
        this.weightAdjustment,
        this.cost,
        this.quantity,
        this.isPreSelected,
        this.displayOrder,
        this.productImageId,
        this.type,
        this.id});

  AttributeValues.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    associatedProductId = json['associated_product_id'];
    name = json['name'];
    colorSquaresRgb = json['color_squares_rgb'];
    imageSquaresImage = json['image_squares_image'];
    priceAdjustment = json['price_adjustment'];
    weightAdjustment = json['weight_adjustment'];
    cost = json['cost'];
    quantity = json['quantity'];
    isPreSelected = json['is_pre_selected'];
    displayOrder = json['display_order'];
    productImageId = json['product_image_id'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type_id'] = typeId;
    data['associated_product_id'] = associatedProductId;
    data['name'] = name;
    data['color_squares_rgb'] = colorSquaresRgb;
    data['image_squares_image'] = imageSquaresImage;
    data['price_adjustment'] = priceAdjustment;
    data['weight_adjustment'] = weightAdjustment;
    data['cost'] = cost;
    data['quantity'] = quantity;
    data['is_pre_selected'] = isPreSelected;
    data['display_order'] = displayOrder;
    data['product_image_id'] = productImageId;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}

class ProductAttributeCombinations {
  int? productId;
  String? attributesXml;
  int? stockQuantity;
  String? sku;
  String? manufacturerPartNumber;
  dynamic gtin;
  double? overriddenPrice;
  int? pictureId;
  int? id;

  ProductAttributeCombinations(
      {this.productId,
        this.attributesXml,
        this.stockQuantity,
        this.sku,
        this.manufacturerPartNumber,
        this.gtin,
        this.overriddenPrice,
        this.pictureId,
        this.id});

  ProductAttributeCombinations.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    attributesXml = json['attributes_xml'];
    stockQuantity = json['stock_quantity'];
    sku = json['sku'];
    manufacturerPartNumber = json['manufacturer_part_number'];
    gtin = json['gtin'];
    overriddenPrice = json['overridden_price'];
    pictureId = json['picture_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['attributes_xml'] = attributesXml;
    data['stock_quantity'] = stockQuantity;
    data['sku'] = sku;
    data['manufacturer_part_number'] = manufacturerPartNumber;
    data['gtin'] = gtin;
    data['overridden_price'] = overriddenPrice;
    data['picture_id'] = pictureId;
    data['id'] = id;
    return data;
  }
}
