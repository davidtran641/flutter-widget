import 'package:flutter/material.dart';

class AnimateOpacityDemo extends StatefulWidget {
  @override
  _AnimateOpacityDemoState createState() => _AnimateOpacityDemoState();
}

class _AnimateOpacityDemoState extends State<AnimateOpacityDemo> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animate opacity'),
      ),
      body: Center(
        child: AnimatedOpacity(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.green,
          ),
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: _handleAnimate,
      ),
    );
  }

  void _handleAnimate() {
    setState(() {
      _visible = !_visible;
    });
  }
}
