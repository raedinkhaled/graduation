import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation/Screens/Reliquats.dart';
import 'package:graduation/Screens/calculDose.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/Widgets/ListModel.dart';

class GridListDashboard extends StatelessWidget {
  List<Category> mFavouriteList;
  var isScrollable = false;

  GridListDashboard(this.mFavouriteList, this.isScrollable);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        scrollDirection: Axis.vertical,
        physics: isScrollable ? ScrollPhysics() : NeverScrollableScrollPhysics(),
        itemCount: mFavouriteList.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if(index == 3){
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CalculDose(),
                ),
              );
              }
              else if(index == 2){
                {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Reliquats(),
                ),
              );
              }
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: boxDecoration(radius: 10, showShadow: true, bgColor: t5White),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: width / 7.5,
                    width: width / 7.5,
                    margin: EdgeInsets.only(bottom: 4, top: 8),
                    padding: EdgeInsets.all(width / 30),
                    decoration: boxDecoration(bgColor: mFavouriteList[index].color, radius: 10),
                    child: SvgPicture.asset(
                      mFavouriteList[index].icon,
                      color: t5White,
                    ),
                  ),
                  text(mFavouriteList[index].name, fontSize: textSizeMedium)
                ],
              ),
            ),
          );
        });
  }
}