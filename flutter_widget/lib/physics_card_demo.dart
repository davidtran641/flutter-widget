import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PhysicsCardDragDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable card'),
      ),
      body: DraggableCard(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;

  DraggableCard({this.child});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Alignment _alignment = Alignment.center;

  Animation<Alignment> _animation;

  void _runAnimation(Offset pixelsPerSecond) {
    _animation = _animationController.drive(
      AlignmentTween(begin: _alignment, end: Alignment.center)
    );

    final size = MediaQuery.of(context).size;
    final unitPerSecondX = pixelsPerSecond.dx / size.width;
    final unitPerSecondY = pixelsPerSecond.dy / size.height;
    final unitPerSecond = Offset(unitPerSecondX, unitPerSecondY);
    final velocity = unitPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 0.5,
      damping: 1
    );
    final simulation = SpringSimulation(spring, 0, 1, -velocity);

    _animationController.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (detail) {},
      onPanUpdate: _handlePanUpdate,
      onPanEnd: (detail) { _runAnimation(detail.velocity.pixelsPerSecond); },
      child: Align(
        alignment: _alignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }

  void _handlePanUpdate(DragUpdateDetails detail) {
    var size = MediaQuery.of(context).size;
    setState(() {
      _alignment += Alignment(
        detail.delta.dx / (size.width/2),
        detail.delta.dy / (size.height/2)
      );
    });
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();

    _animationController.addListener(() {
      setState(() {
        _alignment = _animation.value;
      });
    });
  }
}
