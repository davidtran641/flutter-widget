import 'package:flutter/material.dart';
import 'package:flutter_widget/counter_demo.dart';
import 'package:flutter_widget/gesture_demo.dart';
import 'package:flutter_widget/layout_demo.dart';
import 'package:flutter_widget/physics_card_demo.dart';
import 'package:flutter_widget/shopping_demo.dart';
import 'package:flutter_widget/state_manage_demo.dart';
import 'package:flutter_widget/widget_basic.dart';

import 'animate_transition.dart';
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

            ListTile(
              title: Text('Gesture'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GestureDemo()));
              },
            ),

            ListTile(
              title: Text('Counter'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CounterDemo()));
              },
            ),

            ListTile(
              title: Text('Shopping List'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShoppingDemo()));
              },
            ),

            ListTile(
              title: Text('Layout demo'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LayoutDemo()));
              },
            ),
            ListTile(
              title: Text('State demo'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StateManageDemo()));
              },
            ),

            ListTile(
              title: Text('Transition Animation'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TransitionDemo()));
              },
            ),

            ListTile(
              title: Text('Physics card'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhysicsCardDragDemo()));
              },
            ),
          ],
        ),
      );
}
