import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/related_news/related_news_bloc.dart';
import 'package:webviewtest/blocs/related_news/related_news_event.dart';
import 'package:webviewtest/blocs/related_news/related_news_state.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/related_news_model/related_news_model.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class NewsDetail extends StatefulWidget {
  final NewsItems newsItems;
  final LatestNews? latestNews;

  const NewsDetail({required this.newsItems, this.latestNews, Key? key})
      : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  RelatedNews _relatedNewsData = RelatedNews();

  _getRelatedNewsData(int id) {
    BlocProvider.of<RelatedNewsBloc>(context).add(RequestGetRelatedNews(id));
  }

  @override
  void initState() {
    _getRelatedNewsData(588);
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<RelatedNewsBloc, RelatedNewsState>(
          builder: (context, state) => _newsDetailUI(context),
          listener: (context, state) {
            if (state is RelatedNewsLoading) {
            } else if (state is RelatedNewsLoaded) {
              _relatedNewsData = state.newsData;
            } else if (state is RelatedNewsLoadError) {
              AlertUtils.displayErrorAlert(context, state.message);
            }
          });

  // news detail UI
  Widget _newsDetailUI(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: CustomScrollView(
            slivers: [
              _newsDetail(context),
              _newsDivider(context),
              _relatedProductsTittle(context),
              _relatedProducts(context),
              _newsComment(context),
              _relatedNewsTittle(context),
              _relatedNews(context),
              _receiveInfo(context),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: 1, (context, index) => const CommonFooter())),
            ],
          ),
        ),
      ),
    );
  }

  // news detail
  Widget _newsDetail(BuildContext context) {
    final timeUpload = DateTime.parse(
      (widget.latestNews != null
              ? widget.latestNews?.createdOn
              : widget.newsItems.createdOn) ??
          '',
    );
    final timeFormat = DateFormat("dd/MM/yyyy").format(timeUpload);

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                (widget.latestNews != null
                        ? widget.latestNews?.pictureModel?.fullSizeImageUrl
                        : widget.newsItems.pictureModel?.fullSizeImageUrl) ??
                    '',
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  (widget.latestNews != null
                          ? widget.latestNews?.title
                          : widget.newsItems.title) ??
                      '',
                  style: CommonStyles.size24W700Grey39(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Text(
                  timeFormat,
                  style: CommonStyles.size13W400Grey86(context),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Html(
              data: widget.latestNews != null
                  ? widget.latestNews?.full
                      ?.replaceAll('src="', 'src="http://shopdunk.com')
                  : widget.newsItems.full
                      ?.replaceAll('src="', 'src="http://shopdunk.com'),
              onLinkTap: (str, contextRender, list, element) =>
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShopDunkWebView(
                            baseUrl: str,
                          ))),
              style: {
                "h3": Style(
                  fontSize: FontSize.xxLarge,
                  textAlign: TextAlign.justify,
                ),
                "p": Style(
                  fontSize: FontSize.xLarge,
                  textAlign: TextAlign.justify,
                ),
                "li": Style(
                  fontSize: FontSize.xLarge,
                  textAlign: TextAlign.justify,
                  lineHeight: LineHeight.number(1.1),
                ),
                "img": Style(alignment: Alignment.center),
              },
            ),
          ),
        ],
      ),
    );
  }

  // news divider
  Widget _newsDivider(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Divider(
          height: 1,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Color(0xffEBEBEB),
        ),
      ),
    );
  }

  // related products tittle
  Widget _relatedProductsTittle(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Sản phẩm liên quan',
          style: CommonStyles.size18W700Black1D(context),
        ),
      ),
    );
  }

  // related products
  Widget _relatedProducts(BuildContext context) {
    var priceFormat = NumberFormat.decimalPattern('vi_VN');

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: _relatedNewsData.productOverviewModels?.length,
          (context, index) {
            final item = _relatedNewsData.productOverviewModels?[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShopDunkWebView(
                            url: item?.seName,
                          ))),
                  borderRadius: BorderRadius.circular(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Responsive.isMobile(context) ? 10 : 20),
                        child: Image.network(
                            'https://shopdunk.com/images/thumbs/0008913_apple-watch-ultra-lte-49mm-alpine-loop-size-s_420.png'),
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
                                  item?.name ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      CommonStyles.size14W700Black1D(context),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        priceFormat.format(
                                            item?.productPrice?.priceValue),
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
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: Responsive.isMobile(context) ? 200 : 300,
          mainAxisSpacing: Responsive.isMobile(context) ? 5 : 20,
          crossAxisSpacing: Responsive.isMobile(context) ? 5 : 20,
          childAspectRatio: 0.6,
        ),
      ),
    );
  }

  // news comment
  Widget _newsComment(BuildContext context) {
    TextEditingController newsComment = TextEditingController();
    TextEditingController newsDescription = TextEditingController();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Để lại bình luận của bạn',
                style: CommonStyles.size18W700Black1D(context),
              ),
            ),
            TextField(
              controller: newsComment,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Tiêu đề nhận xét',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                TextField(
                  controller: newsDescription,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Để lại bình luận của bạn',
                  ),
                  maxLines: 3,
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      EasyLoading.show();
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            if (EasyLoading.isShow) EasyLoading.dismiss();

                            return CupertinoAlertDialog(
                              title: Text(
                                'Thông báo',
                                style: CommonStyles.size17W700Black1D(context),
                              ),
                              content: Text(
                                CommonText.confirmComment(context),
                                style: CommonStyles.size14W400Green66(context),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      width: 45,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text('Gửi'),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // news comment tittle
  Widget _relatedNewsTittle(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Tin tức liên quan',
          style: CommonStyles.size18W700Black1D(context),
        ),
      ),
    );
  }

  // related news
  Widget _relatedNews(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      childCount: _relatedNewsData.newsItemModels?.length,
      (context, index) {
        final item = _relatedNewsData.newsItemModels?[index];
        final timeUpload = DateTime.parse(item?.createdOn ?? '');
        final timeFormat = DateFormat("dd/MM/yyyy").format(timeUpload);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewsDetail(
                          newsItems: item ?? NewsItems(),
                        ))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item?.pictureModel?.fullSizeImageUrl ?? '',
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              timeFormat,
                              style: CommonStyles.size13W400Grey86(context),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              item?.title ?? '',
                              style: CommonStyles.size18W700Black1D(context)
                                  .copyWith(height: 1.5),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  // receive information
  Widget _receiveInfo(BuildContext context) {
    TextEditingController emailController = TextEditingController();

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
                controller: emailController,
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
