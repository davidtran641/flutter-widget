import 'package:flutter/material.dart';

class CustomScrollViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var img = "https://images.squarespace-cdn.com/content/v1/5a5906400abd0406785519dd/1547305845503-V6CANV1ZD077V1FQ5OVQ/ke17ZwdGBToddI8pDm48kKAwwdAfKsTlKsCcElEApLR7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UegTYNQkRo-Jk4EWsyBNhwKrKLo5CceA1-Tdpfgyxoog5ck0MD3_q0rY3jFJjjoLbQ/grant2.jpg?format=2500w";
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Floating app bar'),
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(img, fit: BoxFit.cover),
              collapseMode: CollapseMode.parallax,
              stretchModes: [StretchMode.blurBackground, StretchMode.zoomBackground],
            ),
            expandedHeight: 200,
            stretch: true,
            pinned: true,
          ),
          SliverList(

            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text("Item $index"),
              ),
              childCount: 2000,
            ),
          ),

        ],
      ),
    );
  }
}
