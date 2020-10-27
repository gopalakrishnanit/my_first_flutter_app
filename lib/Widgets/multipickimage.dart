import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class multipickimage extends StatefulWidget {
  @override
  _multipickimageState createState() => new _multipickimageState();
}

class _multipickimageState extends State<multipickimage> {
  String _error = 'No Error Dectected';
  final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();
  List<Asset> images = List<Asset>();

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
          lightStatusBar: true,
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            RaisedButton(
              child: Text("upload"),
              onPressed: () {
                _uploadFile(images);
              },
              //onPressed:
            ),
            Expanded(
              child: buildGridView(),
            )
          ],
        ),
      ),
    );
  }

  /*Future<File> getImageFileFromAssets(List<Asset> filepath) async {
    int count = 0;
    List<File> fileImageArray = [];
    List<MultipartFile> multipartImageList = new List<MultipartFile>();
    for (Asset asset in filepath) {
      final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);

      File tempFile = File(filePath);
      if (tempFile.existsSync()) {
        fileImageArray.add(tempFile);
        count++;
      }
    }
    // multipartImageList.add(fileImageArray);
    FormData formData = FormData.fromMap({"multipartFiles": fileImageArray, "count": count});
    try {
      Response response = await Dio().post("http://192.168.2.148:8090/projects/flutter/saveFile.php", data: formData);
      print("file upload response: $response");
    } catch (e) {
      print("expectiation caugch: $e");
    }
  }*/

  _uploadFile(List<Asset> filepath) async {
    // getImageFileFromAssets(filepath);
    int count = 0;
    List<MultipartFile> multipartImageList = new List<MultipartFile>();
    if (null != images) {
      for (Asset asset in images) {
        final byteData = await asset.getByteData();
        print(byteData);
        //String fname = asset.name;
        String fname = "multipartFiles$count";
        print(fname);
        List<int> imageData = byteData.buffer.asUint8List();
        MultipartFile multipartFile = new MultipartFile.fromBytes(
          imageData,
          filename: fname,
          contentType: MediaType("image", "jpg"),
        );
        count++;
        multipartImageList.add(multipartFile);
      }
    }
    FormData formData = FormData.fromMap({"multipartFiles": multipartImageList, "count": count});
    try {
      Response response = await Dio().post("http://192.168.2.148:8090/projects/flutter/saveFile.php", data: formData);
      print("file upload response: $response");
    } catch (e) {
      print("expectiation caugch: $e");
    }
  }
}
