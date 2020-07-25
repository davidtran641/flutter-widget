import 'package:flutter/material.dart';

class StateManageDemo extends StatefulWidget {
  @override
  _StateManageDemoState createState() => _StateManageDemoState();
}

class _StateManageDemoState extends State<StateManageDemo> {
  bool isActive = false;

  void _handleTap(bool value) {
    setState(() {
      isActive = !isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TapBox(
          isActive: isActive,
          onChanged: _handleTap,
        ),
      ),
    );
  }
}

class TapBox extends StatefulWidget {
  TapBox({Key key, this.isActive: false, @required this.onChanged})
      : super(key: key);

  final bool isActive;
  final ValueChanged<bool> onChanged;

  @override
  _TapBoxState createState() => _TapBoxState();
}

class _TapBoxState extends State<TapBox> {
  var _isHighlight = false;

  void _handleTap() {
    widget.onChanged(!widget.isActive);
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isHighlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isHighlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _isHighlight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
            widget.isActive ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: widget.isActive ? Colors.green : Colors.grey[500],
          border: _isHighlight
              ? Border.all(color: Colors.teal[700], width: 10)
              : null,
        ),
      ),
    );
  }
}
