import 'package:flutter/material.dart';

class TransitionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 1')),
      body: Center(
        child: RaisedButton(
          child: Text('Go!'),
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Page2(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0, 1);
          var end = Offset.zero;
          var curve = Curves.ease;
          var curveTween = CurveTween(curve: curve);
          var tween = Tween(begin: begin, end: end).chain(curveTween);

          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        });
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 2')),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
}
