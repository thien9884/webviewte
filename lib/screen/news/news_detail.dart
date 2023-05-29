import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_state.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/common/custom_material_page_route.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/related_news_model/comment_model.dart';
import 'package:webviewtest/model/related_news_model/related_news_model.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';
import 'package:webviewtest/screen/news/news_category.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

import '../../blocs/shopdunk/shopdunk_event.dart';

class NewsDetail extends StatefulWidget {
  final NewsGroup newsGroup;
  final NewsItems? newsItems;
  final LatestNews? latestNews;

  const NewsDetail({
    required this.newsGroup,
    this.newsItems,
    this.latestNews,
    Key? key,
  }) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  RelatedNews _relatedNewsData = RelatedNews();
  NewsCommentResponseModel _newsCommentResponseModel =
      NewsCommentResponseModel();
  List<NewsComments> _listComment = [];
  late ScrollController _hideButtonController;
  bool _isVisible = false;

  _getRelatedNewsData(int id) {
    BlocProvider.of<ShopdunkBloc>(context).add(RequestGetRelatedNews(id));
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
    _getRelatedNewsData(widget.newsItems?.id ?? 0);
    _getHideBottomValue();
    _listComment.addAll(widget.newsItems?.newsComments ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ShopdunkBloc, ShopdunkState>(
          builder: (context, state) => _newsDetailUI(context),
          listener: (context, state) {
            if (state is RelatedNewsLoading) {
              EasyLoading.show();
            } else if (state is RelatedNewsLoaded) {
              _relatedNewsData = state.newsData;
              print(_relatedNewsData);
              if (EasyLoading.isShow) EasyLoading.dismiss();
            } else if (state is RelatedNewsLoadError) {
              AlertUtils.displayErrorAlert(context, state.message);
            } else if (state is NewsCommentsLoading) {
              EasyLoading.show();
            } else if (state is NewsCommentsLoaded) {
              _newsCommentResponseModel = state.newsCommentResponseModel;
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
                        _newsCommentResponseModel.data?.message ?? '',
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
            } else if (state is NewsCommentsLoadError) {
              AlertUtils.displayErrorAlert(context, state.message);
            }
          });

  // news detail UI
  Widget _newsDetailUI(BuildContext context) {
    return CommonNavigateBar(index: 1, child: _buildBody());
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        color: Colors.white,
        child: CustomScrollView(
          controller: _hideButtonController,
          slivers: [
            _newsAppBar(),
            _newsDetail(context),
            _newsDivider(context),
            if (_relatedNewsData.productOverviewModels != null &&
                _relatedNewsData.productOverviewModels!.isNotEmpty)
              _relatedProductsTittle(context),
            if (_relatedNewsData.productOverviewModels != null)
              _relatedProducts(context),
            _addNewsComment(context),
            _newsCommentTitle(),
            if (_listComment.isNotEmpty) _newsComments(),
            if (_relatedNewsData.newsItemModels != null &&
                _relatedNewsData.newsItemModels!.isNotEmpty)
              _relatedNewsTittle(context),
            if (_relatedNewsData.newsItemModels != null) _relatedNews(context),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 1, (context, index) => const CommonFooter())),
          ],
        ),
      ),
    );
  }

  // news app bar
  Widget _newsAppBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NavigationScreen(
                          isSelected: 1,
                        )));
              },
              child: Text(
                'Trang chủ News',
                style: CommonStyles.size14W400Grey86(context),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewsCategory(
                          newsGroup: widget.newsGroup,
                          index: 1,
                        )));
              },
              child: Text(
                widget.newsGroup.name ?? '',
                style: CommonStyles.size14W400Grey86(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // news detail
  Widget _newsDetail(BuildContext context) {
    final timeUpload = DateTime.parse(
      (widget.latestNews != null
              ? widget.latestNews?.createdOn
              : widget.newsItems?.createdOn) ??
          '',
    );
    final timeFormat = DateFormat("dd/MM/yyyy").format(timeUpload);

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(
                  (widget.latestNews != null
                          ? widget.latestNews?.pictureModel?.fullSizeImageUrl
                          : widget.newsItems?.pictureModel?.fullSizeImageUrl) ??
                      '',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  (widget.latestNews != null
                          ? widget.latestNews?.title
                          : widget.newsItems?.title) ??
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: HtmlWidget(
              widget.latestNews != null
                  ? widget.latestNews?.full?.replaceAll('/images/uploaded/',
                          'https://shopdunk.com/images/uploaded/') ??
                      ''
                  : widget.newsItems?.full?.replaceAll('/images/uploaded/',
                          'https://shopdunk.com/images/uploaded/') ??
                      '',
              textStyle: const TextStyle(fontSize: 16, height: 1.3),
              onTapUrl: (st) {
                print('object');
                return true;
              },
              customStylesBuilder: (element) {
                if (element.localName == 'p') {
                  return {'text-align': 'justify', 'font-size': '18px'};
                }
                if (element.localName == 'span') {
                  return {'text-align': 'justify'};
                }
                if (element.localName == 'ul') {
                  return {'text-align': 'justify'};
                }
                if (element.localName == 'h2') {
                  return {'font-weight': '700'};
                }
                if (element.localName == 'td') {
                  return {'padding-left': '8px'};
                }
                if (element.localName == 'a') {
                  return {'color': '#0000ff'};
                }
                return null;
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
                  onTap: () =>
                      Navigator.of(context).push(CustomMaterialPageRoute(
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
                            item?.defaultPictureModel?.fullSizeImageUrl ?? ''),
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
                                        item?.productPrice?.priceValue != null
                                            ? priceFormat.format(
                                                item?.productPrice?.priceValue)
                                            : '',
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

  // add news comment
  Widget _addNewsComment(BuildContext context) {
    TextEditingController newsComment = TextEditingController();
    TextEditingController newsDescription = TextEditingController();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        BlocProvider.of<ShopdunkBloc>(context).add(
                          RequestPostNewsComment(
                            widget.newsItems?.id,
                            NewsCommentModel(
                              id: 1,
                              customerId: 0,
                              customerName: 'thien@gmail.com',
                              customerAvatarUrl: '',
                              allowViewingProfiles: true,
                              createOn: DateTime.now().toString(),
                              commentTitle: 'thien',
                              commentText: 'hi anh',
                            ),
                          ),
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
                      child: Text(
                        'Gửi',
                        style: CommonStyles.size12W400White(context),
                      ),
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

  // news comment title
  Widget _newsCommentTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              'Bình luận',
              style: CommonStyles.size20W400Black44(context),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // news comments
  Widget _newsComments() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: _listComment.length,
            (context, index) {
      final item = _listComment[index];
      var dateValue = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
          .parseUTC(item.createdOn ?? '')
          .toLocal();
      String formattedDate = DateFormat("dd/MM/yyyy HH:mm").format(dateValue);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(item.customerAvatarUrl ??
                  'https://api.shopdunk.com/images/thumbs/default-avatar_120.jpg'),
              radius: 20,
              backgroundColor: Colors.transparent,
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       width: 2,
            //       color: Colors.black,
            //     ),
            //     shape: BoxShape.circle,
            //   ),
            //   child: Image.network(
            //     'https://api.api.shopdunk.com/images/thumbs/default-avatar_120.jpg',
            //     height: 30,
            //     width: 30,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10, bottom: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xffF5F5F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.customerName ?? '',
                          style: CommonStyles.size16W700Blue00(context),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          formattedDate,
                          style: CommonStyles.size13W400Grey86(context),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      item.commentText ?? '',
                      style: CommonStyles.size14W400Black1D(context),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }));
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
        final timeUpload =
            DateTime.parse(item?.createdOn ?? DateTime.now().toString());
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
                          newsGroup: widget.newsGroup,
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
}
