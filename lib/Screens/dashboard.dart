import 'package:flutter/material.dart';
import 'package:graduation/Screens/Patients.dart';
import 'package:graduation/Screens/T5Images.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/extensions.dart';
import 'package:graduation/Screens/home.dart';
import 'package:graduation/Widgets/BottomBar.dart';
import 'package:graduation/Widgets/BubbleBottomBar.dart';
import 'package:graduation/Widgets/GridListDashboard.dart';
import 'package:graduation/Widgets/ListModel.dart';
import 'package:graduation/cubit/patient_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();

}

class _DashboardState extends State<Dashboard> {
  var selectedIndex = 0;
  var pages = [
    Home(),
    Patients(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  changeMyState(BuildContext context){
        final patientCubit = context.bloc<PatientCubit>();
        patientCubit.moveStateToAdd();

  }


  @override
  Widget build(BuildContext context) {
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      floatingActionButton: selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () => changeMyState(context),
              child: Icon(Icons.add),
              backgroundColor: t5DarkNavy,
            )
          : null,
      backgroundColor: t5DarkNavy,
      key: _scaffoldKey,
      body: SafeArea(child: pages[selectedIndex]),
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: selectedIndex,
        elevation: 8,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
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
      ),
    );
  }
}
