class MyRankModel {
  List<RewardPoints>? rewardPoints;
  PagerModel? pagerModel;
  int? rewardPointsBalance;
  String? rewardPointsAmount;
  int? minimumRewardPointsBalance;
  String? minimumRewardPointsAmount;

  MyRankModel({
    this.rewardPoints,
    this.pagerModel,
    this.rewardPointsBalance,
    this.rewardPointsAmount,
    this.minimumRewardPointsBalance,
    this.minimumRewardPointsAmount,
  });

  MyRankModel.fromJson(Map<String, dynamic> json) {
    if (json['RewardPoints'] != null) {
      rewardPoints = <RewardPoints>[];
      json['RewardPoints'].forEach((v) {
        rewardPoints!.add(RewardPoints.fromJson(v));
      });
    }
    pagerModel = json['PagerModel'] != null
        ? PagerModel.fromJson(json['PagerModel'])
        : null;
    rewardPointsBalance = json['RewardPointsBalance'];
    rewardPointsAmount = json['RewardPointsAmount'];
    minimumRewardPointsBalance = json['MinimumRewardPointsBalance'];
    minimumRewardPointsAmount = json['MinimumRewardPointsAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rewardPoints != null) {
      data['RewardPoints'] = rewardPoints!.map((v) => v.toJson()).toList();
    }
    if (pagerModel != null) {
      data['PagerModel'] = pagerModel!.toJson();
    }
    data['RewardPointsBalance'] = rewardPointsBalance;
    data['RewardPointsAmount'] = rewardPointsAmount;
    data['MinimumRewardPointsBalance'] = minimumRewardPointsBalance;
    data['MinimumRewardPointsAmount'] = minimumRewardPointsAmount;
    return data;
  }
}

class RewardPoints {
  int? points;
  String? pointsBalance;
  String? message;
  String? createdOn;
  String? endDate;
  int? id;

  RewardPoints({
    this.points,
    this.pointsBalance,
    this.message,
    this.createdOn,
    this.endDate,
    this.id,
  });

  RewardPoints.fromJson(Map<String, dynamic> json) {
    points = json['Points'];
    pointsBalance = json['PointsBalance'];
    message = json['Message'];
    createdOn = json['CreatedOn'];
    endDate = json['EndDate'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Points'] = points;
    data['PointsBalance'] = pointsBalance;
    data['Message'] = message;
    data['CreatedOn'] = createdOn;
    data['EndDate'] = endDate;
    data['Id'] = id;
    return data;
  }
}

class PagerModel {
  int? currentPage;
  int? individualPagesDisplayedCount;
  int? pageIndex;
  int? pageSize;
  bool? showFirst;
  bool? showIndividualPages;
  bool? showLast;
  bool? showNext;
  bool? showPagerItems;
  bool? showPrevious;
  bool? showTotalSummary;
  int? totalPages;
  int? totalRecords;
  String? routeActionName;
  bool? useRouteLinks;
  RouteValues? routeValues;

  PagerModel({
    this.currentPage,
    this.individualPagesDisplayedCount,
    this.pageIndex,
    this.pageSize,
    this.showFirst,
    this.showIndividualPages,
    this.showLast,
    this.showNext,
    this.showPagerItems,
    this.showPrevious,
    this.showTotalSummary,
    this.totalPages,
    this.totalRecords,
    this.routeActionName,
    this.useRouteLinks,
    this.routeValues,
  });

  PagerModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['CurrentPage'];
    individualPagesDisplayedCount = json['IndividualPagesDisplayedCount'];
    pageIndex = json['PageIndex'];
    pageSize = json['PageSize'];
    showFirst = json['ShowFirst'];
    showIndividualPages = json['ShowIndividualPages'];
    showLast = json['ShowLast'];
    showNext = json['ShowNext'];
    showPagerItems = json['ShowPagerItems'];
    showPrevious = json['ShowPrevious'];
    showTotalSummary = json['ShowTotalSummary'];
    totalPages = json['TotalPages'];
    totalRecords = json['TotalRecords'];
    routeActionName = json['RouteActionName'];
    useRouteLinks = json['UseRouteLinks'];
    routeValues = json['RouteValues'] != null
        ? RouteValues.fromJson(json['RouteValues'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CurrentPage'] = currentPage;
    data['IndividualPagesDisplayedCount'] = individualPagesDisplayedCount;
    data['PageIndex'] = pageIndex;
    data['PageSize'] = pageSize;
    data['ShowFirst'] = showFirst;
    data['ShowIndividualPages'] = showIndividualPages;
    data['ShowLast'] = showLast;
    data['ShowNext'] = showNext;
    data['ShowPagerItems'] = showPagerItems;
    data['ShowPrevious'] = showPrevious;
    data['ShowTotalSummary'] = showTotalSummary;
    data['TotalPages'] = totalPages;
    data['TotalRecords'] = totalRecords;
    data['RouteActionName'] = routeActionName;
    data['UseRouteLinks'] = useRouteLinks;
    if (routeValues != null) {
      data['RouteValues'] = routeValues!.toJson();
    }
    return data;
  }
}

class RouteValues {
  int? pageNumber;

  RouteValues({this.pageNumber});

  RouteValues.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageNumber'] = pageNumber;
    return data;
  }
}
