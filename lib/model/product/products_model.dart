class ProductsModel {
  int? productTypeId;
  int? parentGroupedProductId;
  bool? visibleIndividually;
  String? name;
  String? shortDescription;
  String? fullDescription;
  dynamic homePageDescription;
  String? productPolicy;
  String? seoDescription;
  bool? haveTradeIn;
  bool? haveInstallment;
  bool? showOnAllCategory;
  dynamic adminComment;
  int? productTemplateId;
  int? vendorId;
  bool? showOnHomepage;
  dynamic metaKeywords;
  String? metaDescription;
  String? metaTitle;
  bool? allowCustomerReviews;
  int? approvedRatingSum;
  int? notApprovedRatingSum;
  int? approvedTotalReviews;
  int? notApprovedTotalReviews;
  bool? subjectToAcl;
  bool? limitedToStores;
  dynamic sku;
  dynamic manufacturerPartNumber;
  dynamic gtin;
  bool? isGiftCard;
  int? giftCardTypeId;
  dynamic overriddenGiftCardAmount;
  bool? requireOtherProducts;
  dynamic requiredProductIds;
  bool? automaticallyAddRequiredProducts;
  bool? isDownload;
  int? downloadId;
  bool? unlimitedDownloads;
  int? maxNumberOfDownloads;
  dynamic downloadExpirationDays;
  int? downloadActivationTypeId;
  bool? hasSampleDownload;
  int? sampleDownloadId;
  bool? hasUserAgreement;
  dynamic userAgreementText;
  bool? isRecurring;
  int? recurringCycleLength;
  int? recurringCyclePeriodId;
  int? recurringTotalCycles;
  bool? isRental;
  int? rentalPriceLength;
  int? rentalPricePeriodId;
  bool? isShipEnabled;
  bool? isFreeShipping;
  bool? shipSeparately;
  double? additionalShippingCharge;
  int? deliveryDateId;
  bool? isTaxExempt;
  int? taxCategoryId;
  bool? isTelecommunicationsOrBroadcastingOrElectronicServices;
  int? manageInventoryMethodId;
  int? productAvailabilityRangeId;
  bool? useMultipleWarehouses;
  int? warehouseId;
  int? stockQuantity;
  bool? displayStockAvailability;
  bool? displayStockQuantity;
  int? minStockQuantity;
  int? lowStockActivityId;
  int? notifyAdminForQuantityBelow;
  int? backorderModeId;
  bool? allowBackInStockSubscriptions;
  int? orderMinimumQuantity;
  int? orderMaximumQuantity;
  dynamic allowedQuantities;
  bool? allowAddingOnlyExistingAttributeCombinations;
  bool? notReturnable;
  bool? disableBuyButton;
  bool? disableWishlistButton;
  bool? availableForPreOrder;
  dynamic preOrderAvailabilityStartDateTimeUtc;
  bool? callForPrice;
  double? price;
  double? oldPrice;
  double? productCost;
  bool? customerEntersPrice;
  double? minimumCustomerEnteredPrice;
  double? maximumCustomerEnteredPrice;
  bool? basepriceEnabled;
  double? basepriceAmount;
  int? basepriceUnitId;
  double? basepriceBaseAmount;
  int? basepriceBaseUnitId;
  bool? markAsNew;
  dynamic markAsNewStartDateTimeUtc;
  dynamic markAsNewEndDateTimeUtc;
  bool? hasTierPrices;
  bool? hasDiscountsApplied;
  double? weight;
  double? length;
  double? width;
  double? height;
  dynamic availableStartDateTimeUtc;
  dynamic availableEndDateTimeUtc;
  int? displayOrder;
  int? displayOrderInCategory;
  bool? published;
  bool? deleted;
  String? createdOnUtc;
  String? updatedOnUtc;
  String? productType;
  String? backorderMode;
  String? downloadActivationType;
  String? giftCardType;
  String? lowStockActivity;
  String? manageInventoryMethod;
  String? recurringCyclePeriod;
  String? rentalPricePeriod;
  bool? flashSale;
  dynamic flashSaleStartTimeUTC;
  dynamic flashSaleEndTimeUTC;
  double? flashSalePriceAmount;
  dynamic flashSalePriceHidden;
  int? flashSaleQuantity;
  int? id;

  ProductsModel(
      {this.productTypeId,
      this.parentGroupedProductId,
      this.visibleIndividually,
      this.name,
      this.shortDescription,
      this.fullDescription,
      this.homePageDescription,
      this.productPolicy,
      this.seoDescription,
      this.haveTradeIn,
      this.haveInstallment,
      this.showOnAllCategory,
      this.adminComment,
      this.productTemplateId,
      this.vendorId,
      this.showOnHomepage,
      this.metaKeywords,
      this.metaDescription,
      this.metaTitle,
      this.allowCustomerReviews,
      this.approvedRatingSum,
      this.notApprovedRatingSum,
      this.approvedTotalReviews,
      this.notApprovedTotalReviews,
      this.subjectToAcl,
      this.limitedToStores,
      this.sku,
      this.manufacturerPartNumber,
      this.gtin,
      this.isGiftCard,
      this.giftCardTypeId,
      this.overriddenGiftCardAmount,
      this.requireOtherProducts,
      this.requiredProductIds,
      this.automaticallyAddRequiredProducts,
      this.isDownload,
      this.downloadId,
      this.unlimitedDownloads,
      this.maxNumberOfDownloads,
      this.downloadExpirationDays,
      this.downloadActivationTypeId,
      this.hasSampleDownload,
      this.sampleDownloadId,
      this.hasUserAgreement,
      this.userAgreementText,
      this.isRecurring,
      this.recurringCycleLength,
      this.recurringCyclePeriodId,
      this.recurringTotalCycles,
      this.isRental,
      this.rentalPriceLength,
      this.rentalPricePeriodId,
      this.isShipEnabled,
      this.isFreeShipping,
      this.shipSeparately,
      this.additionalShippingCharge,
      this.deliveryDateId,
      this.isTaxExempt,
      this.taxCategoryId,
      this.isTelecommunicationsOrBroadcastingOrElectronicServices,
      this.manageInventoryMethodId,
      this.productAvailabilityRangeId,
      this.useMultipleWarehouses,
      this.warehouseId,
      this.stockQuantity,
      this.displayStockAvailability,
      this.displayStockQuantity,
      this.minStockQuantity,
      this.lowStockActivityId,
      this.notifyAdminForQuantityBelow,
      this.backorderModeId,
      this.allowBackInStockSubscriptions,
      this.orderMinimumQuantity,
      this.orderMaximumQuantity,
      this.allowedQuantities,
      this.allowAddingOnlyExistingAttributeCombinations,
      this.notReturnable,
      this.disableBuyButton,
      this.disableWishlistButton,
      this.availableForPreOrder,
      this.preOrderAvailabilityStartDateTimeUtc,
      this.callForPrice,
      this.price,
      this.oldPrice,
      this.productCost,
      this.customerEntersPrice,
      this.minimumCustomerEnteredPrice,
      this.maximumCustomerEnteredPrice,
      this.basepriceEnabled,
      this.basepriceAmount,
      this.basepriceUnitId,
      this.basepriceBaseAmount,
      this.basepriceBaseUnitId,
      this.markAsNew,
      this.markAsNewStartDateTimeUtc,
      this.markAsNewEndDateTimeUtc,
      this.hasTierPrices,
      this.hasDiscountsApplied,
      this.weight,
      this.length,
      this.width,
      this.height,
      this.availableStartDateTimeUtc,
      this.availableEndDateTimeUtc,
      this.displayOrder,
      this.displayOrderInCategory,
      this.published,
      this.deleted,
      this.createdOnUtc,
      this.updatedOnUtc,
      this.productType,
      this.backorderMode,
      this.downloadActivationType,
      this.giftCardType,
      this.lowStockActivity,
      this.manageInventoryMethod,
      this.recurringCyclePeriod,
      this.rentalPricePeriod,
      this.flashSale,
      this.flashSaleStartTimeUTC,
      this.flashSaleEndTimeUTC,
      this.flashSalePriceAmount,
      this.flashSalePriceHidden,
      this.flashSaleQuantity,
      this.id});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    productTypeId = json['ProductTypeId'];
    parentGroupedProductId = json['ParentGroupedProductId'];
    visibleIndividually = json['VisibleIndividually'];
    name = json['Name'];
    shortDescription = json['ShortDescription'];
    fullDescription = json['FullDescription'];
    homePageDescription = json['HomePageDescription'];
    productPolicy = json['ProductPolicy'];
    seoDescription = json['SeoDescription'];
    haveTradeIn = json['HaveTradeIn'];
    haveInstallment = json['HaveInstallment'];
    showOnAllCategory = json['ShowOnAllCategory'];
    adminComment = json['AdminComment'];
    productTemplateId = json['ProductTemplateId'];
    vendorId = json['VendorId'];
    showOnHomepage = json['ShowOnHomepage'];
    metaKeywords = json['MetaKeywords'];
    metaDescription = json['MetaDescription'];
    metaTitle = json['MetaTitle'];
    allowCustomerReviews = json['AllowCustomerReviews'];
    approvedRatingSum = json['ApprovedRatingSum'];
    notApprovedRatingSum = json['NotApprovedRatingSum'];
    approvedTotalReviews = json['ApprovedTotalReviews'];
    notApprovedTotalReviews = json['NotApprovedTotalReviews'];
    subjectToAcl = json['SubjectToAcl'];
    limitedToStores = json['LimitedToStores'];
    sku = json['Sku'];
    manufacturerPartNumber = json['ManufacturerPartNumber'];
    gtin = json['Gtin'];
    isGiftCard = json['IsGiftCard'];
    giftCardTypeId = json['GiftCardTypeId'];
    overriddenGiftCardAmount = json['OverriddenGiftCardAmount'];
    requireOtherProducts = json['RequireOtherProducts'];
    requiredProductIds = json['RequiredProductIds'];
    automaticallyAddRequiredProducts = json['AutomaticallyAddRequiredProducts'];
    isDownload = json['IsDownload'];
    downloadId = json['DownloadId'];
    unlimitedDownloads = json['UnlimitedDownloads'];
    maxNumberOfDownloads = json['MaxNumberOfDownloads'];
    downloadExpirationDays = json['DownloadExpirationDays'];
    downloadActivationTypeId = json['DownloadActivationTypeId'];
    hasSampleDownload = json['HasSampleDownload'];
    sampleDownloadId = json['SampleDownloadId'];
    hasUserAgreement = json['HasUserAgreement'];
    userAgreementText = json['UserAgreementText'];
    isRecurring = json['IsRecurring'];
    recurringCycleLength = json['RecurringCycleLength'];
    recurringCyclePeriodId = json['RecurringCyclePeriodId'];
    recurringTotalCycles = json['RecurringTotalCycles'];
    isRental = json['IsRental'];
    rentalPriceLength = json['RentalPriceLength'];
    rentalPricePeriodId = json['RentalPricePeriodId'];
    isShipEnabled = json['IsShipEnabled'];
    isFreeShipping = json['IsFreeShipping'];
    shipSeparately = json['ShipSeparately'];
    additionalShippingCharge = json['AdditionalShippingCharge'];
    deliveryDateId = json['DeliveryDateId'];
    isTaxExempt = json['IsTaxExempt'];
    taxCategoryId = json['TaxCategoryId'];
    isTelecommunicationsOrBroadcastingOrElectronicServices =
        json['IsTelecommunicationsOrBroadcastingOrElectronicServices'];
    manageInventoryMethodId = json['ManageInventoryMethodId'];
    productAvailabilityRangeId = json['ProductAvailabilityRangeId'];
    useMultipleWarehouses = json['UseMultipleWarehouses'];
    warehouseId = json['WarehouseId'];
    stockQuantity = json['StockQuantity'];
    displayStockAvailability = json['DisplayStockAvailability'];
    displayStockQuantity = json['DisplayStockQuantity'];
    minStockQuantity = json['MinStockQuantity'];
    lowStockActivityId = json['LowStockActivityId'];
    notifyAdminForQuantityBelow = json['NotifyAdminForQuantityBelow'];
    backorderModeId = json['BackorderModeId'];
    allowBackInStockSubscriptions = json['AllowBackInStockSubscriptions'];
    orderMinimumQuantity = json['OrderMinimumQuantity'];
    orderMaximumQuantity = json['OrderMaximumQuantity'];
    allowedQuantities = json['AllowedQuantities'];
    allowAddingOnlyExistingAttributeCombinations =
        json['AllowAddingOnlyExistingAttributeCombinations'];
    notReturnable = json['NotReturnable'];
    disableBuyButton = json['DisableBuyButton'];
    disableWishlistButton = json['DisableWishlistButton'];
    availableForPreOrder = json['AvailableForPreOrder'];
    preOrderAvailabilityStartDateTimeUtc =
        json['PreOrderAvailabilityStartDateTimeUtc'];
    callForPrice = json['CallForPrice'];
    price = json['Price'];
    oldPrice = json['OldPrice'];
    productCost = json['ProductCost'];
    customerEntersPrice = json['CustomerEntersPrice'];
    minimumCustomerEnteredPrice = json['MinimumCustomerEnteredPrice'];
    maximumCustomerEnteredPrice = json['MaximumCustomerEnteredPrice'];
    basepriceEnabled = json['BasepriceEnabled'];
    basepriceAmount = json['BasepriceAmount'];
    basepriceUnitId = json['BasepriceUnitId'];
    basepriceBaseAmount = json['BasepriceBaseAmount'];
    basepriceBaseUnitId = json['BasepriceBaseUnitId'];
    markAsNew = json['MarkAsNew'];
    markAsNewStartDateTimeUtc = json['MarkAsNewStartDateTimeUtc'];
    markAsNewEndDateTimeUtc = json['MarkAsNewEndDateTimeUtc'];
    hasTierPrices = json['HasTierPrices'];
    hasDiscountsApplied = json['HasDiscountsApplied'];
    weight = json['Weight'];
    length = json['Length'];
    width = json['Width'];
    height = json['Height'];
    availableStartDateTimeUtc = json['AvailableStartDateTimeUtc'];
    availableEndDateTimeUtc = json['AvailableEndDateTimeUtc'];
    displayOrder = json['DisplayOrder'];
    displayOrderInCategory = json['DisplayOrderInCategory'];
    published = json['Published'];
    deleted = json['Deleted'];
    createdOnUtc = json['CreatedOnUtc'];
    updatedOnUtc = json['UpdatedOnUtc'];
    productType = json['ProductType'];
    backorderMode = json['BackorderMode'];
    downloadActivationType = json['DownloadActivationType'];
    giftCardType = json['GiftCardType'];
    lowStockActivity = json['LowStockActivity'];
    manageInventoryMethod = json['ManageInventoryMethod'];
    recurringCyclePeriod = json['RecurringCyclePeriod'];
    rentalPricePeriod = json['RentalPricePeriod'];
    flashSale = json['FlashSale'];
    flashSaleStartTimeUTC = json['FlashSaleStartTimeUTC'];
    flashSaleEndTimeUTC = json['FlashSaleEndTimeUTC'];
    flashSalePriceAmount = json['FlashSalePriceAmount'];
    flashSalePriceHidden = json['FlashSalePriceHidden'];
    flashSaleQuantity = json['FlashSaleQuantity'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductTypeId'] = productTypeId;
    data['ParentGroupedProductId'] = parentGroupedProductId;
    data['VisibleIndividually'] = visibleIndividually;
    data['Name'] = name;
    data['ShortDescription'] = shortDescription;
    data['FullDescription'] = fullDescription;
    data['HomePageDescription'] = homePageDescription;
    data['ProductPolicy'] = productPolicy;
    data['SeoDescription'] = seoDescription;
    data['HaveTradeIn'] = haveTradeIn;
    data['HaveInstallment'] = haveInstallment;
    data['ShowOnAllCategory'] = showOnAllCategory;
    data['AdminComment'] = adminComment;
    data['ProductTemplateId'] = productTemplateId;
    data['VendorId'] = vendorId;
    data['ShowOnHomepage'] = showOnHomepage;
    data['MetaKeywords'] = metaKeywords;
    data['MetaDescription'] = metaDescription;
    data['MetaTitle'] = metaTitle;
    data['AllowCustomerReviews'] = allowCustomerReviews;
    data['ApprovedRatingSum'] = approvedRatingSum;
    data['NotApprovedRatingSum'] = notApprovedRatingSum;
    data['ApprovedTotalReviews'] = approvedTotalReviews;
    data['NotApprovedTotalReviews'] = notApprovedTotalReviews;
    data['SubjectToAcl'] = subjectToAcl;
    data['LimitedToStores'] = limitedToStores;
    data['Sku'] = sku;
    data['ManufacturerPartNumber'] = manufacturerPartNumber;
    data['Gtin'] = gtin;
    data['IsGiftCard'] = isGiftCard;
    data['GiftCardTypeId'] = giftCardTypeId;
    data['OverriddenGiftCardAmount'] = overriddenGiftCardAmount;
    data['RequireOtherProducts'] = requireOtherProducts;
    data['RequiredProductIds'] = requiredProductIds;
    data['AutomaticallyAddRequiredProducts'] = automaticallyAddRequiredProducts;
    data['IsDownload'] = isDownload;
    data['DownloadId'] = downloadId;
    data['UnlimitedDownloads'] = unlimitedDownloads;
    data['MaxNumberOfDownloads'] = maxNumberOfDownloads;
    data['DownloadExpirationDays'] = downloadExpirationDays;
    data['DownloadActivationTypeId'] = downloadActivationTypeId;
    data['HasSampleDownload'] = hasSampleDownload;
    data['SampleDownloadId'] = sampleDownloadId;
    data['HasUserAgreement'] = hasUserAgreement;
    data['UserAgreementText'] = userAgreementText;
    data['IsRecurring'] = isRecurring;
    data['RecurringCycleLength'] = recurringCycleLength;
    data['RecurringCyclePeriodId'] = recurringCyclePeriodId;
    data['RecurringTotalCycles'] = recurringTotalCycles;
    data['IsRental'] = isRental;
    data['RentalPriceLength'] = rentalPriceLength;
    data['RentalPricePeriodId'] = rentalPricePeriodId;
    data['IsShipEnabled'] = isShipEnabled;
    data['IsFreeShipping'] = isFreeShipping;
    data['ShipSeparately'] = shipSeparately;
    data['AdditionalShippingCharge'] = additionalShippingCharge;
    data['DeliveryDateId'] = deliveryDateId;
    data['IsTaxExempt'] = isTaxExempt;
    data['TaxCategoryId'] = taxCategoryId;
    data['IsTelecommunicationsOrBroadcastingOrElectronicServices'] =
        isTelecommunicationsOrBroadcastingOrElectronicServices;
    data['ManageInventoryMethodId'] = manageInventoryMethodId;
    data['ProductAvailabilityRangeId'] = productAvailabilityRangeId;
    data['UseMultipleWarehouses'] = useMultipleWarehouses;
    data['WarehouseId'] = warehouseId;
    data['StockQuantity'] = stockQuantity;
    data['DisplayStockAvailability'] = displayStockAvailability;
    data['DisplayStockQuantity'] = displayStockQuantity;
    data['MinStockQuantity'] = minStockQuantity;
    data['LowStockActivityId'] = lowStockActivityId;
    data['NotifyAdminForQuantityBelow'] = notifyAdminForQuantityBelow;
    data['BackorderModeId'] = backorderModeId;
    data['AllowBackInStockSubscriptions'] = allowBackInStockSubscriptions;
    data['OrderMinimumQuantity'] = orderMinimumQuantity;
    data['OrderMaximumQuantity'] = orderMaximumQuantity;
    data['AllowedQuantities'] = allowedQuantities;
    data['AllowAddingOnlyExistingAttributeCombinations'] =
        allowAddingOnlyExistingAttributeCombinations;
    data['NotReturnable'] = notReturnable;
    data['DisableBuyButton'] = disableBuyButton;
    data['DisableWishlistButton'] = disableWishlistButton;
    data['AvailableForPreOrder'] = availableForPreOrder;
    data['PreOrderAvailabilityStartDateTimeUtc'] =
        preOrderAvailabilityStartDateTimeUtc;
    data['CallForPrice'] = callForPrice;
    data['Price'] = price;
    data['OldPrice'] = oldPrice;
    data['ProductCost'] = productCost;
    data['CustomerEntersPrice'] = customerEntersPrice;
    data['MinimumCustomerEnteredPrice'] = minimumCustomerEnteredPrice;
    data['MaximumCustomerEnteredPrice'] = maximumCustomerEnteredPrice;
    data['BasepriceEnabled'] = basepriceEnabled;
    data['BasepriceAmount'] = basepriceAmount;
    data['BasepriceUnitId'] = basepriceUnitId;
    data['BasepriceBaseAmount'] = basepriceBaseAmount;
    data['BasepriceBaseUnitId'] = basepriceBaseUnitId;
    data['MarkAsNew'] = markAsNew;
    data['MarkAsNewStartDateTimeUtc'] = markAsNewStartDateTimeUtc;
    data['MarkAsNewEndDateTimeUtc'] = markAsNewEndDateTimeUtc;
    data['HasTierPrices'] = hasTierPrices;
    data['HasDiscountsApplied'] = hasDiscountsApplied;
    data['Weight'] = weight;
    data['Length'] = length;
    data['Width'] = width;
    data['Height'] = height;
    data['AvailableStartDateTimeUtc'] = availableStartDateTimeUtc;
    data['AvailableEndDateTimeUtc'] = availableEndDateTimeUtc;
    data['DisplayOrder'] = displayOrder;
    data['DisplayOrderInCategory'] = displayOrderInCategory;
    data['Published'] = published;
    data['Deleted'] = deleted;
    data['CreatedOnUtc'] = createdOnUtc;
    data['UpdatedOnUtc'] = updatedOnUtc;
    data['ProductType'] = productType;
    data['BackorderMode'] = backorderMode;
    data['DownloadActivationType'] = downloadActivationType;
    data['GiftCardType'] = giftCardType;
    data['LowStockActivity'] = lowStockActivity;
    data['ManageInventoryMethod'] = manageInventoryMethod;
    data['RecurringCyclePeriod'] = recurringCyclePeriod;
    data['RentalPricePeriod'] = rentalPricePeriod;
    data['FlashSale'] = flashSale;
    data['FlashSaleStartTimeUTC'] = flashSaleStartTimeUTC;
    data['FlashSaleEndTimeUTC'] = flashSaleEndTimeUTC;
    data['FlashSalePriceAmount'] = flashSalePriceAmount;
    data['FlashSalePriceHidden'] = flashSalePriceHidden;
    data['FlashSaleQuantity'] = flashSaleQuantity;
    data['Id'] = id;
    return data;
  }
}
