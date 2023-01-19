import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxcommon/presentation/navigation/cubit/navigation_cubit.dart';
import 'package:vnu/constant/asset_images.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/constant/custom_text_style.dart';

AppBar appbarLarge(BuildContext context, String title, String image_name) {

  double screenheight = MediaQuery.of(context).size.height/4;
  print('screenheight $screenheight');
  return AppBar(
    toolbarHeight: screenheight,//Constant.imageheader,
    automaticallyImplyLeading: false,
    // centerTitle: true,
    title: Container(
        height: screenheight,//Constant.imageheader,
        margin: const EdgeInsets.only(top: Constant.padding20),
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () => BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.home),
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.getAppBarTitleStyle(Colors.white),
                ),
              ),
              // Your widgets here
            ],
          ),
        )),
    flexibleSpace: Container(
     // height: Constant.imageheader,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(LocalImages.assetImage + image_name),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.only(
          bottomLeft: const Radius.circular(Constant.cornerRadius20),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}
