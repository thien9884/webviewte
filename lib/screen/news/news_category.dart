import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_state.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/news_category/news_category_model.dart';
import 'package:webviewtest/screen/news/news_detail.dart';

class NewsCategory extends StatefulWidget {
  final int? index;
  final NewsGroup newsGroup;

  const NewsCategory({required this.newsGroup, this.index, Key? key})
      : super(key: key);

  @override
  State<NewsCategory> createState() => _NewsCategoryState();
}

class _NewsCategoryState extends State<NewsCategory> {
  NewsCategoryModel _newsCategoryModel = NewsCategoryModel();
  int _pagesSelected = 0;
  final dataKey = GlobalKey();
  final ScrollController _pageScrollController = ScrollController();
  late ScrollController _hideButtonController;
  bool _isVisible = false;

  _getNewsGroup() {
    BlocProvider.of<ShopdunkBloc>(context).add(
      RequestGetNewsCategory(widget.newsGroup.id, 1),
    );
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
    _getNewsGroup();
    _getHideBottomValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ShopdunkBloc, ShopdunkState>(
          builder: (context, state) => _buildNewsGroup(context),
          listener: (context, state) {
            if (state is NewsCategoryLoading) {
              EasyLoading.show();
            } else if (state is NewsCategoryLoaded) {
              _newsCategoryModel = state.newsCategoryModel;
              if (EasyLoading.isShow) EasyLoading.dismiss();
            } else if (state is NewsCategoryLoadError) {
              AlertUtils.displayErrorAlert(context, state.message);

              if (EasyLoading.isShow) EasyLoading.dismiss();
            }
          });

  // build news group
  Widget _buildNewsGroup(BuildContext context) {
    return CommonNavigateBar(
      index: widget.index ?? -1,
      child: _newsCategoryModel.newsCategoryData != null
          ? Container(
              color: const Color(0xfff5f5f7),
              child: CustomScrollView(
                controller: _hideButtonController,
                slivers: [
                  _newsTittleCategory(context, widget.newsGroup.name ?? ''),
                  _listNewsCategory(_newsCategoryModel.newsCategoryData ?? []),
                  if (_newsCategoryModel.total != null) _pagesNumber(),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: 1,
                          (context, index) => const CommonFooter())),
                ],
              ),
            )
          : Container(),
    );
  }

  // tittle news category
  Widget _newsTittleCategory(BuildContext context, String tittle) {
    return SliverPadding(
      key: dataKey,
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            tittle,
            style: CommonStyles.size24W700Grey4B(context),
          ),
        ),
      ),
    );
  }

  // list news category
  Widget _listNewsCategory(List<NewsItems> newsItemList) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = newsItemList[index];
          final timeUpload = DateTime.parse(item.createdOn ?? '');
          final timeFormat = DateFormat("dd/MM/yyyy").format(timeUpload);
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewsDetail(
                      newsItems: item,
                      newsGroup: widget.newsGroup,
                    ))),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: item.pictureModel?.imageUrl != null
                        ? Image.network(
                            item.pictureModel?.imageUrl ?? '',
                            loadingBuilder: (context, child, event) {
                              if (event == null) return child;
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    value: event.expectedTotalBytes != null
                                        ? event.cumulativeBytesLoaded /
                                            event.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, exception, stackTrace) {
                              return Container();
                            },
                          )
                        : const SizedBox(
                            height: 60,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      item.title ?? '',
                      style: CommonStyles.size17W700Black1D(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      timeFormat.toString(),
                      style: CommonStyles.size13W400Grey86(context),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        childCount: newsItemList.length,
      )),
    );
  }

  // pages number
  Widget _pagesNumber() {
    var totalPage = (_newsCategoryModel.total! / 8).ceil();

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
                            RequestGetNewsCategory(
                              widget.newsGroup.id,
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
                  child: ListView.builder(
                    controller: _pageScrollController,
                    itemCount: totalPage,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => setState(() {
                        _pagesSelected = index;
                        BlocProvider.of<ShopdunkBloc>(context).add(
                          RequestGetNewsCategory(
                              widget.newsGroup.id, index + 1),
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
                if (totalPage > 6 &&
                    _pagesSelected <=
                        (_newsCategoryModel.newsCategoryData!.length - 5))
                  GestureDetector(
                    onTap: () {
                      if (_newsCategoryModel.total != null &&
                          _pagesSelected != totalPage - 1) {
                        setState(() {
                          _pagesSelected = totalPage - 1;
                          BlocProvider.of<ShopdunkBloc>(context).add(
                            RequestGetNewsCategory(
                              widget.newsGroup.id,
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
}
