import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vnu/constant/asset_images.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/constant/strings.dart';
import 'package:vnu/constant/custom_text_style.dart';
import 'package:vnu/presentation/common/widgets/textfield.dart';
import 'package:vnu/presentation/registration/guestregistration.dart';

import '../common/appbar/item_appbar_smallheader.dart';

class MemberRegister extends StatefulWidget {
  const MemberRegister({Key? key}) : super(key: key);

  @override
  State<MemberRegister> createState() => _MemberRegisterState();
}

class _MemberRegisterState extends State<MemberRegister> {
  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
        context, Strings.memberReg, "", MemberRegisterPage(), 1);
  }
}

class MemberRegisterPage extends StatefulWidget {
  const MemberRegisterPage({Key? key}) : super(key: key);

  @override
  State<MemberRegisterPage> createState() => _MemberRegisterPageState();
}

class _MemberRegisterPageState extends State<MemberRegisterPage> {
  bool isName = false;
  TextEditingController membershipnumberController = TextEditingController();
  TextEditingController postalcodeController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  List<TextEditingController> _controller = [];
  @override
  void initState() {
    _controller.add(membershipnumberController);
    _controller.add(firstnameController);
    _controller.add(lastnameController);
    _controller.add(dateController);
    _controller.add(monthController);
    _controller.add(yearController);
    _controller.add(postalcodeController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: Constant.padding20,right: Constant.padding20),
    child:  ListView(
       children: <Widget>[
        const SizedBox(height: Constant.padding20),
        textNote(context, Strings.memberRegtitle),
        const SizedBox(height: Constant.padding20),
        if (!isName)
          Column(children: <Widget>[
            textField(context, Strings.membershipNumber, TextInputType.number,
                TextInputAction.next, membershipnumberController),
            const SizedBox(height: Constant.padding20),
            InkWell(
              onTap: () {
                setState(() {
                  isName = true;
                });
              },
              child:
                  underlineText(context, Strings.useMyname, Alignment.topLeft),
            ),
          ]),
        if (isName)
          Column(children: <Widget>[
            textField(context, Strings.firstName, TextInputType.name,
                TextInputAction.next, firstnameController),
            const SizedBox(height: Constant.padding20),
            textField(context, Strings.lastName, TextInputType.name,
                TextInputAction.next, lastnameController),
            const SizedBox(height: Constant.padding20),
            InkWell(
              onTap: () {
                setState(() {
                  isName = false;
                });
              },
              child: underlineText(
                  context, Strings.useMynumber, Alignment.topLeft),
            ),
          ]),
        const SizedBox(height: Constant.padding20),
        textFieldDOB(context, dateController, monthController, yearController),
        const SizedBox(height: Constant.padding20),
        textField(context, Strings.postalCode, TextInputType.number,
            TextInputAction.done, postalcodeController),
        const SizedBox(height: Constant.padding20),
        richText(context, Strings.clickHere, Strings.termsandconditionmsg),
        const SizedBox(height: Constant.padding20),
        button(context, Strings.memberReg.toUpperCase(), GuestRegister(),
            _controller),
        const SizedBox(height: Constant.padding10),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GuestRegister()));
          },
          child:
              underlineText(context, Strings.contiueasGuest, Alignment.center),
        ),
      ]),
    );
  }

  setWidget() {
    child:
    Column(children: <Widget>[
      textField(context, Strings.firstName, TextInputType.number,
          TextInputAction.next, firstnameController),
      const SizedBox(height: Constant.padding20),
      textField(context, Strings.lastName, TextInputType.number,
          TextInputAction.next, lastnameController),
      const SizedBox(height: Constant.padding20),
      InkWell(
        onTap: () => isName = false,
        child: underlineText(context, Strings.useMynumber, Alignment.topLeft),
      ),
    ]);
  }
}
