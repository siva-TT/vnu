import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vnu/constant/asset_images.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/constant/strings.dart';
import 'package:vnu/presentation/common/widgets/textfield.dart';
import 'package:vnu/presentation/registration/memberregistration.dart';

import '../common/appbar/item_appbar_smallheader.dart';

class GuestRegister extends StatefulWidget {
  const GuestRegister({Key? key}) : super(key: key);

  @override
  State<GuestRegister> createState() => _GuestRegisterState();
}

class _GuestRegisterState extends State<GuestRegister> {
  @override
  Widget build(BuildContext context) {
    return  HomeScaffold(
        context, Strings.guestReg, "", GuestRegisterPage(),1);
        }

}

class GuestRegisterPage extends StatefulWidget {
  const GuestRegisterPage({Key? key}) : super(key: key);

  @override
  State<GuestRegisterPage> createState() => _GuestRegisterPageState();
}

class _GuestRegisterPageState extends State<GuestRegisterPage> {
  bool isName = false;
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController postalcodeController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<TextEditingController> _controller = [];
  @override
  void initState() {
    _controller.add(firstnameController);
    _controller.add(lastnameController);
    _controller.add(dateController);
    _controller.add(monthController);
    _controller.add(yearController);
    _controller.add(postalcodeController);
    _controller.add(phoneNumController);
    _controller.add(emailController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: Constant.padding20,right: Constant.padding20),
    child:  ListView(
       children: <Widget>[
        const SizedBox(height: Constant.padding20),
        textNote(context, Strings.guestRegtitle),
        const SizedBox(height: Constant.padding20),
        textField(context, Strings.firstName, TextInputType.name,
            TextInputAction.next, firstnameController),
        const SizedBox(height: Constant.padding15),
        textField(context, Strings.lastName, TextInputType.name,
            TextInputAction.next, lastnameController),
        const SizedBox(height: Constant.padding15),
        textFieldDOB(context, dateController, monthController, yearController),
        const SizedBox(height: Constant.padding15),
        textField(context, Strings.postalCode, TextInputType.number,
            TextInputAction.done, postalcodeController),
        const SizedBox(height: Constant.padding15),
        textField(context, Strings.phoneNumber, TextInputType.number,
            TextInputAction.next, phoneNumController),
        const SizedBox(height: Constant.padding15),
        textField(context, Strings.email, TextInputType.emailAddress,
            TextInputAction.next, emailController),
        const SizedBox(height: Constant.padding15),
        richText(context, Strings.clickHere, Strings.termsandconditionmsg),
        const SizedBox(height: Constant.padding20),
        textNote(context, Strings.guestNote),
        const SizedBox(height: Constant.padding20),
        button(context, Strings.memberReg.toUpperCase(), const MemberRegister(),
            _controller),
      ]),);
  }
}
