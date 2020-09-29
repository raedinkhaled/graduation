import 'package:flutter/material.dart';
import 'package:graduation/Screens/T5Images.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/cubit/password_cubit.dart';
import 'package:graduation/cubit/reliquats_cubit.dart';
import 'package:graduation/data/moor_database.dart';

import 'constants.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  String oldPass, newPass, confirmedPass;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final reliquatCubit = context.bloc<ReliquatsCubit>();
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    return Scaffold(
      backgroundColor: t5DarkNavy,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
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
                        text("Changer Mot De Pass",
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
                  alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height - 100,
                  decoration: BoxDecoration(
                      color: t5LayoutBackgroundWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
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
                                      EdgeInsets.fromLTRB(26, 18, 4, 18),
                                  hintText: "Ancien Mot De Pass",
                                  filled: true,
                                  fillColor: t6white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: t6white, width: 0.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: t6white, width: 0.0),
                                  ),
                                ),
                                validator: (input) => input.trim().isEmpty
                                    ? 'Svp Entrez lancien mdp'
                                    : null,
                                onSaved: (input) => oldPass = input,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
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
                                      EdgeInsets.fromLTRB(26, 18, 4, 18),
                                  hintText: "Nouveau mot de pass",
                                  filled: true,
                                  fillColor: t6white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: t6white, width: 0.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: t6white, width: 0.0),
                                  ),
                                ),
                                validator: (input) => input.trim().isEmpty
                                    ? 'Svp Entrez le nouveau mdp'
                                    : null,
                                onSaved: (input) => newPass = input,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
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
                                      EdgeInsets.fromLTRB(26, 18, 4, 18),
                                  hintText: "Confirmer mdp",
                                  filled: true,
                                  fillColor: t6white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: t6white, width: 0.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: t6white, width: 0.0),
                                  ),
                                ),
                                validator: (input) => input.trim().isEmpty
                                    ? 'Svp Entrez le mdp confirme'
                                    : null,
                                onSaved: (input) => confirmedPass = input,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              height: 60.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: t5ColorPrimaryDark,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: FlatButton(
                                child: Text(
                                  'Changer mot de pass',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                  }
                                  final passwordCubit =
                                      context.bloc<PasswordCubit>();
                                  if (passwordCubit.checkedPass(oldPass) &&
                                      newPass == confirmedPass) {
                                    passwordCubit.dao.updatePassword(
                                        Password(pass: newPass, passid: 1));
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            elevation: 0.0,
                                            backgroundColor: Colors.transparent,
                                            child: Container(
                                                decoration: new BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 10.0,
                                                      offset: const Offset(
                                                          0.0, 10.0),
                                                    ),
                                                  ],
                                                ),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize
                                                      .min, // To make the card compact
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16),
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  t1TextColorPrimary)),
                                                    ),
                                                    text("Succès!",
                                                        textColor: Colors.green,
                                                        fontFamily: fontBold,
                                                        fontSize:
                                                            textSizeLarge),
                                                    SizedBox(height: 24),
                                                    Image.asset(
                                                      t1_ic_dialog,
                                                      color: Colors.green,
                                                      width: 95,
                                                      height: 95,
                                                    ),
                                                    SizedBox(height: 24),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16,
                                                              right: 16),
                                                      child: text(
                                                          "Votre mot de passe à été changé avec succès!",
                                                          fontSize:
                                                              textSizeMedium,
                                                          maxLine: 2,
                                                          isCentered: true),
                                                    ),
                                                    SizedBox(height: 30),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(16),
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 10, 0, 10),
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: t5ColorPrimary,
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: text("Fermer",
                                                            textColor: t1_white,
                                                            fontFamily:
                                                                fontMedium,
                                                            fontSize:
                                                                textSizeNormal),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          );
                                        });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
