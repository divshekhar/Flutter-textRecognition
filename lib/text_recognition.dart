import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class TextRecognition extends StatefulWidget {
  @override
  _TextRecognitionState createState() => _TextRecognitionState();
}

class _TextRecognitionState extends State<TextRecognition> {
  File pickedImage;

  String text = "";

  bool isImageLoaded = false;
  bool isReadText = false;

  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
      text = "";
    });
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      text = text + block.text;
    }
    setState(() {
      isReadText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          isImageLoaded
              ? Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(pickedImage), fit: BoxFit.cover),
                  ),
                )
              : Container(
                  height: 200,
                  width: 200,
                ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            color: Colors.lightGreen,
            highlightColor: Colors.blue,
            textColor: Colors.white,
            child: Text('Pick an image'),
            onPressed: pickImage,
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            color: Colors.blue,
            highlightColor: Colors.green,
            textColor: Colors.white,
            child: Text('Read Text'),
            onPressed: readText,
          ),
          SizedBox(height: 10.0),
          isReadText
              ? Column(children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ])
              : Container(),
          SizedBox(height: 10.0),
          isReadText
              ? RaisedButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('Clear'),
                  onPressed: () {
                    setState(() {
                      text = "";
                    });
                  })
              : Container(),
        ],
      ),
    );
  }
}
