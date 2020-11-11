import 'dart:async';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfirstflutterapp/Widgets/Dashboard.dart';
import 'package:myfirstflutterapp/Widgets/Mapview.dart';
import 'package:myfirstflutterapp/Widgets/Multipickimage.dart';
import 'package:myfirstflutterapp/Widgets/Stripepayment.dart';
import 'package:myfirstflutterapp/Widgets/Webview.dart';
import 'package:myfirstflutterapp/chat/login.dart';
import 'package:myfirstflutterapp/map/Livelocation.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

import 'fryo_icon.dart';

class Navigation extends StatefulWidget {
  @override
  _Navigationstate createState() => _Navigationstate();
}

class _Navigationstate extends State<Navigation> {
  String _timeString;

//  Timer _timer;
  int _start = 50;
  int endTime = DateTime.now().millisecondsSinceEpoch + 10000 * 60;

  @override
  void initState() {
    super.initState();

    startTimers();
    // startTimer();
    _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    //print("navig $_timeString");
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
  }

  var padding = new Padding(
    padding: EdgeInsets.all(5.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation Drawer"),
        // leading: Image.asset("assets/image_01.png"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
          IconButton(icon: Icon(Icons.message), onPressed: () {}),
        ],
      ),
      backgroundColor: Colors.white,
      body: new ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            child: Text(
              _timeString,
              //"$_start",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
            ),
          ),
          CountdownTimer(
            endTime: endTime,
            widgetBuilder: (BuildContext context, CurrentRemainingTime time) {
              List<Widget> list = [];
              if (time.days != null) {
                list.add(Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_dissatisfied),
                    Text(time.days.toString()),
                  ],
                ));
              }
              if (time.hours != null) {
                list.add(Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_satisfied),
                    Text(time.hours.toString()),
                  ],
                ));
              }
              if (time.min != null) {
                list.add(Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_very_dissatisfied),
                    Text(time.min.toString()),
                  ],
                ));
              }
              if (time.sec != null) {
                list.add(Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_very_satisfied),
                    Text(time.sec.toString()),
                  ],
                ));
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: list,
              );
            },
          ),
          new Material(
            elevation: 10.0,
            child: Container(
                height: 150.0,
                width: double.infinity,
                child: Carousel(
                  images: [
                    Image.asset(
                      "assets/image_02.png",
                      height: 150,
                      width: double.infinity,
                    ),
                    Image.asset(
                      "assets/image_01.png",
                      height: 150,
                      width: double.infinity,
                    ),
                    Image.asset(
                      "assets/logo.png",
                      height: 150,
                      width: double.infinity,
                    ),
                  ],
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.purple,
                  indicatorBgPadding: 5.0,
                  dotBgColor: Colors.black54.withOpacity(0.2),
                  borderRadius: true,
                  radius: Radius.circular(20),
                  moveIndicatorFromBottom: 180.0,
                  noRadiusForIndicator: true,
                )),
          ),
          padding,
          headerTopCategories(),
          padding,
          new Material(
            elevation: 10.0,
            child: new HorizontalList("Fruits & Vegetables - Best Offers", fruitsVegetables),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _settingModalBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text("guest@Gmail.com"),
              accountName: Text("Guest"),
              currentAccountPicture: CircleAvatar(
                child: Text("CM"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              onTap: () {
                print('dash');
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard()));
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Categories"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.add_to_photos),
              title: Text("Add Items"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.web_rounded),
              title: Text("Webview"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Webview()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About Us"),
              onTap: () {},
            ),
            ListTile(
                leading: Icon(Icons.share),
                title: Text("Share with Friends"),
                onTap: () {
                  List<String> colorList = ['Image', 'Text', 'Image & Text'];
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Favorite Color'),
                          content: Container(
                            width: double.minPositive,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: colorList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(colorList[index]),
                                  onTap: () {
                                    Navigator.pop(context, colorList[index]);
                                    if (colorList[index] == 'Image') _shareImage();
                                    if (colorList[index] == 'Text') _shareText();
                                    if (colorList[index] == 'Image & Text') _shareImageAndText();
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      });
                }),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text("Rate and Review"),
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true, // set to false if you want to force a rating
                    builder: (context) {
                      return RatingDialog(
                        icon: ImageIcon(
                          AssetImage("assets/image_01.png"),
                          size: 100,
                        ),
                        /*icon: const Icon(
                          Icons.star,
                          size: 100,
                          color: Colors.blue,
                        ),*/
                        // set your own image/icon widget
                        title: "Flutter Rating Dialog",
                        description: "Tap a star to give your rating.",
                        submitButton: "SUBMIT",
                        alternativeButton: "Contact us instead?",
                        // optional
                        positiveComment: "We are so happy to hear 😍",
                        // optional
                        negativeComment: "We're sad to hear 😭",
                        // optional
                        accentColor: Colors.blue,
                        // optional
                        onSubmitPressed: (int rating) {
                          print("onSubmitPressed: rating = $rating");
                          // TODO: open the app's page on Google Play / Apple App Store
                        },
                        onAlternativePressed: () {
                          print("onAlternativePressed: do something");
                          // TODO: maybe you want the user to contact you instead of rating a bad review
                        },
                      );
                    });
              },
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text("Map"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Mapview()));
              },
            ),
            RichText(
              text: TextSpan(
                text: 'Can you ',
                style: TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'find the',
                    style: TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                    //recognizer: _longPressRecognizer,
                  ),
                  TextSpan(text: 'secret?'),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.pin_drop),
              title: Text("Live Location"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text("Payment"),
              onTap: () {
                print('pay');
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text("Stripe Payment"),
              onTap: () {
                print('pay');
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Stripepayment()));
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text("Privacy Policy"),
              onTap: () {
                print('dssdf');
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text("ImagePick"),
              onTap: () {
                print('ssdf');
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Multipickimage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionHeader(String headerTitle, {onViewMore}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 10),
          child: Text(
            headerTitle,
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, top: 2),
          child: FlatButton(
            onPressed: onViewMore,
            child: Text('View all ›', style: TextStyle(color: Colors.orange, fontFamily: 'Poppins')),
          ),
        )
      ],
    );
  }

  Widget headerCategoryItem(String name, IconData icon, {onPressed}) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 86,
              height: 86,
              child: FloatingActionButton(
                shape: CircleBorder(),
                heroTag: name,
                onPressed: onPressed,
                backgroundColor: Colors.white,
                child: Icon(icon, size: 35, color: Colors.black87),
              )),
          Text(name + ' ›', style: TextStyle(color: Colors.orange, fontFamily: 'Poppins'))
        ],
      ),
    );
  }

  Widget headerTopCategories() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sectionHeader('All Categories', onViewMore: () {}),
        SizedBox(
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[
              headerCategoryItem('Frieds', Fryo.dinner, onPressed: () {
                print('frieds');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Not in stock'),
                      content: const Text('This item is no longer available'),
                      actions: [
                        FlatButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
              headerCategoryItem('Fast Food', Fryo.food, onPressed: () {
                /*final channelName = 'wingquest.stablekernel.io/speech';

                final methodChannel = MethodChannel(channelName);
                methodChannel.setMethodCallHandler(this._didRecieveTranscript);
                print('sfsa');*/
              }),
              headerCategoryItem('Creamery', Fryo.poop, onPressed: () {}),
              headerCategoryItem('Hot Drinks', Fryo.coffee_cup, onPressed: () {}),
              headerCategoryItem('Vegetables', Fryo.leaf, onPressed: () {}),
            ],
          ),
        )
      ],
    );
  }

  void _getCurrentTime() {
    if (this.mounted) {
      setState(() {
        _timeString =
        "${DateTime
            .now()
            .year} : ${DateTime
            .now()
            .month
            .toString()
            .padLeft(2, '0')} : ${DateTime
            .now()
            .day
            .toString()
            .padLeft(2, '0')}  ${DateTime
            .now()
            .hour
            .toString()
            .padLeft(2, '0')} : ${DateTime
            .now()
            .minute
            .toString()
            .padLeft(2, '0')} :${DateTime
            .now()
            .second
            .toString()
            .padLeft(2, '0')}";
      });
    }
  }

  void startTimers() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
                () {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start = _start - 1;
              }
            },
          ),
    );
  }
}

///********horizontal category***************/
class HorizontalList extends StatelessWidget {
  final heading;
  final ids;

  HorizontalList(this.heading, this.ids);

  @override
  Widget build(BuildContext context) {
    var items = <Widget>[];
    items.add(new Padding(
      padding: EdgeInsets.all(3.0),
    ));
    ids.forEach((id) => items.add(new Item(id)));
    items.add(new Padding(
      padding: EdgeInsets.all(3.0),
    ));

    return new Container(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: new Column(
        children: <Widget>[
          new Container(
            // color: Colors.black,
            padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Text(
                    heading,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                new RaisedButton(
                  child: new Text("See all"),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    print("See all");
                  },
                )
              ],
            ),
          ),
          new Divider(
            height: 5.0,
          ),
          // new Divider(),
          new SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: new Row(
              children: items,
            ),
          ),
        ],
      ),
    );
  }
}

class Item extends StatefulWidget {
  final id;

  Item(this.id);

  @override
  State<StatefulWidget> createState() {
    return new ItemState(id);
  }
}

class ItemState extends State<Item> {
  final id;

  ItemState(this.id);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var price = (items[id]["variants"] as Map)[1]["price"];
    var sale = (items[id]["variants"] as Map)[1]["sale"];
    var off = ((price - sale) / price) * 100;
    return new Container(
      width: width * 0.5,
      child: new Card(
        child: new Container(
          padding: new EdgeInsets.all(width * 0.025),
          child: new Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new Image.network(
                    items[id]["image"],
                    width: width * 0.4,
                  ),
                  (price == sale)
                      ? new Text("")
                      : new Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: new BoxDecoration(
                              border: new Border.all(color: Colors.lightGreen, width: width * 0.00625),
                              color: Colors.lightGreen[100]),
                          child: new Text(
                            off.round().toString() + "% OFF",
                            style: new TextStyle(fontSize: width * 0.03),
                          ),
                        ),
                ],
              ),
              new Container(
                height: width * 0.11,
                child: new Column(
                  children: <Widget>[
                    new Text(
                      items[id]["name"],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: new TextStyle(fontSize: width * 0.045),
                    ),
                  ],
                ),
              ),
              new Text(
                (items[id]["variants"] as Map)[1]["quantity"],
                style: new TextStyle(color: Colors.grey),
              ),
              new Container(
                padding: new EdgeInsets.only(top: width * 0.022),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "₹" + (items[id]["variants"] as Map)[1]["sale"].toString(),
                      style: new TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.05),
                    ),
                    (price == sale)
                        ? new Text("")
                        : Padding(
                            padding: new EdgeInsets.all(width * 0.022),
                          ),
                    (price == sale)
                        ? new Text("")
                        : Container(
                            foregroundDecoration: new StrikeThroughDecoration(),
                            child: new Text(
                              "₹" + (items[id]["variants"] as Map)[1]["price"].toString(),
                              style: new TextStyle(fontSize: width * 0.05, color: Colors.grey),
                            ))
                  ],
                ),
              ),
              new Container(
                padding: new EdgeInsets.only(top: width * 0.022),
                child: ((items[id]["variants"] as Map)[1]["amount"] == 0)
                    ? new Row(
                        children: <Widget>[
                          new Expanded(
                              child: new RaisedButton(
                            onPressed: () {
                              setState(() {
                                (items[id]["variants"] as Map)[1]["amount"] = 1;
                              });
                              cart.add(id);
                              server.simulateMessage(cart.length.toString());
                            },
                            child: new Text("Add To Cart"),
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                          ))
                        ],
                      )
                    : new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Container(
                            width: width * 0.16,
                            child: new RaisedButton(
                              onPressed: () => setState(() {
                                (items[id]["variants"] as Map)[1]["amount"] += 1;
                              }),
                              child: new Text(
                                "+",
                                style: new TextStyle(fontSize: width * 0.07),
                              ),
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                            ),
                          ),
                          new Container(
                            width: width * 0.1,
                            child: new Text(
                              (items[id]["variants"] as Map)[1]["amount"].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          new Container(
                            width: width * 0.16,
                            child: new RaisedButton(
                              onPressed: () {
                                setState(() {
                                  (items[id]["variants"] as Map)[1]["amount"] -= 1;
                                });
                                if ((items[id]["variants"] as Map)[1]["amount"] == 0) {
                                  cart.remove(id);
                                  server.simulateMessage(cart.length.toString());
                                }
                              },
                              child: new Text(
                                "-",
                                style: new TextStyle(fontSize: width * 0.07),
                              ),
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StrikeThroughDecoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return new _StrikeThroughPainter();
  }
}

class _StrikeThroughPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = new Paint()
      ..strokeWidth = 1.0
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final rect = offset & configuration.size;
    canvas.drawLine(
        new Offset(rect.left, rect.top + rect.height / 2), new Offset(rect.right, rect.top + rect.height / 2), paint);
    canvas.restore();
  }
}

class Server {
  StreamController<String> _controller = new StreamController.broadcast();

  void simulateMessage(String message) {
    _controller.add(message);
  }

  Stream get messages => _controller.stream;
}

final server = new Server();

var cart = Set();

var fruitsVegetables = Set.from([1, 2, 3, 4, 5, 6, 7, 8]);

var items = {
  1: {
    "name": "New Potato - Onion - Tomato (Hybrid)",
    "image": "https://cdn.grofers.com/app/images/products/normal/pro_369752.jpg",
    "variants": {
      1: {"quantity": "1 unit (1.75-2.75 kg)", "price": 30, "sale": 25, "amount": 0}
    }
  },
  2: {
    "name": "Safeda Mango",
    "image": "https://cdn.grofers.com/app/images/products/normal/pro_388616.jpg",
    "variants": {
      1: {"quantity": "6 units", "price": 180, "sale": 144, "amount": 0},
      // 2: {
      //   "quantity": "3 units",
      //   "price": 90,
      //   "sale": 80
      // }
    }
  },
  3: {
    "name": "Cucumber",
    "image": "https://cdn.grofers.com/app/images/products/normal/pro_240845.jpg",
    "variants": {
      1: {"quantity": "1 kg", "price": 20, "sale": 20, "amount": 0}
    }
  },
  4: {
    "name": "Large Round Brinjal (Bharta)",
    "image": "https://cdn.grofers.com/app/images/products/normal/pro_372347.jpg",
    "variants": {
      1: {"quantity": "500 - 700 gm", "price": 26, "sale": 26, "amount": 0}
    }
  },
  5: {
    "name": "Kiwi - Imported",
    "image": "https://cdn.grofers.com/app/images/products/normal/pro_381783.jpg",
    "variants": {
      1: {"quantity": "6 units", "price": 168, "sale": 144, "amount": 0}
    }
  },
  6: {
    "name": "Green Chilli",
    "image": "https://cdn.grofers.com/app/images/products/normal/pro_229590.jpg",
    "variants": {
      1: {"quantity": "200 gm", "price": 12, "sale": 9, "amount": 0}
    }
  },
  7: {
    "name": "Fresh Beans",
    "image": "https://cdn.grofers.com/app/images/products/normal/pro_327768.jpg",
    "variants": {
      1: {"quantity": "500 gm", "price": 25, "sale": 25, "amount": 0}
    }
  },
  8: {
    "name": "Bitter Gaurd (Karela)",
    "image": "https://cdn.grofers.com/app/images/products/normal/pro_197969.jpg",
    "variants": {
      1: {"quantity": "1 kg", "price": 50, "sale": 43, "amount": 0}
    }
  }
};

///********Bottom sheet************/
void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(leading: new Icon(Icons.music_note), title: new Text('Music'), onTap: () => {}),
              new ListTile(
                leading: new Icon(Icons.videocam),
                title: new Text('Video'),
                onTap: () => {},
              ),
            ],
          ),
        );
      });
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Razorpay razorpay;

  //String _timeString;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_PLbERPkkqGZkOF",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Sample App",
      "description": "Payment for the some random product",
      "prefill": {"contact": "2323232323", "email": "shdjsdh@gmail.com"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Pament success");
    //Toast.show("Pament success", context);
    Fluttertoast.showToast(msg: 'Pament success');
  }

  void handlerErrorFailure() {
    print("Pament error");
    //Toast.show("Pament error", context);
    Fluttertoast.showToast(msg: 'Pament error');
  }

  void handlerExternalWallet() {
    print("External Wallet");
    //Toast.show("External Wallet", context);
    Fluttertoast.showToast(msg: 'Wallet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor Pay Tutorial"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: "amount to pay"),
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "Donate Now",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                openCheckout();
              },
            )
          ],
        ),
      ),
    );
  }
}

///******************** Share **************************/
void _shareImageAndText() async {
  try {
    final ByteData bytes = await rootBundle.load('assets/image_01.png');
    await WcFlutterShare.share(
        sharePopupTitle: 'share',
        subject: 'This is subject',
        text: 'This is text',
        fileName: 'share.png',
        mimeType: 'image/png',
        bytesOfFile: bytes.buffer.asUint8List());
  } catch (e) {
    print('error: $e');
  }
}

void _shareText() async {
  try {
    WcFlutterShare.share(
        sharePopupTitle: 'Share', subject: 'This is subject', text: 'This is text', mimeType: 'text/plain');
  } catch (e) {
    print(e);
  }
}

void _shareImage() async {
  try {
    final ByteData bytes = await rootBundle.load('assets/image_02.png');
    await WcFlutterShare.share(
        sharePopupTitle: 'share',
        fileName: 'share.png',
        mimeType: 'image/png',
        bytesOfFile: bytes.buffer.asUint8List());
  } catch (e) {
    print('error: $e');
  }
}

/*void startTimer() {
  Timer(Duration(seconds: 3), () {
    print("Yeah, this line is printed after 3 second");
  });
  Timer.periodic(Duration(seconds: 1), (timer) {
    //print(DateTime.now());
    DateTime now = DateTime.now();

    print(now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString());
  });

  _startCountDown();
}

void _startCountDown() {
  CountDown cd = CountDown(Duration(seconds: 10));
  var sub = cd.stream.listen(null);

  sub.onData((Duration d) {
    print("dd $d");
  });

  sub.onDone(() {
    print("done");
  });

  /// the countdown will have 500ms delay
  Timer(Duration(milliseconds: 4000), () {
    sub.pause();
  });
  Timer(Duration(milliseconds: 4500), () {
    sub.resume();
  });
}*/
