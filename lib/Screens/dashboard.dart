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

  final _formKey = GlobalKey<FormState>();
  String nom = "";
  String prenom = "";
  double taille = 0;
  double poids = 0;
  double surfacecorp = 0;

  List<Category> mFavouriteList;
  addPatientSheet(BuildContext aContext) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: aContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: DraggableScrollableSheet(
                initialChildSize: 0.65,
                maxChildSize: 1,
                minChildSize: 0.5,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    padding: EdgeInsets.only(top: 24),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        color: t5LayoutBackgroundWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: t5ViewColor,
                          width: 50,
                          height: 3,
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: GestureDetector(
                              onTap: () => FocusScope.of(context).unfocus(),
                              child: SafeArea(
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 40.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 15),
                                                decoration: boxDecorationT6(
                                                    radius: 12,
                                                    showShadow: true,
                                                    bgColor: t6white),
                                                child: TextFormField(
                                                  style: TextStyle(
                                                    fontSize: textSizeMedium,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            26, 18, 4, 18),
                                                    hintText: "Nom",
                                                    filled: true,
                                                    fillColor: t6white,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: t6white,
                                                              width: 0.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: t6white,
                                                              width: 0.0),
                                                    ),
                                                  ),
                                                  validator: (input) => input
                                                          .trim()
                                                          .isEmpty
                                                      ? 'Svp Entrez le Nom du Patient'
                                                      : null,
                                                  onSaved: (input) =>
                                                      nom = input,
                                                  initialValue: nom,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 15),
                                                decoration: boxDecorationT6(
                                                    radius: 12,
                                                    showShadow: true,
                                                    bgColor: t6white),
                                                child: TextFormField(
                                                  style: TextStyle(
                                                    fontSize: textSizeMedium,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            26, 18, 4, 18),
                                                    hintText: "Prenom",
                                                    filled: true,
                                                    fillColor: t6white,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: t6white,
                                                              width: 0.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: t6white,
                                                              width: 0.0),
                                                    ),
                                                  ),
                                                  validator: (input) => input
                                                          .trim()
                                                          .isEmpty
                                                      ? 'Svp Entrez le Prenom du Patient'
                                                      : null,
                                                  onSaved: (input) =>
                                                      prenom = input,
                                                  initialValue: prenom,
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 15, right: 5),
                                                      decoration:
                                                          boxDecorationT6(
                                                              radius: 12,
                                                              showShadow: true,
                                                              bgColor: t6white),
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                          fontSize:
                                                              textSizeMedium,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                      26,
                                                                      18,
                                                                      4,
                                                                      18),
                                                          hintText: "Poids",
                                                          suffixText: 'kg',
                                                          filled: true,
                                                          fillColor: t6white,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color:
                                                                        t6white,
                                                                    width: 0.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color:
                                                                        t6white,
                                                                    width: 0.0),
                                                          ),
                                                        ),
                                                        validator: (input) => input
                                                                .trim()
                                                                .isEmpty
                                                            ? 'Svp Entrez le Poids du Patient'
                                                            : null,
                                                        onSaved: (input) =>
                                                            poids =
                                                                double.parse(
                                                                    input),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 15, left: 5),
                                                      decoration:
                                                          boxDecorationT6(
                                                              radius: 12,
                                                              showShadow: true,
                                                              bgColor: t6white),
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                          fontSize:
                                                              textSizeMedium,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                      26,
                                                                      18,
                                                                      4,
                                                                      18),
                                                          hintText: "Taille",
                                                          suffixText: 'cm',
                                                          filled: true,
                                                          fillColor: t6white,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color:
                                                                        t6white,
                                                                    width: 0.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color:
                                                                        t6white,
                                                                    width: 0.0),
                                                          ),
                                                        ),
                                                        validator: (input) => input
                                                                .trim()
                                                                .isEmpty
                                                            ? 'Svp Entrez la Taille du Patient'
                                                            : null,
                                                        onSaved: (input) =>
                                                            taille =
                                                                double.parse(
                                                                    input),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
        });
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
              onPressed: () => addPatientSheet(context),
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
