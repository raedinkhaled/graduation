import 'package:flutter/material.dart';
import 'package:graduation/Screens/T5Images.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/Widgets/GridListDashboard.dart';
import 'package:graduation/Widgets/ListModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

    List<Category> mFavouriteList;

  List<Category> getCategoryItems() {
    var list = List<Category>();

    var category1 = Category();
    category1.name = "Rapport fin Journee";
    category1.color = t5Cat1;
    category1.icon = t5_paperplane;
    list.add(category1);
    var category2 = Category();
    category2.name = "Medicaments";
    category2.color = t5Cat2;
    category2.icon = t5_wallet;
    list.add(category2);
    var category3 = Category();
    category3.name = "Relicats";
    category3.color = t5Cat3;
    category3.icon = t5_coupon;
    list.add(category3);
    var category4 = Category();
    category4.name = "Calcul Dose";
    category4.color = t5Cat4;
    category4.icon = t5_invoice;
    list.add(category4);

    var category5 = Category();
    category5.name = "Changer MDP";
    category5.color = t5Cat5;
    category5.icon = t5_dollar_exchange;
    list.add(category5);

    var category = Category();
    category.name = "Deconnexion";
    category.color = t5Cat6;
    category.icon = t5_circle;
    list.add(category);
    return list;
  }

   @override
  void initState() {
    super.initState();
    mFavouriteList = getCategoryItems();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            Container(
              height: 70,
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 16),
                      text("Tableau De Bord",
                          textColor: t5White,
                          fontSize: textSizeNormal,
                          fontFamily: fontMedium)
                    ],
                  ),
                  /* SvgPicture.asset(
                    t5_options,
                    width: 25,
                    height: 25,
                    color: t5White,
                  )*/
                ],
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 100),
              child: Container(
                padding: EdgeInsets.only(top: 28),
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                    color: t5LayoutBackgroundWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: GridListDashboard(mFavouriteList, false),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
  }
}