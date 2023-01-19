import 'package:flutter/material.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/constant/strings.dart';

import 'package:vnu/constant/custom_text_style.dart';
import 'package:vnu/presentation/common/widgets/textfield.dart';
import 'package:vnu/presentation/registration/memberregistration.dart';

class MyRewardWidgetNR extends StatefulWidget {
  const MyRewardWidgetNR({Key? key}) : super(key: key);

  @override
  State<MyRewardWidgetNR> createState() => _MyRewardWidgetNRState();
}

class _MyRewardWidgetNRState extends State<MyRewardWidgetNR> {
  late List<TextEditingController> _controller = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Constant.padding10),
      child: Column(children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: Constant.padding15,
                    bottom: Constant.padding05,
                    right: Constant.padding10,
                    top: Constant.padding15), //apply padding to all four sides
                child: HomeWidgettitle(context, Strings.titleMyWallet)),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MemberRegister()));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFFB7852F)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constant.borderWidth16),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: Constant.padding20, right: Constant.padding20),
            child: Text(
              Strings.titleRegisterhere,
              style: CustomTextStyle.getTitleStyle(Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
