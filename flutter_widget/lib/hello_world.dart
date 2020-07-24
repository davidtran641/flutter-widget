import 'package:flutter/cupertino.dart';

class HelloWorldDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Hello world!',
        textDirection: TextDirection.ltr,
      ),
    );
  }
}