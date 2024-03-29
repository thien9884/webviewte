import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_state.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/common/custom_material_page_route.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/constant.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/category_model/category_group_model.dart';
import 'package:webviewtest/model/subcategory/subcategory_model.dart';
import 'package:webviewtest/screen/home/home_page_screen.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';
import 'dart:io' show Platform;

class CategoryScreen extends StatefulWidget {
  final String title;
  final String desc;
  final String descAccessories;
  final String seName;
  final int? groupId;

  const CategoryScreen({
    required this.title,
    required this.desc,
    required this.descAccessories,
    required this.seName,
    required this.groupId,
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _indexSelected = 0;
  int _pagesSelected = 0;
  int _categorySelected = 0;
  var priceFormat = NumberFormat.decimalPattern('vi_VN');
  bool _isExpand = false;
  String _sortBy = ListCustom.listSortProduct[0].name;
  final List<ProductCategoryModel> _listAllProduct = [];
  final List<ProductCategoryModel> _listSortProduct = [];
  List<String> _listImage = [];
  CategoryGroupModel _categoryGroupModel = CategoryGroupModel();
  final dataKey = GlobalKey();
  final ScrollController _pageScrollController = ScrollController();
  late ScrollController _hideButtonController;
  int? _groupId;
  String _desc = '';
  String _seName = '';
  String _categoryTitle = "";
  String _categoryBanner = '';
  final List<TopBanner> _listCategoryBannerImg = [];
  final List<SubCategories> _listSubCategories = [];
  final ScrollController _scrollController = ScrollController();

  bool _isVisible = false;

  _getListProducts() async {
    BlocProvider.of<ShopdunkBloc>(context)
        .add(RequestGetProductsCategory(_groupId, 1));
  }

  _getListSubCategories() async {
    BlocProvider.of<ShopdunkBloc>(context).add(RequestGetSubCategory(_groupId));
  }

  _getListBanner() async {
    switch (_seName) {
      case 'ipad':
        BlocProvider.of<ShopdunkBloc>(context)
            .add(const RequestGetCategoryBanner(57));
        break;
      case 'iphone':
        BlocProvider.of<ShopdunkBloc>(context)
            .add(const RequestGetCategoryBanner(41));
        break;
      case 'mac':
        BlocProvider.of<ShopdunkBloc>(context)
            .add(const RequestGetCategoryBanner(58));
        break;
      case 'apple-watch':
        BlocProvider.of<ShopdunkBloc>(context)
            .add(const RequestGetCategoryBanner(59));
        break;
      case 'am-thanh':
        BlocProvider.of<ShopdunkBloc>(context)
            .add(const RequestGetCategoryBanner(60));
        break;
      case 'phu-kien':
        BlocProvider.of<ShopdunkBloc>(context)
            .add(const RequestGetCategoryBanner(61));
        break;
    }
  }

  _getImage() {
    switch (widget.seName) {
      case 'iphone':
        _listImage = [
          'https://shopdunk.com/images/uploaded/trang danh muc/iphone/Image-Standard-1.png',
          'https://shopdunk.com/images/uploaded/trang danh muc/iphone/Image-Standard.png'
        ];
        break;
      case 'ipad':
        _listImage = [
          'https://shopdunk.com/images/uploaded/trang danh muc/ipad/Image-Standard-3.png',
          'https://shopdunk.com/images/uploaded/trang danh muc/ipad/Image-Standard-2.png'
        ];
        break;
      case 'mac':
        _listImage = [
          'https://shopdunk.com/images/uploaded/trang danh muc/mac/Image-Standard-5.png',
          'https://shopdunk.com/images/uploaded/trang danh muc/mac/Image-Standard-4.png'
        ];
        break;
      case 'apple-watch':
        _listImage = [
          'https://shopdunk.com/images/uploaded/trang danh muc/watch/Image-Standard-7.png',
          'https://shopdunk.com/images/uploaded/trang danh muc/watch/Image-Standard-6.png'
        ];
        break;
    }
  }

  _getHideBottomValue() {
    _isVisible = true;
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
            BlocProvider.of<ShopdunkBloc>(context)
                .add(RequestGetHideBottom(_isVisible));
          });
        }
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible) {
          setState(() {
            _isVisible = true;
            BlocProvider.of<ShopdunkBloc>(context)
                .add(RequestGetHideBottom(_isVisible));
          });
        }
      }
    });
  }

  @override
  void initState() {
    _categoryTitle = widget.title;
    _groupId = widget.groupId;
    _desc = widget.desc;
    _seName = widget.seName;
    _getListProducts();
    _getListSubCategories();
    _getListBanner();
    _getHideBottomValue();
    _getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopdunkBloc, ShopdunkState>(
        builder: (context, state) => _buildCategoryUI(),
        listener: (context, state) {
          if (state is ProductsCategoryLoading) {
            EasyLoading.show();
          } else if (state is ProductsCategoryLoaded) {
            _listAllProduct.clear();
            _listSortProduct.clear();
            _categoryGroupModel = state.categoryGroupModel;
            _listAllProduct.addAll(state
                .categoryGroupModel.productCategoryModel!
                .where((element) => element.showOnHomePage == true)
                .toList());
            _listSortProduct.addAll(state
                .categoryGroupModel.productCategoryModel!
                .where((element) => element.showOnHomePage == true)
                .toList());
            _listAllProduct.sort(
                (a, b) => a.displayOrder!.compareTo(b.displayOrder!.toInt()));
            _listSortProduct.sort(
                (a, b) => a.displayOrder!.compareTo(b.displayOrder!.toInt()));
            print(_listSortProduct);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is ProductsCategoryLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is CategoryBannerLoading) {
            EasyLoading.show();
          } else if (state is CategoryBannerLoaded) {
            _categoryBanner = state.listTopics.topics?.first.body ?? '';
            var document = parse(
              _categoryBanner.replaceAll('src="', 'src="http://shopdunk.com'),
            );
            var imgList = document.querySelectorAll("img");
            var linkList = document.querySelectorAll("a");
            List<String> imageList = [];
            List<String> getLinkList = [];
            List<TopBanner> homeBanner = [];
            for (dom.Element img in imgList) {
              imageList.add(img.attributes['src']!);
            }
            for (dom.Element img in linkList) {
              getLinkList.add(img.attributes['href']!);
            }
            for (int i = 0; i < imageList.length; i++) {
              homeBanner.add(
                TopBanner(
                  img: imageList[i],
                ),
              );
            }
            _listCategoryBannerImg.clear();
            _listCategoryBannerImg.addAll(homeBanner);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is CategoryBannerLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is SubCategoryLoading) {
            EasyLoading.show();
          } else if (state is SubCategoryLoaded) {
            _listSubCategories.clear();
            _listSubCategories.addAll(state.subCategory ?? []);
            _listSubCategories.insert(
              0,
              SubCategories(
                name: 'Tất cả',
                id: widget.groupId,
              ),
            );

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is SubCategoryLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  // build category UI
  Widget _buildCategoryUI() {
    return CommonNavigateBar(
        index: 0,
        child: _categoryGroupModel.productCategoryModel != null
            ? Container(
                color: const Color(0xfff5f5f7),
                child: CustomScrollView(
                  controller: _hideButtonController,
                  slivers: [
                    if (_listCategoryBannerImg.isNotEmpty) _pageView(),
                    _listCategoryScrollBar(),
                    _sortListProduct(),
                    _tittle(),
                    _listProduct(),
                    if (_categoryGroupModel.total != null &&
                        _categoryGroupModel.total! > 8)
                      _pagesNumber(),
                    widget.title.toLowerCase() != 'âm thanh' &&
                            widget.title.toLowerCase() != 'phụ kiện'
                        ? _relatedProducts()
                        : const SliverToBoxAdapter(),
                    _description(),
                  ],
                ),
              )
            : Container());
  }

  // page view
  Widget _pageView() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: double.infinity,
        child: Stack(
          children: [
            PageView.builder(
              physics: _listCategoryBannerImg.length == 1
                  ? const NeverScrollableScrollPhysics()
                  : null,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                if (_listCategoryBannerImg.length > 1) {
                  setState(() {
                    _indexSelected = index % _listCategoryBannerImg.length;
                  });
                }
              },
              itemBuilder: (context, index) {
                final item = _listCategoryBannerImg[
                    index % _listCategoryBannerImg.length];

                return GestureDetector(
                  // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => ShopDunkWebView(
                  //           baseUrl: item.link,
                  //         ))),
                  child: SizedBox(
                    child: Image.network(
                      item.img ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            if (_listCategoryBannerImg.length > 1)
              Positioned(
                bottom: 20,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        _listCategoryBannerImg.length,
                        (index) => Container(
                              height: Responsive.isMobile(context) ? 10 : 15,
                              width: Responsive.isMobile(context) ? 10 : 15,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: _indexSelected == index
                                      ? const Color(0xff4AB2F1).withOpacity(0.5)
                                      : const Color(0xff515154)
                                          .withOpacity(0.5),
                                  shape: BoxShape.circle),
                            )),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  // news scroll bar
  Widget _listCategoryScrollBar() {
    return SliverToBoxAdapter(
      key: dataKey,
      child: SizedBox(
        height: 70,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _listSubCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = _listSubCategories[index];

            return GestureDetector(
              onTap: () {
                setState(() {
                  _categorySelected = index;
                  BlocProvider.of<ShopdunkBloc>(context)
                      .add(RequestGetProductsCategory(item.id, 1));
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _categorySelected == index
                        ? const Color(0xff0066CC)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
                child: Center(
                  child: Text(
                    item.name ?? '',
                    style: _categorySelected == index
                        ? CommonStyles.size15W700White(context)
                        : CommonStyles.size15W400Grey51(context),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // sort list product
  Widget _sortListProduct() {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xffEBEBEB), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _sortBy,
                  menuMaxHeight: 300,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  elevation: 16,
                  isDense: true,
                  style: CommonStyles.size14W400Black1D(context),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _sortBy = value!;

                      switch (value) {
                        case Constant.sttDefault:
                          _listAllProduct.clear();
                          _listAllProduct.addAll(_listSortProduct);
                          break;
                        case Constant.price91:
                          _listAllProduct.sort((a, b) =>
                              a.price!.compareTo(b.price!.toDouble()));
                          break;
                        case Constant.newest:
                          break;
                        case Constant.nameAZ:
                          _listAllProduct.sort((a, b) => a.name!
                              .toLowerCase()
                              .compareTo(b.name!.toLowerCase()));
                          break;
                        case Constant.nameZA:
                          _listAllProduct.sort((a, b) => b.name!
                              .toLowerCase()
                              .compareTo(a.name!.toLowerCase()));
                          break;
                        case Constant.price19:
                          _listAllProduct.sort((a, b) =>
                              b.price!.compareTo(a.price!.toDouble()));
                          break;
                        default:
                          _listAllProduct;
                          break;
                      }
                    });
                  },
                  items:
                      List.generate(ListCustom.listSortProduct.length, (index) {
                    final item = ListCustom.listSortProduct[index];
                    return DropdownMenuItem<String>(
                      value: item.name,
                      child: Text(item.name),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // title
  Widget _tittle() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            _categoryTitle,
            style: CommonStyles.size24W700Black1D(context),
          ),
        ),
      ),
    );
  }

  // list product
  Widget _listProduct() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: _listAllProduct.length,
          (context, index) {
            var item = _listAllProduct[index];

            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                CustomMaterialPageRoute(
                  builder: (context) => ShopDunkWebView(
                    url: 'app-${item.seName}',
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   margin: EdgeInsets.only(
                    //       top: Responsive.isMobile(context) ? 5 : 10,
                    //       right: Responsive.isMobile(context) ? 5 : 10),
                    //   child: item.productTags != null && item.productTags!.isNotEmpty
                    //       ? Image.network(
                    //           "https://shopdunk.com/images/uploaded/icon/${item.productTags?.first.seName}.png",
                    //           height: 25,
                    //           fit: BoxFit.cover,
                    //           errorBuilder: (context, obj, trace) =>
                    //               const SizedBox(
                    //             height: 25,
                    //           ),
                    //         )
                    //       : const SizedBox(
                    //           height: 25,
                    //         ),
                    // ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Responsive.isMobile(context) ? 4 : 8),
                      child: Image.network(
                        item.images?.first.src ?? '',
                        height: 170,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Text(
                                item.name ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: CommonStyles.size16W700Black1D(context)
                                    .copyWith(
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${priceFormat.format(item.price ?? 0)}₫',
                                  style: CommonStyles.size13W700Blue00(context),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '${priceFormat.format(item.oldPrice ?? item.price)}₫',
                                  style: CommonStyles.size10W400Grey86(context)
                                      .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: Responsive.isMobile(context) ? 200 : 300,
          mainAxisSpacing: Responsive.isMobile(context) ? 10 : 20,
          crossAxisSpacing: Responsive.isMobile(context) ? 10 : 20,
          mainAxisExtent: Platform.isIOS ? 320 : 300,
        ),
      ),
    );
  }

  // pages number
  Widget _pagesNumber() {
    var totalPage = (_categoryGroupModel.total! / 8).ceil();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: SizedBox(
            height: 35,
            width: totalPage > 6 ? double.infinity : 35 * (totalPage + 1) + 25,
            child: Row(
              children: [
                if (totalPage > 6 && _pagesSelected >= 5)
                  GestureDetector(
                    onTap: () {
                      if (_pagesSelected != 0) {
                        setState(() {
                          _pagesSelected = 0;
                          BlocProvider.of<ShopdunkBloc>(context).add(
                            RequestGetProductsCategory(
                              _groupId,
                              1,
                            ),
                          );
                          _pageScrollController.animateTo(
                            _pageScrollController.position.minScrollExtent,
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                          );
                          Scrollable.ensureVisible(dataKey.currentContext!);
                        });
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 14,
                        color: Color(0xff1D1D1D),
                      ),
                    ),
                  ),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _pageScrollController,
                      itemCount: totalPage,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => setState(() {
                          _pagesSelected = index;
                          BlocProvider.of<ShopdunkBloc>(context).add(
                            RequestGetProductsCategory(_groupId, index + 1),
                          );
                          Scrollable.ensureVisible(dataKey.currentContext!);
                        }),
                        child: Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: _pagesSelected == index
                                ? Colors.blueAccent
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            (index + 1).toString(),
                            style: _pagesSelected == index
                                ? CommonStyles.size14W400White(context)
                                : CommonStyles.size14W400Black1D(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (totalPage > 6 &&
                    _pagesSelected <=
                        (_categoryGroupModel.productCategoryModel!.length - 5))
                  GestureDetector(
                    onTap: () {
                      if (_categoryGroupModel.total != null &&
                          _pagesSelected != totalPage - 1) {
                        setState(() {
                          _pagesSelected = totalPage - 1;
                          BlocProvider.of<ShopdunkBloc>(context).add(
                            RequestGetProductsCategory(
                              _groupId,
                              totalPage,
                            ),
                          );
                          _pageScrollController.animateTo(
                            _pageScrollController.position.maxScrollExtent,
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                          );
                          Scrollable.ensureVisible(dataKey.currentContext!);
                        });
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Color(0xff1D1D1D),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // related products
  Widget _relatedProducts() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: List.generate(2, (index) => _relatedItems(index)),
        ),
      ),
    );
  }

  // related Items
  Widget _relatedItems(int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          setState(() {
            _categoryTitle = "Accessories";
            _groupId = 15;
            _desc = widget.descAccessories;
            BlocProvider.of<ShopdunkBloc>(context)
                .add(const RequestGetCategoryBanner(61));
            BlocProvider.of<ShopdunkBloc>(context)
                .add(const RequestGetProductsCategory(15, 1));
            Scrollable.ensureVisible(dataKey.currentContext!);
          });
        } else {
          Navigator.of(context).push(CustomMaterialPageRoute(
              builder: (context) => const ShopDunkWebView(
                    url: 'compareproducts',
                  )));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.network(
              _listImage[index],
              width: 139,
              height: 121,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      index == 0
                          ? 'Phụ kiện ${widget.title} thường mua đi kèm'
                          : 'Tìm ${widget.title} phù hợp với bạn',
                      style: CommonStyles.size18W700Black1D(context),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        index == 0
                            ? 'Tìm phụ kiện'
                            : 'So sánh các ${widget.title}',
                        style: CommonStyles.size14W400Blue00(context),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xff0066CC),
                        size: 14,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // description
  Widget _description() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            HtmlWidget(
              _isExpand
                  ? _desc
                  : _desc.substring(0, 3000).replaceRange(3000, 3000, '...'),
              textStyle: const TextStyle(fontSize: 16, height: 1.3),
              onTapUrl: (st) {
                print('object');
                return true;
              },
              customStylesBuilder: (element) {
                if (element.localName == 'p') {
                  return {'color': '#777', 'text-align': 'justify'};
                }
                if (element.localName == 'span') {
                  return {'color': '#777', 'text-align': 'justify'};
                }
                if (element.localName == 'ul') {
                  return {'color': '#777', 'text-align': 'justify'};
                }
                if (element.localName == 'h2') {
                  return {'font-weight': '500'};
                }
                if (element.localName == 'a') {
                  return {'color': '#0000ff'};
                }
                return null;
              },
            ),
            GestureDetector(
                onTap: () => setState(() => _isExpand = !_isExpand),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isExpand ? 'Thu gọn' : 'Xem thêm',
                        style: CommonStyles.size14W400Blue00(context),
                      ),
                      Icon(
                        _isExpand
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: const Color(0xff0066CC),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
