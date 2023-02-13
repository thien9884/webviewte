import 'package:flutter/material.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              'Tin Tức',
              style: CommonStyles.size24W700Black1D(context),
            ),
          ),
        ),
        Expanded(
          child: _listNews(),
        ),
      ],
    );
  }

  // list news
  Widget _listNews() {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(4, 8),
                  ),
                ],
                borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/news_sale.jpeg'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Airpods Pro 2 thay đổi nhỏ ngoại hình, cải tiến lớn tính năng',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CommonStyles.size16W700Grey33(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '14/12/2022',
                          style: CommonStyles.size13W400Grey86(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
