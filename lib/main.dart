import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:myfirstflutterapp/DataTableDemo.dart';
import 'package:myfirstflutterapp/Widgets/OtpScreen.dart';
import 'package:myfirstflutterapp/Widgets/Register.dart';

import 'CustomIcons.dart';
import 'Widgets/FormCard.dart';
import 'Widgets/SocialIcon.dart';
import 'Widgets/navigation.dart';
import 'chat/login.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      routes: {
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/otpscreen': (context) => OtpScreen(),
        '/homeScreen': (BuildContext ctx) => LoginScreen(),
      },
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/image_01.png"),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(child: Image.asset("assets/image_02.png"))
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/logo.png",
                        width: ScreenUtil.getInstance().setWidth(110),
                        height: ScreenUtil.getInstance().setHeight(110),
                      ),
                      Text("LOGO",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(46),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  FormCard(),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          GestureDetector(
                            onTap: _radio,
                            child: radioButton(_isSelected),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text("Remember me", style: TextStyle(fontSize: 12, fontFamily: "Poppins-Medium"))
                        ],
                      ),
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                // loginData();
                                print("click");
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => navigation()));
                              },
                              child: Center(
                                child: Text("SIGNIN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      Text("Social Login", style: TextStyle(fontSize: 16.0, fontFamily: "Poppins-Medium")),
                      horizontalLine()
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        colors: [
                          Color(0xFF102397),
                          Color(0xFF187adf),
                          Color(0xFF00eaf8),
                        ],
                        iconData: CustomIcons.facebook,
                        onPressed: () {
                          print("fb");
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataTableDemo()));
                        },
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFFff4f38),
                          Color(0xFFff355d),
                        ],
                        iconData: CustomIcons.googlePlus,
                        onPressed: () {
                          print("sdfgg");
                          mains();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF17ead9),
                          Color(0xFF6078ea),
                        ],
                        iconData: CustomIcons.twitter,
                        onPressed: () {
                          clickOnLogin(context);
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen()));
                        },
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF00c6fb),
                          Color(0xFF005bea),
                        ],
                        iconData: CustomIcons.linkedin,
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "New User? ",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register()));
                        },
                        child: Text("SignUp", style: TextStyle(color: Color(0xFF5d74e3), fontFamily: "Poppins-Bold")),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  mains() async {
    print('ssdsfsdfsdfsdfsf');
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  loginData() async {
    String myUrl = "http://realboxapp.com/task/loginapi.php";
    String email = FormCard.emailController.text.toString().trim().toLowerCase();
    String password = FormCard.passwordController.text.toString().trim().toLowerCase();
    print(password);
    final response = await http
        .post(myUrl, headers: {'Accept': 'application/json'}, body: {"username": "$email", "password": "$password"});
    var status = response.body.contains('error');
    print(status);
    var data = json.decode(response.body.toString().trim());
    print(data);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register()));
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataTableDemo()));
    }
  }
}

Future<void> clickOnLogin(BuildContext context) async {
  var _dialCode = '+91';
  if (FormCard.emailController.text
      .toString()
      .trim()
      .isEmpty) {
    showErrorDialog(context, 'Contact number can\'t be empty.');
  } else {
    print(FormCard.emailController.text.toString().trim().toLowerCase());
    final responseMessage = await Navigator.pushNamed(context, '/otpscreen',
        arguments: '$_dialCode${FormCard.emailController.text.toString().trim()}');
    if (responseMessage != null) {
      showErrorDialog(context, responseMessage as String);
    } else
      showErrorDialog(context, responseMessage as String);
  }
}

//Alert dialogue to show error and response
void showErrorDialog(BuildContext context, String message) {
  // set up the AlertDialog
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: const Text('Error'),
    content: Text('\n$message'),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        child: const Text('Yes'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
