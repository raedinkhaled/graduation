import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:graduation/Screens/calculDoseAvecReliquat.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/extensions.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/cubit/reliquats_cubit.dart';
import 'package:graduation/data/moor_database.dart';
import 'package:intl/intl.dart';

class Reliquats extends StatefulWidget {
  @override
  _ReliquatsState createState() => _ReliquatsState();
}

class _ReliquatsState extends State<Reliquats> {
  bool showPerime = false;

  @override
  Widget build(BuildContext context) {
    final reliquatCubit = context.bloc<ReliquatsCubit>();
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    return Scaffold(
      backgroundColor: t5DarkNavy,
      body: SafeArea(
        child: Stack(
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
                      text("Les Reliquats",
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
                    text("Afficher les Reliquats Perimes",
                        isCentered: true,
                        textColor: t5DarkRed,
                        fontFamily: fontBold),
                    Switch(
                      value: showPerime,
                      activeColor: t5DarkRed,
                      onChanged: (newValue) {
                        setState(() {
                          showPerime = newValue;
                        });
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: BlocBuilder<ReliquatsCubit, ReliquatsState>(
                          builder: (context, state) {
                            if (state is ReliquatsInitial) {
                              return StreamBuilder(
                                stream: showPerime
                                    ? reliquatCubit.reliquatDao
                                        .watchAllReliquatsExpired()
                                    : reliquatCubit.reliquatDao
                                        .watchAllReliquats(),
                                builder: (context,
                                    AsyncSnapshot<List<ReliquatWithMedics>>
                                        snapshot) {
                                  final reliquats = snapshot.data ?? List();
                                  return ListView.builder(
                                    itemCount: reliquats.length,
                                    itemBuilder: (_, index) {
                                      final itemReliquat = reliquats[index];
                                      return Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        secondaryActions: <Widget>[
                                          IconSlideAction(
                                            caption: 'Supprimer',
                                            color: Colors.red,
                                            icon: Icons.delete,
                                            onTap: () => reliquatCubit
                                                .reliquatDao
                                                .deleteReliquat(
                                                    itemReliquat.reliquat),
                                          )
                                        ],
                                        actions: itemReliquat.reliquat.date.isAfter(DateTime.now()) ? <Widget>[
                                          IconSlideAction(
                                              caption: 'Utiliser',
                                              color: t5ColorPrimary,
                                              icon: Icons.add_circle,
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        CalculDoseAvecReliquat(
                                                      selectedReliquat:
                                                          itemReliquat,
                                                    ),
                                                  ),
                                                );
                                              })
                                        ]: null,
                                        child: buildReliquat(
                                          context,
                                          itemReliquat,
                                          reliquatCubit.reliquatDao,
                                          reliquats.length,
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                            return StreamBuilder(
                              stream: showPerime
                                  ? reliquatCubit.reliquatDao
                                      .watchAllReliquatsExpired()
                                  : reliquatCubit.reliquatDao
                                      .watchAllReliquats(),
                              builder: (context,
                                  AsyncSnapshot<List<ReliquatWithMedics>>
                                      snapshot) {
                                final reliquats = snapshot.data ?? List();
                                return ListView.builder(
                                  itemCount: reliquats.length,
                                  itemBuilder: (_, index) {
                                    final itemReliquat = reliquats[index];
                                    return Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      actions: itemReliquat.reliquat.date.isAfter(DateTime.now()) ? <Widget>[
                                        IconSlideAction(
                                            caption: 'Utiliser',
                                            color: t5ColorPrimary,
                                            icon: Icons.add_circle,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      CalculDoseAvecReliquat(
                                                    selectedReliquat:
                                                        itemReliquat,
                                                  ),
                                                ),
                                              );
                                            })
                                      ]: null,
                                      secondaryActions: <Widget>[
                                        IconSlideAction(
                                          caption: 'Supprimer',
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () => reliquatCubit.reliquatDao
                                              .deleteReliquat(
                                                  itemReliquat.reliquat),
                                        )
                                      ],
                                      child: buildReliquat(
                                        context,
                                        itemReliquat,
                                        reliquatCubit.reliquatDao,
                                        reliquats.length,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildReliquat(BuildContext context, ReliquatWithMedics itemReliquat,
    ReliquatDao reliquatDao, int value) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      children: <Widget>[
        Container(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 12),
            child: ListTile(
              title: Text(
                '${itemReliquat.medic.medicNom} ${itemReliquat.reliquat.quantite.toStringAsFixed(2)} ml',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: textSizeMedium),
              ),
              subtitle: Text(
                  'Expire le ${DateFormat('dd-MM-yyyy • H:m').format(itemReliquat.reliquat.date)}'),
              trailing: itemReliquat.reliquat.date.isBefore(DateTime.now())
                  ? text("Perimé", textColor: t5DarkRed)
                  : null,
            ),
          ),
        ),
      ],
    ),
  );
}
