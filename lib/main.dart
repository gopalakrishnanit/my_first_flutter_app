import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:myfirstflutterapp/DataTableDemo.dart';
import 'package:myfirstflutterapp/Widgets/OtpScreen.dart';
import 'package:myfirstflutterapp/Widgets/Register.dart';

import 'CustomIcons.dart';
import 'Widgets/FormCard.dart';
import 'Widgets/SocialIcon.dart';
import 'Widgets/navigation.dart';
import 'chat/login.dart';
import 'util/app_localization.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
      debugShowCheckedModeBanner: false,
      routes: {
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/otpscreen': (context) => OtpScreen(),
        '/homeScreen': (BuildContext ctx) => LoginScreen(),
      },
      supportedLocales: [
        Locale('fa', 'IR'),
        Locale('en', 'US'),
      ],
      //This delegates make sure that the localization data for the proper language is loader.
      localizationsDelegates: [
        //A class which loads the translations from JSON files.
        AppLocalizations.delegate,
        //Built-in localization of basic text for Material Widget.
        GlobalMaterialLocalizations.delegate,
        //Built-in localization for text direction LTR/RTL.
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSelected = false;
  Position _currentPosition;
  String _currentAddress;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
      _getCurrentLocation();
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
    ScreenUtil.instance = ScreenUtil.getInstance()
      ..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    String language = Localizations
        .localeOf(context)
        .languageCode;
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
                          Text(AppLocalizations.of(context).translate('Remember_me'),
                              style: TextStyle(fontSize: 12, fontFamily: "Poppins-Medium"))
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
                          mains();
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
                        onPressed: () {
                          // Navigator.pop(context);
                          setState(() {});
                          //(context as Element).reassemble();
                        },
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

  _getCurrentLocation() {
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p =
      await geolocator.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
      print(_currentPosition.latitude);
      print(_currentPosition.longitude);
      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}, ${place.subLocality}, ${place
            .administrativeArea}, ${place.subAdministrativeArea}, ${place.thoroughfare}, ${place.subThoroughfare}";
        print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }

  mains() async {
    print('ssdsfsdfsdfsdfsf');
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(title: "ss")));
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

/********************Intro screen*********************************/
/*class IntroScreen extends StatefulWidget {
  final List<OnbordingData> onbordingDataList;
  final MaterialPageRoute pageRoute;

  IntroScreen(onbordingDataList, pageRoute);

  void skipPage(BuildContext context) {
    Navigator.push(context, pageRoute);
  }

  @override
  IntroScreenState createState() {
    return new IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = new PageController();
  int currentPage = 0;
  bool lastPage = false;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      if (currentPage == widget.onbordingDataList.length - 1) {
        lastPage = true;
      } else {
        lastPage = false;
      }
    });
  }

  Widget _buildPageIndicator(int page) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: page == currentPage ? 10.0 : 6.0,
      width: page == currentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: page == currentPage ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: new Color(0xFFEEEEEE),
      padding: const EdgeInsets.all(10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(),
          ),
          new Expanded(
            flex: 3,
            child: new PageView(
              children: widget.onbordingDataList,
              controller: controller,
              onPageChanged: _onPageChanged,
            ),
          ),
          new Expanded(
            flex: 1,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new FlatButton(
                  child: new Text(lastPage ? "" : "SKIP",
                      style: new TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0)),
                  onPressed: () => lastPage
                      ? null
                      : widget.skipPage(
                          context,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    child: Row(
                      children: [
                        _buildPageIndicator(0),
                        _buildPageIndicator(1),
                        _buildPageIndicator(2),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  child: new Text(lastPage ? "GOT IT" : "NEXT",
                      style: new TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0)),
                  onPressed: () => lastPage
                      ? widget.skipPage(context)
                      : controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
