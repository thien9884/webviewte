import 'package:flutter/material.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class CommonAppbar extends StatelessWidget {
  final String title;

  const CommonAppbar({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      leadingWidth: 90,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
                color: Color(0xff0066CC),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Trở lại',
                style: CommonStyles.size16W400Blue00(context),
              ),
            ],
          ),
        ),
      ),
      title: Text(
        title,
        style: CommonStyles.size18W700Black1D(context),
      ),
      centerTitle: true,
    );
  }
}
