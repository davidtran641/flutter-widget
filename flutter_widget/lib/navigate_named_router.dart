
import 'package:flutter/material.dart';

class NamedRouteDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen()
      },
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            Navigator.of(context).pushNamed('/second', arguments: SecondScreenArgument('Second', 'Hi john'));
          },
        ),
      ),
    );
  }
}

class SecondScreenArgument {
  final String title;
  final String message;
  SecondScreenArgument(this.title, this.message);
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SecondScreenArgument args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(args.message),
        ),
      ),
    );
  }
}
