import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_state.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class LoadHtmlScreen extends StatefulWidget {
  final String data;

  const LoadHtmlScreen({required this.data, Key? key}) : super(key: key);

  @override
  State<LoadHtmlScreen> createState() => _LoadHtmlScreenState();
}

class _LoadHtmlScreenState extends State<LoadHtmlScreen> {
  late ScrollController _hideButtonController;
  bool _isVisible = false;

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
    _getHideBottomValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopdunkBloc, ShopdunkState>(
        builder: (context, state) =>
            CommonNavigateBar(child: _buildBody(context)),
        listener: (context, state) {});
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomScrollView(
          controller: _hideButtonController,
          slivers: [
            SliverToBoxAdapter(
              child: Html(
                data:
                    widget.data.replaceAll('src="', 'src="http://shopdunk.com'),
                style: {
                  "h3": Style(
                    fontSize: FontSize.xxLarge,
                    textAlign: TextAlign.justify,
                    fontFamily: "ArialCustom",
                  ),
                  "strong": Style(
                    fontSize: FontSize.xLarge,
                    textAlign: TextAlign.justify,
                    fontFamily: "ArialCustom",
                  ),
                  "p": Style(
                    fontSize: FontSize.xLarge,
                    textAlign: TextAlign.justify,
                    fontFamily: "ArialCustom",
                  ),
                  "span": Style(
                    fontSize: FontSize.xLarge,
                    textAlign: TextAlign.justify,
                    fontFamily: "ArialCustom",
                  ),
                  "li": Style(
                    fontSize: FontSize.xLarge,
                    textAlign: TextAlign.justify,
                    lineHeight: LineHeight.number(1.1),
                    fontFamily: "ArialCustom",
                  ),
                  "img": Style(alignment: Alignment.center),
                },
              ),
            ),
            _receiveInfo(context),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 1, (context, index) => const CommonFooter())),
          ],
        ),
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
