import 'package:flutter/material.dart';
import 'package:flutter_widget/widget_basic.dart';

import 'hello_world.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Hello world"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelloWorldDemo()),
                );
              },
            ),
            ListTile(
              title: Text('Basic widget'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BasicWidgetDemo()));
              },
            ),
          ],
        ),
      );
}
