import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/dashboard.dart';
import 'package:graduation/Screens/extensions.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/cubit/password_cubit.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passwordController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    context.bloc<PasswordCubit>().initializePass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    const t5_login = "images/t5_login.png";
    changeStatusColor(t5White);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(t5_login, width: width / 2.5, height: width / 2.5),
              text("Bienvenue sur Medicalc",
                  textColor: t5TextColorPrimary,
                  fontFamily: fontBold,
                  fontSize: 22.0),
              Container(
                margin: EdgeInsets.all(24),
                decoration: boxDecoration(
                    bgColor: t5White, showShadow: true, radius: 4),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10),
                    EditText(
                        hint: "Mot de pass",
                        isSecure: true,
                        mController: passwordController),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              final passwordCubit =
                                  context.bloc<PasswordCubit>();
                              passwordCubit.checkPass(passwordController.text);
                              if (BlocProvider.of<PasswordCubit>(context)
                                  .isCorrectPass) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()),
                                );
                              }else{
                               _scaffoldKey.currentState.showSnackBar(SnackBar(content: (Text("Mot De Pass Incorrecte!")),));
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: width / 8,
                              child: text("Connectez Vous",
                                  textColor: t5White, isCentered: true),
                              decoration: boxDecoration(
                                  bgColor: t5ColorPrimary, radius: 8),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
