import 'package:flutter/material.dart';

import './text_recognition.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognition'),
      ),
      body: TextRecognition(),
    );
  }
}
