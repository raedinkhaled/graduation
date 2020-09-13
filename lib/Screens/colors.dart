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
const t5DarkRed = Color(0XFFF06263);
const t5ColorPrimaryLight = Color(0X505104D7);
const t6white = Color(0XFFffffff);
const t6ShadowColor = Color(0X95E9EBF0);

BoxDecoration boxDecorationT6({double radius = 2, Color color = Colors.transparent, Color bgColor = t6white, var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      boxShadow: showShadow ? [BoxShadow(color: t6ShadowColor, blurRadius: 10, spreadRadius: 2)] : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}