import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/screen/news/news_detail.dart';

class NewsCategory extends StatelessWidget {
  final NewsGroup newsGroup;

  const NewsCategory({required this.newsGroup, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xfff5f5f7),
        child: CustomScrollView(
          slivers: [
            _newsTittleCategory(context, newsGroup.name ?? ''),
            _listNewsCategory(newsGroup.newsItems ?? []),
            _receiveInfo(context),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 1, (context, index) => const CommonFooter())),
          ],
        ),
      ),
    );
  }

  // tittle news category
  Widget _newsTittleCategory(BuildContext context, String tittle) {
    return SliverPadding(
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
                  newsGroup: newsGroup,
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
                      child: Image.network(
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
                      )),
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
