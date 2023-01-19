import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vnu/constant/asset_images.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/constant/custom_text_style.dart';
import 'package:vnu/constant/strings.dart';
import 'package:vnu/presentation/common/appbar/item_appbar_largeheader.dart';
import 'package:vnu/presentation/common/appbar/item_appbar_smallheader.dart';

TextField textField(BuildContext context, String hint, TextInputType inputType,
    TextInputAction action, TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: inputType,
    textInputAction: action,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    cursorHeight: 20,
    cursorColor: Theme.of(context).secondaryHeaderColor,
    autofocus: false,
    style: CustomTextStyle.getTextFieldStyle(Colors.black),
    decoration: InputDecoration(
      hintText: hint,
      fillColor: Theme.of(context).backgroundColor,
      filled: true,
      hintStyle: const TextStyle(color: Color.fromARGB(255, 138, 136, 136)),
       prefixIcon: Image.asset('assets/images/name_icon.png'),
       prefixIconColor: Theme.of(context).primaryColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      border: textBorder(),
      enabledBorder: textBorder(),
      focusedBorder: textBorder(),
    ),
  );
}

List<String> monthList = [
  "Month",
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

Future _showMonthList(
    BuildContext context, TextEditingController monthController) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          content: Container(
              height: MediaQuery.of(context).size.height - 200,
              width: 100,
              child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: monthList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(monthList[index],
                          style: CustomTextStyle.getDescStyle(Colors.black)),
                      onTap: () {
                        monthController.text = monthList[index];
                        Navigator.of(context).pop();

                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    );
                  })));
    },
  );
}

Widget textFieldDOB(
    BuildContext context,
    TextEditingController dateController,
    TextEditingController monthController,
    TextEditingController yearController) {
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(30)),
    child: IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: textField(context, Strings.date, TextInputType.number,
                TextInputAction.done, dateController),
          ),
          verticleDivider(context),
          Expanded(
            child: TextField(
              onTap: () {
                print('month field is tapped');
                FocusManager.instance.primaryFocus?.unfocus();
                _showMonthList(context, monthController);
              },
              controller: monthController,
              readOnly: true,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              showCursor: false,
              keyboardAppearance: null,
              style: CustomTextStyle.getTextFieldStyle(Colors.black),
              decoration: InputDecoration(
                hintText: Strings.month,
                fillColor: Colors.transparent,
                filled: true,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 138, 136, 136)),
                suffixIcon: const Icon(Icons.keyboard_arrow_down),
                prefixIconColor: Theme.of(context).dividerColor,
                contentPadding: EdgeInsets.all(-2),
                border: textBorder(),
                enabledBorder: textBorder(),
                focusedBorder: textBorder(),
              ),
            ),
          ),
          verticleDivider(context),
          Expanded(
            child: textField(context, Strings.year, TextInputType.number,
                TextInputAction.next, yearController),
          ),
        ],
      ),
    ),
  );
}

OutlineInputBorder textBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.white, width: 2),
  );
}

VerticalDivider verticleDivider(BuildContext context) {
  return VerticalDivider(
    color: Theme.of(context).secondaryHeaderColor,
    thickness: 0.5,
    indent: 5,
    endIndent: 5,
  );
}

Widget emptyResponse(BuildContext context, title) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          LocalImages.placholderImagepath,
          height: 50,
          width: 50,
        ),
        const SizedBox(
          height: Constant.padding20,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: CustomTextStyle.getTitleStyle(Colors.white),
        ),
      ],
    ),
  );
}

Padding textNote(BuildContext context, title) {
  return Padding(
    padding: const EdgeInsets.only(
        left: Constant.padding25, right: Constant.padding25),
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: CustomTextStyle.getAppBarTitleStyle(Colors.white),
    ),
  );
}

Widget emptyAlert(BuildContext context, title) {
  return AlertDialog(
    title: const Text(""),
    content: Text(
      'No $title',
      style: CustomTextStyle.getDescStyle(Colors.black),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Text(
            "ok",
            style: CustomTextStyle.getDescStyle(Colors.black),
          ),
        ),
      ),
    ],
  );
}

Align underlineText(BuildContext context, String title, Alignment alignment) {
  return Align(
    alignment: alignment,
    child: Text(
      title,
      style: TextStyle(
        shadows: [
          Shadow(
              color: Theme.of(context).backgroundColor, offset: Offset(0, -1))
        ],
        color: Colors.transparent,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).backgroundColor,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Align richText(BuildContext context, String title, String title1) {
  return Align (alignment: Alignment.center,
  child : RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: title,
          style: TextStyle(
            shadows: [
              Shadow(
                  color: Theme.of(context).backgroundColor,
                  offset: Offset(0, -1))
            ],
            color: Colors.transparent,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).backgroundColor,
            decorationStyle: TextDecorationStyle.solid,
            decorationThickness: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
            text: title1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ],
    ),
  ));
}

ElevatedButton button(BuildContext context, String text, Widget memberReg,
    List<TextEditingController> _controller) {
  return ElevatedButton(
    
    onPressed: () {
      // print(_controller[0].text+" button "+_controller[1].text);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => memberReg));
    },
    style: ButtonStyle(
      
      backgroundColor: MaterialStateProperty.all(const Color(0xFFB7852F)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constant.borderWidth16),
        ),
      ),
    ),
    child: Text(
      text,
      style: CustomTextStyle.getTitleStyle(Colors.white),
    ),
  );
}

Text HomeWidgettitle(BuildContext context, String title) {
  return Text(
    title,
    textAlign: TextAlign.left,
    style: CustomTextStyle.getTitleStyle(Colors.white),
  );
}

Container HomeScaffold(BuildContext context, String title, String imageName,
    Widget bodyBlock, int type) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(LocalImages.homebg), fit: BoxFit.fitWidth)),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: HomeScaffoldAppBar(context, title, imageName, type),
      body: bodyBlock,
    ),
  );
}

AppBar HomeScaffoldAppBar(
    BuildContext context, String title, String imageName, int type) {
  if (type == 0) {
    return appbarLarge(context, title, imageName);
  } else {
    return appbarSmall(context, title);
  }
}

ImageProvider setImage(String imagePath)
{
  final Image noImage = Image.asset(LocalImages.placholderImagepath);
final imageUrl = imagePath;

NetworkImage image ;

try{
return image = NetworkImage(imageUrl);
}on Exception catch (_){
 
return noImage as ImageProvider;
}

//return   (imageUrl != null) ? NetworkImage(imageUrl) : noImage as ImageProvider;

//return image as ImageProvider;
}
// Now, in the widget's image property of your first example:
/* return  (imageUrl != null) // Only use the network image if the url is not null
  ? Image.network(
      imageUrl ,
      loadingBuilder: (context, child, loadingProgress) =>
          (loadingProgress == null) ? child : CircularProgressIndicator(),
      errorBuilder: (context, error, stackTrace) => noImage,
    )
  : noImage  as ImageProvider ; */





/*  String birthDateValidator(String value) {
final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy');
final String formatted = formatter.format(now);
String str1 = value;
List<String> str2 = str1.split('/');
String month = str2.isNotEmpty ? str2[0] : '';
String day = str2.length > 1 ? str2[1] : '';
String year = str2.length > 2 ? str2[2] : '';
if (value.isEmpty) {
  return 'BirthDate is Empty';
} else if (int.parse(month) > 13) {
  return 'Month is invalid';
} else if (int.parse(day) > 32) {
  return 'Day is invalid';
} else if ((int.parse(year) > int.parse(formatted))) {
  return 'Year is invalid';
} else if((int.parse(year) < 1920)){
  return 'Year is invalid';
}
return null;
} */