import 'package:flutter/material.dart';

class NavigatorReturnDataDemo extends StatefulWidget {
  @override
  _NavigatorReturnDataDemoState createState() =>
      _NavigatorReturnDataDemoState();
}

class _NavigatorReturnDataDemoState extends State<NavigatorReturnDataDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First screen'),
      ),
      body: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Pick any option'),
        onPressed: () {
          _handleSelectButton(context);
        },
      ),
    );
  }

  void _handleSelectButton(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => SecondPage()));

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Result: $result')));
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select option'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Nope'),
              onPressed: () {
                Navigator.pop(context, 'Nope');
              },
            ),
            RaisedButton(
              child: Text('Yep'),
              onPressed: () {
                Navigator.pop(context, 'Yep');
              },
            )
          ],
        ),
      ),
    );
  }
}
