import 'package:flutter/material.dart';

const t5ColorPrimary = Color(0XFF5104D7);
const t5ColorPrimaryDark = Color(0XFF325BF0);
const t5ColorAccent = Color(0XFFD81B60);
const t5TextColorPrimary = Color(0XFF130925);
const t5TextColorSecondary = Color(0XFF888888);
const t5TextColorThird = Color(0XFFBABFB6);
const t5TextColorGrey = Color(0XFFB4BBC2);
const t5White = Color(0XFFFFFFFF);
const t5LayoutBackgroundWhite = Color(0XFFF6F7FA);
const t5ViewColor = Color(0XFFB4BBC2);
const t5SkyBlue = Color(0XFF1fc9cd);
const t5DarkNavy = Color(0XFF130925);
const t5Cat1 = Color(0XFF45c7db);
const t5Cat2 = Color(0XFF510AD7);
const t5Cat3 = Color(0XFFe43649);
const t5Cat4 = Color(0XFFf4b428);
const t5Cat5 = Color(0XFF22ce9a);
const t5Cat6 = Color(0XFF203afb);
const t5ShadowColor = Color(0X95E9EBF0);
const t6textColorPrimary = Color(0XFF464545);
const t5DarkRed = Color(0XFFF06263);
const t5ColorPrimaryLight = Color(0X505104D7);
const t6white = Color(0XFFffffff);
const t6ShadowColor = Color(0X95E9EBF0);
const t1_colorPrimary = Color(0XFFff8080);
const t1_colorPrimary_light = Color(0XFFFFEEEE);
const t1_colorPrimaryDark = Color(0XFFff8080);
const t1_colorAccent = Color(0XFFff8080);

const t1_textColorPrimary = Color(0XFF333333);
const t1_textColorSecondary = Color(0XFF747474);

const t1_app_background = Color(0XFFf8f8f8);
const t1_view_color = Color(0XFFDADADA);

const t1_sign_in_background = Color(0XFFDADADA);

const t1_white = Color(0XFFffffff);
const t1_icon_color = Color(0XFF747474);
const t1_selected_tab = Color(0XFFFCE9E9);
const t1_red = Color(0XFFF10202);
const t1_blue = Color(0XFF1D36C0);
const t1_edit_text_background = Color(0XFFE8E8E8);
const t1_shadow = Color(0X70E2E2E5);
var t1White = materialColor(0XFFFFFFFF);
var t1TextColorPrimary = materialColor(0XFF212121);
const shadow_color = Color(0X95E9EBF0);
const t1_color_primary_light = Color(0XFFFCE8E8);
const t1_bg_bottom_sheet = Color(0XFFFFF1F1);

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor materialColor(colorHax) {
  return MaterialColor(colorHax, color);
}

MaterialColor colorCustom = MaterialColor(0XFF5959fc, color);

BoxDecoration boxDecorationT6({double radius = 2, Color color = Colors.transparent, Color bgColor = t6white, var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      boxShadow: showShadow ? [BoxShadow(color: t6ShadowColor, blurRadius: 10, spreadRadius: 2)] : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}