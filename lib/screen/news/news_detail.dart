import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class NewsDetail extends StatelessWidget {
  final NewsItems newsItems;

  const NewsDetail({required this.newsItems, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _newsDetail(context),
            _receiveInfo(context),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 1, (context, index) => const CommonFooter())),
          ],
        ),
      ),
    );
  }

  // news detail
  _newsDetail(BuildContext context) {
    final timeUpload = DateTime.parse(newsItems.createdOn ?? '');
    final timeFormat = DateFormat("dd/MM/yyyy").format(timeUpload);

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                newsItems.pictureModel?.fullSizeImageUrl ?? '',
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  newsItems.title ?? '',
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
              data: newsItems.full
                  ?.replaceAll('src="', 'src="http://shopdunk.com'),
              onLinkTap: (str, contextRender, list, element) =>
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShopDunkWebView(
                            baseUrl: str,
                          ))),
            ),
          ),
        ],
      ),
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
