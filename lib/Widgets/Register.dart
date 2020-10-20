import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:myfirstflutterapp/Widgets/FormCard.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
enum FileType {
  ANY,
  IMAGE,
  VIDEO,
  CAMERA,
  CUSTOM,
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String errorMessage = '';
  String successMessage = '';
  String _filePath;

  //static const MethodChannel _channel = const MethodChannel('file_picker');
  static const String _tag = 'FilePicker';
  String _fileName = '...';
  String _path = '...';
  String _extension;
  bool _hasValidMime = false;
  FileType _pickingType;
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //TODO update what details you want
    //test feild state
    String email = "";
    String password = "";
    String name = "";
    String city = "";
    String phonenumber = "";

    //for showing loading
    bool loading = false;

    // this below line is used to make notification bar transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            //TODO update this
            'assets/image_01.jpg',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [
              Colors.black.withOpacity(.9),
              Colors.black.withOpacity(.1),
            ])),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 27.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  //TODO update this
                  'Join Mr BookWorm!',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 22,
                              width: 22,
                              child: Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white70)),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                ),
                //city
                SizedBox(
                  height: 16,
                ),
                //TODO remove unwanted containers
                Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 22,
                              width: 22,
                              child: Icon(
                                Icons.home,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'City',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white70)),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                ),
                //phonenumber
                SizedBox(
                  height: 16,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 22,
                              width: 22,
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Mobile Number',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white70)),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                ),
                //college
                SizedBox(
                  height: 16,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 22,
                              width: 22,
                              child: Icon(
                                Icons.school,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'College',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white70)),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 22,
                              width: 22,
                              child: Icon(
                                Icons.vpn_key,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Center(
                      child: Text(
                    'Register',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )),
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Center(
                      child: Text(
                    "Already have an account",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
                ),
                InkWell(
                  onTap: () {
                    //  save();
                    //getFilePath();
                    cred();
                    /*signUp().then((user) {
                      if (user != null) {
                        print('Registered Successfully.');
                        setState(() {
                          successMessage = 'Registered Successfully.\nYou can now navigate to Login Page.';
                        });
                      } else {
                        print('Error while Login.');
                      }
                    });*/
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Center(
                        child: Text(
                      "Login",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /**********normal service*****************/
  save() async {
    String email = FormCard.emailController.text.toString().trim().toLowerCase();
    String password = FormCard.passwordController.text.toString().trim().toLowerCase();
    final response = await http.post("http://domain.com/regisapi.php",
        body: {"name": "$email", "email": "$email", "mobile": "1236547890", "password": "$password"});

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      print(message);
    } else if (value == 2) {
      print(message);
    } else {
      print(message);
    }
  }

  cred() async {
    String email = 'ze@gmail.com'; //FormCard.emailController.text.toString().trim().toLowerCase();
    String password = '1234567'; //FormCard.passwordController.text.toString().trim().toLowerCase();
    String em = FormCard.emailController.text.toString();
    print("$em");
    print("$email");
    print('fffdddddf');
    await Firebase.initializeApp();
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: "$email", password: password).then((result) => {
          print(result.user.email),
          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(), (_) => false),
        });
  }

  /*******************Firebase service***********************/
  // ignore: deprecated_member_use
  Future<FirebaseUser> signUp() async {
    try {
      String email = 'qqq@gmail.com'; //FormCard.emailController.text.toString().trim().toLowerCase();
      String password = '1234567'; //FormCard.passwordController.text.toString().trim().toLowerCase();
      print(email);
      print('ffff');
      await Firebase.initializeApp();
      // ignore: deprecated_member_use
      FirebaseUser user =
          // ignore: deprecated_member_use
          (await auth.createUserWithEmailAndPassword(email: email, password: password)) as FirebaseUser;
      print(user.email);
      assert(user != null);
      assert(await user.getIdToken() != null);

      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        setState(() {
          errorMessage = 'Email Id already Exist!!!';
        });
        break;
      default:
    }
  }

/* void pick() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      setState(() {
        this._filePath = filePath;
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }*/
/*static Future<String> _getPath(String type) async {
    try {
      return await _channel.invokeMethod(type);
    } on PlatformException catch (e) {
      print("[$_tag] Platform exception: " + e.toString());
    } catch (e) {
      print(
          "[$_tag] Unsupported operation. This probably have happened because [${type.split('_').last}] is an unsupported file type. You may want to try FileType.ALL instead.");
    }
    return null;
  }

  static Future<String> _getImage(ImageSource type) async {
    try {
      var image = await ImagePicker.pickImage(source: type);
      return image?.path;
    } on PlatformException catch (e) {
      print("[$_tag] Platform exception: " + e.toString());
    }
    return null;
  }

  static Future<Map<String, dynamic>> getFilePath({FileType type = FileType.ANY, String fileExtension}) async {
    switch (type) {
      case FileType.IMAGE:
        final result = await _getImage(ImageSource.gallery);
        return <String, String>{'path': result};
      case FileType.CAMERA:
        final result = await _getImage(ImageSource.camera);
        return <String, String>{'path': result};
      case FileType.VIDEO:
        final result = await _channel.invokeMethod('VIDEO');
        return Map<String, dynamic>.from(result);
      case FileType.ANY:
        final result = await _getPath('ANY');
        return <String, String>{'path': result};
      case FileType.CUSTOM:
        final result = await _getPath('__CUSTOM_' + (fileExtension ?? ''));
        return <String, String>{'path': result};
      default:
        final result = await _getPath('ANY');
        return <String, String>{'path': result};
    }
  }*/

/*void _openFileExplorer() async {
    if (_pickingType != FileType.CUSTOM || _hasValidMime) {
      try {
        final Map<String, dynamic> result =
            await FilePicker.getFilePath(type: _pickingType, fileExtension: _extension);
        _path = result['path'];
        print(result);
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }

      if (!mounted) return;

      setState(() {
        _fileName = _path != null ? _path.split('/').last : '...';
      });
    }
  }*/
}
