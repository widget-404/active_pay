import 'package:aactivpay/export.dart';
import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String number;

  const RichTextWidget({Key key, this.number = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'Six digit one time password is sent to your phone number ',
          style: textStyles.bodyRegular,
          children: [
            TextSpan(
              text: number,
              style: textStyles.bodyRegular.copyWith(
                color: colors.accentPrimary,
              ),
            ),
          ]),
    );
  }
}
