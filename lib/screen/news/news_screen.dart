import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/news/news_bloc.dart';
import 'package:webviewtest/blocs/news/news_event.dart';
import 'package:webviewtest/blocs/news/news_state.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/screen/news/news_category.dart';
import 'package:webviewtest/screen/news/news_detail.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _indexSelected = 0;
  List<NewsGroup> _newsGroup = [];
  List<LatestNews> _latestNews = [];

  final TextEditingController _emailController = TextEditingController();

  // Sync data
  _getNews() async {
    BlocProvider.of<NewsBloc>(context).add(const RequestGetNews());
  }

  @override
  void initState() {
    _getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<NewsBloc, NewsState>(
        builder: (context, state) => _buildNewsUI(),
        listener: (context, state) {
          if (state is NewsLoading) {
            EasyLoading.show();
          } else if (state is NewsLoaded) {
            _newsGroup = state.newsData.newsGroup ?? [];
            _latestNews = state.newsData.latestNews ?? [];
            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is NewsLoadError) {
            if (EasyLoading.isShow) EasyLoading.dismiss();

            AlertUtils.displayErrorAlert(context, state.message);
          }
        },
      );

  // build UI
  Widget _buildNewsUI() {
    return Container(
      color: const Color(0xfff5f5f7),
      child: CustomScrollView(
        slivers: [
          _pageView(),
          _newsScrollBar(),
          _customListNews(),
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
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  _indexSelected = value;
                });
              },
              itemCount: _latestNews.length,
              itemBuilder: (context, index) {
                final item = _latestNews[index];

                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NewsDetail(
                        newsItems: NewsItems(),
                        latestNews: item,
                      ))),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          item.pictureModel?.fullSizeImageUrl ?? '',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 60),
                              child: Text(
                                item.title ?? '',
                                style: CommonStyles.size18W700White(context)
                                    .copyWith(height: 1.3),
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
                bottom: 20,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          _latestNews.length,
                          (index) => Container(
                                height: Responsive.isMobile(context) ? 10 : 15,
                                width: Responsive.isMobile(context) ? 10 : 15,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: _indexSelected == index
                                        ? Colors.white
                                        : const Color(0xff515154)
                                            .withOpacity(0.5),
                                    shape: BoxShape.circle),
                              )),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // news scroll bar
  Widget _newsScrollBar() {
    return SliverToBoxAdapter(
      child: Scrollbar(
          child: SizedBox(
        height: 80,
        child: ListView.builder(
          itemCount: _newsGroup.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final news = _newsGroup[index];
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NewsCategory(
                        newsGroup: news,
                      ))),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  children: [
                    Image.asset('assets/icons/ic_tips.webp', scale: 5),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      news.name ?? '',
                      style: CommonStyles.size15W400Grey51(context),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      )),
    );
  }

  // tittle
  Widget _tittle({required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Text(
        content,
        style: CommonStyles.size24W700Black1D(context),
      ),
    );
  }

  // list news
  Widget _listNews({required List<NewsItems> listNews}) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      childCount: 3,
      (context, index) {
        final item = listNews[index];
        final timeUpload = DateTime.parse(item.createdOn ?? '');
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
                          newsItems: item,
                        ))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.pictureModel?.fullSizeImageUrl ?? '',
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title ?? '',
                              style: CommonStyles.size18W700Black1D(context)
                                  .copyWith(height: 1.5),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              timeFormat,
                              style: CommonStyles.size13W400Grey86(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xff777777),
                ),
              )
            ],
          ),
        );
      },
    ));
  }

  // all news
  Widget _allNews({required String content, required NewsGroup newsGroup}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewsCategory(
                  newsGroup: newsGroup,
                ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Xem tất cả $content',
              style: CommonStyles.size14W400Blue00(context),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(0xff0066CC),
            ),
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

  // list news
  Widget _customListNews() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        final newsGroup = _newsGroup[index];
        return Column(
          children: [
            _tittle(
              content: newsGroup.name ?? '',
            ),
            CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                _listNews(listNews: newsGroup.newsItems ?? []),
              ],
            ),
            _allNews(
              content: newsGroup.name ?? '',
              newsGroup: newsGroup,
            ),
          ],
        );
      },
      childCount: _newsGroup.length,
    ));
  }
}
