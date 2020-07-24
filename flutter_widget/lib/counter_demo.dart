import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CounterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter'),),
      body: Center(
        child: Counter(),
      ),
    );
  }
}


class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: _increment,
          child: Text('Increase'),
        ),
        Text('Count $_counter'),
      ],
    );
  }

  void _increment() {
    setState(() {
      _counter += 1;
    });
  }
}


