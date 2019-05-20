import 'package:flutter/material.dart';

/**
 * @Description  入口
 * @Author  城别
 */

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter模板',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(36, 141, 248, 1),
      ),
      home: Scaffold(
        body: Center(
          child: Text('小陆'),
        ),
      ),
    );
  }
}
