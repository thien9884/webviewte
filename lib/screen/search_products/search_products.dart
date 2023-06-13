import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/search_products/search_products_bloc.dart';
import 'package:webviewtest/blocs/search_products/search_products_event.dart';
import 'package:webviewtest/blocs/search_products/search_products_state.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/common/custom_material_page_route.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/constant.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/model/search_products/search_products_model.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';
import 'dart:io' show Platform;

class SearchProductsScreen extends StatefulWidget {
  final String? keySearch;

  const SearchProductsScreen({this.keySearch, Key? key}) : super(key: key);

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  String _sortBy = ListCustom.listSortProduct[0].name;
  CatalogProductsModel catalogProductsModel = CatalogProductsModel();
  final List<ProductsModel> _listAllProduct = [];
  final List<ProductsModel> _listSearchProduct = [];
  var priceFormat = NumberFormat.decimalPattern('vi_VN');
  int _pagesSelected = 0;
  String _keySearch = '';
  late TextEditingController _searchController;
  final ScrollController _pageScrollController = ScrollController();
  final dataKey = GlobalKey();
  Widget? _widget;

  _getFirstSearchResult() {
    EasyLoading.show();
    BlocProvider.of<SearchProductsBloc>(context).add(
      RequestGetSearchProductResult(1, _keySearch),
    );
  }

  @override
  void initState() {
    _keySearch = widget.keySearch ?? '';
    _searchController = TextEditingController(text: _keySearch);
    _getFirstSearchResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchProductsBloc, SearchProductsState>(
        builder: (context, state) => _buildUI(),
        listener: (context, state) {
          if (state is SearchProductsLoading) {
            EasyLoading.show();
          } else if (state is SearchProductsLoaded) {
            catalogProductsModel = CatalogProductsModel();
            _listAllProduct.clear();
            _listSearchProduct.clear();
            catalogProductsModel = state.catalogProductsModel;
            _listAllProduct.addAll(catalogProductsModel.products ?? []);
            _listSearchProduct.addAll(catalogProductsModel.products ?? []);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is SearchProductsLoadError) {
            if (EasyLoading.isShow) EasyLoading.dismiss();
            _widget = Center(
              child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NavigationScreen(
                            isSelected: 0,
                          ))),
                  child: Text(
                    'Trở về trang chủ',
                    style: CommonStyles.size15W400Black1D(context),
                  )),
            );
          }
        });
  }

  // build UI
  Widget _buildUI() {
    return CommonNavigateBar(
      index: 0,
      child: _listAllProduct.isEmpty
          ? _widget ?? Container()
          : Container(
        color: const Color(0xfff5f5f7),
        child: CustomScrollView(
          slivers: [
            _searchProducts(),
            _sortListProduct(),
            _listProduct(_listAllProduct),
            if (catalogProductsModel.totalPages != null)
              _pagesNumber(),
          ],
        ),
      ),
    );
  }

  // news scroll bar
  Widget _searchProducts() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Tìm kiếm',
              style: CommonStyles.size24W700Black1D(context),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tìm từ khoá:',
                  style: CommonStyles.size15W400Black1D(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xffEBEBEB),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xff0066CC),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xffEBEBEB),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabled: true,
                    ),
                    onFieldSubmitted: (value) {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                        BlocProvider.of<SearchProductsBloc>(context).add(
                          RequestGetSearchProductResult(
                            1,
                            _searchController.text,
                          ),
                        );
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 160,
                        child: CommonButton(
                          title: 'Tìm kiếm',
                          onTap: () {
                            setState(() {
                              FocusManager.instance.primaryFocus?.unfocus();
                              BlocProvider.of<SearchProductsBloc>(context).add(
                                RequestGetSearchProductResult(
                                  1,
                                  _searchController.text,
                                ),
                              );
                            });
                          },
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // sort list product
  Widget _sortListProduct() {
    return SliverToBoxAdapter(
      key: dataKey,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          _listAllProduct.addAll(_listSearchProduct);
                          break;
                        case Constant.price91:
                          _listAllProduct.sort((a, b) =>
                              a.productPrice!.priceValue!.compareTo(
                                  b.productPrice!.priceValue!.toDouble()));
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
                              b.productPrice!.priceValue!.compareTo(
                                  a.productPrice!.priceValue!.toDouble()));
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

  // list product
  Widget _listProduct(List<ProductsModel> listProduct) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: listProduct.length,
              (context, index) {
            var item = listProduct[index];

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
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(
                          top: Responsive.isMobile(context) ? 5 : 10,
                          right: Responsive.isMobile(context) ? 5 : 10),
                      child: item.productTags!.isNotEmpty
                          ? Image.network(
                        "https://api.shopdunk.com/images/uploaded/icon/${item.productTags?.first.seName}.png",
                        height: 25,
                        fit: BoxFit.cover,
                      )
                          : const SizedBox(
                        height: 25,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Responsive.isMobile(context) ? 4 : 8),
                      child: Image.network(
                          item.defaultPictureModel?.imageUrl ?? ''),
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
                                Expanded(
                                  flex: 9,
                                  child: Text(
                                    '${priceFormat.format(item.productPrice?.priceValue ?? 0)}₫',
                                    style:
                                    CommonStyles.size13W700Blue00(context),
                                  ),
                                ),
                                Flexible(
                                  flex: 8,
                                  child: Text(
                                    '${priceFormat.format(item.productPrice?.oldPriceValue ?? item.productPrice?.priceValue)}₫',
                                    style:
                                    CommonStyles.size10W400Grey86(context)
                                        .copyWith(
                                        decoration:
                                        TextDecoration.lineThrough),
                                  ),
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
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: SizedBox(
            height: 35,
            width: catalogProductsModel.totalPages! > 4
                ? double.infinity
                : 35 * (catalogProductsModel.totalPages! + 1) + 25,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_pagesSelected != 0) {
                      setState(() {
                        _pagesSelected = 0;
                        BlocProvider.of<SearchProductsBloc>(context).add(
                          RequestGetSearchProductResult(
                            1,
                            _searchController.text,
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
                  child: ListView.builder(
                    controller: _pageScrollController,
                    itemCount: catalogProductsModel.totalPages,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => setState(() {
                        _pagesSelected = index;
                        BlocProvider.of<SearchProductsBloc>(context).add(
                          RequestGetSearchProductResult(
                              index + 1, _searchController.text),
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
                GestureDetector(
                  onTap: () {
                    if (catalogProductsModel.totalPages != null &&
                        _pagesSelected !=
                            catalogProductsModel.totalPages! - 1) {
                      setState(() {
                        _pagesSelected = catalogProductsModel.totalPages! - 1;
                        BlocProvider.of<SearchProductsBloc>(context).add(
                          RequestGetSearchProductResult(
                            catalogProductsModel.totalPages,
                            _searchController.text,
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
}
