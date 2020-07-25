import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layout demo'),
      ),
      body: ListView(
        children: <Widget>[
          _buildImage(context),
          _buildTitleRow(context),
          _buildButtonsRow(context),
          _buildTextSection(context),
        ],
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.redAccent,
          ),
          Text('41'),
        ],
      ),
    );
  }

  Widget _buildButtonsRow(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildButtonColumn(context, Colors.blue, "CALL", Icons.call),
        _buildButtonColumn(context, Colors.blue, "ROUTE", Icons.near_me),
        _buildButtonColumn(context, Colors.blue, "SHARE", Icons.share),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  Widget _buildButtonColumn(
      BuildContext context, Color color, String title, IconData icon) {
    return Column(
      children: <Widget>[
        Icon(icon, color: color),
        Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              title,
              style: TextStyle(
                  color: color, fontSize: 12, fontWeight: FontWeight.w400),
            ))
      ],
    );
  }

  Widget _buildTextSection(BuildContext context) {
    return Container(
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
      padding: EdgeInsets.all(32),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Image.asset(
      'assets/images/lake.jpg',
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}
