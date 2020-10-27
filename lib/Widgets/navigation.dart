import 'dart:async';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:myfirstflutterapp/Widgets/mapview.dart';
import 'package:myfirstflutterapp/Widgets/multipickimage.dart';

//import 'package:fluttertoast/fluttertoast.dart';

import 'fryo_icon.dart';

class navigation extends StatefulWidget {
  @override
  _Navigationstate createState() => _Navigationstate();
}

class _Navigationstate extends State<navigation> {
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
            /* child: Text(
              "Navigation Drawer Example",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),*/
            child: new HorizontalList("Fruits & Vegetables - Best Offers", fruitsVegetables),
          )
        ],
      ),

      /*child: Text(
        "Navigation Drawer Example",
        style: TextStyle(
          fontSize: 20.0,
        ),
      )),*/
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text("Akram.aic193@Gmail.com"),
              accountName: Text("Akram Chauhan"),
              currentAccountPicture: CircleAvatar(
                child: Text("AC"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Categories"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.add_to_photos),
              title: Text("Add Items"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About Us"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share with Friends"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text("Rate and Review"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text("Map"),
              onTap: () {
                print('dssdf');
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => mapview()));
              },
            ),
            ListTile(
              leading: Icon(Icons.flag),
              title: Text("Privacy Policy"),
              onTap: () {
                print('dssdf');
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text("ImagePick"),
              onTap: () {
                print('ssdf');
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => multipickimage()));
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

/*  Future<void> _didRecieveTranscript(MethodCall call) async {
    // type inference will work here avoiding an explicit cast
    final String utterance = call.arguments;
    print(utterance.toString());
    switch (call.method) {
      case "didRecieveTranscript":
        Fluttertoast.showToast(msg: "Hello ");
    }
  }*/
}

/********horizontal category***************/
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
