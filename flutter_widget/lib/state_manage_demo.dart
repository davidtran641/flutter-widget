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
        child: Tapbox(
          isActive: isActive,
          onChanged: _handleTap,
        ),
      ),
    );
  }
}

class Tapbox extends StatelessWidget {
  Tapbox({Key key, this.isActive: false, @required this.onChanged})
      : super(key: key);

  final bool isActive;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!isActive);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            isActive ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration:
            BoxDecoration(color: isActive ? Colors.green : Colors.grey[500]),
      ),
    );
  }
}
