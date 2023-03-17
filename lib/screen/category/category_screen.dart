import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/constant.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class CategoryScreen extends StatefulWidget {
  final String title;
  final String desc;
  final List<ProductsModel> allProduct;

  const CategoryScreen(
      {required this.title,
      required this.desc,
      required this.allProduct,
      Key? key})
      : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _indexSelected = 0;
  final TextEditingController _emailController = TextEditingController();
  var priceFormat = NumberFormat.decimalPattern('vi_VN');
  bool _isExpand = false;
  String _sortBy = ListCustom.listSortProduct[0].name;
  List<ProductsModel> _listAllProduct = [];

  @override
  void initState() {
    _listAllProduct.addAll(widget.allProduct);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff5f5f7),
      child: CustomScrollView(
        slivers: [
          _pageView(),
          _scrollBar(),
          _sortListProduct(),
          _tittle(widget.title),
          _listProduct(_listAllProduct),
          _description(widget.desc),
          _receiveInfo(),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 1, (context, index) => const CommonFooter())),
        ],
      ),
    );
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
              onPageChanged: (value) {
                setState(() {
                  _indexSelected = value % ListCustom.listIcon.length;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/news_banner.jpeg',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      tileMode: TileMode.clamp,
                    )),
                  ),
                );
              },
            ),
            Positioned(
                bottom: 20,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                'TRÒ CHƠI “ÔM CÀNG LÂU, ƯU ĐÃI CÀNG SÂU” SHOPDUNK THU HÚT PHỐ ĐI BỘ HÀ NỘI',
                                style: CommonStyles.size18W700White(context),
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              ListCustom.listIcon.length,
                              (index) => Container(
                                    height:
                                        Responsive.isMobile(context) ? 10 : 15,
                                    width:
                                        Responsive.isMobile(context) ? 10 : 15,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: _indexSelected == index
                                            ? const Color(0xff4AB2F1)
                                                .withOpacity(0.5)
                                            : const Color(0xff515154)
                                                .withOpacity(0.5),
                                        shape: BoxShape.circle),
                                  )),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  // news scroll bar
  Widget _scrollBar() {
    return SliverToBoxAdapter(
      child: Scrollbar(
          child: SizedBox(
        height: 70,
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Center(
                  child: Text(
                    'iPhone',
                    style: CommonStyles.size15W400Grey51(context),
                  ),
                ),
              ),
            );
          },
        ),
      )),
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
                          _listAllProduct.addAll(widget.allProduct);
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

  // title
  Widget _tittle(String tittle) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            tittle,
            style: CommonStyles.size24W700Black1D(context),
          ),
        ),
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
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShopDunkWebView(
                        url: item.seName,
                      ))),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(
                          top: Responsive.isMobile(context) ? 5 : 10,
                          right: Responsive.isMobile(context) ? 5 : 10),
                      child: Image.asset(
                        'assets/images/tet_2023.png',
                        scale: Responsive.isMobile(context) ? 10 : 6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Responsive.isMobile(context) ? 10 : 20),
                      child: Image.network(
                          item.defaultPictureModel?.imageUrl ?? ''),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                item.name ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: CommonStyles.size14W700Black1D(context),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      priceFormat.format(
                                          item.productPrice?.priceValue ?? 0),
                                      style: CommonStyles.size16W700Blue00(
                                          context),
                                    ),
                                    Text(
                                      '₫',
                                      style: CommonStyles.size12W400Blue00(
                                          context),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${priceFormat.format(item.productPrice?.oldPriceValue ?? item.productPrice?.priceValue)}₫',
                                  style: CommonStyles.size12W400Grey66(context)
                                      .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                          )
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
          mainAxisSpacing: Responsive.isMobile(context) ? 5 : 20,
          crossAxisSpacing: Responsive.isMobile(context) ? 5 : 20,
          childAspectRatio: 0.53,
        ),
      ),
    );
  }

  // description
  Widget _description(String description) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Html(
              data: _isExpand ? description : description.substring(0, 1000),
              padding: const EdgeInsets.all(10),
            ),
            GestureDetector(
                onTap: () => setState(() => _isExpand = !_isExpand),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isExpand ? 'Collapse' : 'Expand',
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

  // receive information
  Widget _receiveInfo() {
    return SliverToBoxAdapter(
      child: Container(
        color: const Color(0xffF2F2F2),
        padding: const EdgeInsets.symmetric(vertical: 40),
        margin: EdgeInsets.only(
          top: 20,
          left: Responsive.isMobile(context) ? 0 : 150,
          right: Responsive.isMobile(context) ? 0 : 150,
        ),
        child: Column(
          children: [
            Text(
              'Đăng ký nhận tin từ ShopDunk',
              style: CommonStyles.size24W700Black1D(context),
            ),
            Text(
              'Thông tin sản phẩm mới nhất và chương trình khuyến mãi',
              style: CommonStyles.size13W400Grey86(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Email của bạn',
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    suffixIcon: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: const Color(0xff0066CC),
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Đăng ký',
                            style: CommonStyles.size12W400White(context),
                          ),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
