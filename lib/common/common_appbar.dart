import 'package:flutter/material.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class CommonAppbar extends StatelessWidget {
  final String title;

  const CommonAppbar({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Container(
            height: 25,
            alignment: Alignment.center,
            child: Text(
              title,
              style: CommonStyles.size18W700Black1D(context),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 25,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
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
          )
        ],
      ),
    );
  }
}
