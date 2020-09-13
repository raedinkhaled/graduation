import 'package:flutter/material.dart';
import 'package:graduation/Screens/Patients.dart';
import 'package:graduation/Screens/T5Images.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Widgets/BubbleBottomBar.dart';

class T5BottomBar extends StatefulWidget {
  static String tag = '/T5BottomBar';
  final ValueChanged<int> onTap;

  T5BottomBar({this.onTap});

  @override
  T5BottomBarState createState() => T5BottomBarState();
}

class T5BottomBarState extends State<T5BottomBar> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      opacity: .2,
      currentIndex: currentIndex,
      elevation: 8,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      //new
      hasNotch: false,
      //new
      hasInk: true,
      //new, gives a cute ink effect
      inkColor: t5ColorPrimaryLight,
      //optional, uses theme color if not specified
      items: <BubbleBottomBarItem>[
        tab(t5_img_home, "Accueil"),
        tab(t5_user, "Patients"),
        tab(t5_list_check, "Listing"),
        tab(t5_notification_2, "Notification"),
        tab(t5_user, "Profile"),
        tab(t5_user, "Profile"),
      ],
    );
  }
}