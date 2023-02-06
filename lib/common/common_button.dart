import 'package:flutter/material.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CommonButton({required this.title, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onTap != null ? Colors.blue : const Color(0xff86868B),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              title,
              style: onTap != null
                  ? CommonStyles.size14W700White(context)
                  : CommonStyles.size14W400Black1D(context),
            ),
          ),
        ),
      ),
    );
  }
}
