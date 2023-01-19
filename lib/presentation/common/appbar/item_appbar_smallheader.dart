import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxcommon/presentation/navigation/cubit/navigation_cubit.dart';
import 'package:vnu/constant/colors.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/constant/strings.dart';
import 'package:vnu/constant/custom_text_style.dart';

AppBar appbarSmall(BuildContext context, String title) {
  return AppBar(
    
          centerTitle: true,
    automaticallyImplyLeading: false,
     title: Text(title,
              style: CustomTextStyle.getAppBarTitleStyle(Colors.white)),
          leading: GestureDetector(
            onTap: () {
              if (title == Strings.titleMore)
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.home);
              else
                Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ThemeColors.white, // add custom icons also
            ),
          ),
    backgroundColor: Colors.transparent,
  );
}
