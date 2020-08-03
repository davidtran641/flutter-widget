import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkDemo extends StatefulWidget {
  @override
  _NetworkDemoState createState() => _NetworkDemoState();
}

class _NetworkDemoState extends State<NetworkDemo> {
  Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo network')),
      body: Center(
        child: FutureBuilder<Album>(
          future: _futureAlbum,
          builder: _buildAlbum,
        ),
      ),
    );
  }

  Widget _buildAlbum(BuildContext context, AsyncSnapshot<Album> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData) {
        return _buildAlbumWidget(context, snapshot.data);
      } else {
        return Text('${snapshot.error}');
      }
    }
    return CircularProgressIndicator();
  }

  Widget _buildAlbumWidget(BuildContext context, Album data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('${data.title ?? 'Deleted'}'),
        RaisedButton(
          child: Text('Delete data'),
          onPressed: () {
            setState(() {
              _futureAlbum = deleteAlbum(data.id.toString());
            });
          },
        )
      ],
    );
  }
}

class Album {
  final int id;
  final String title;

  Album({this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(id: json['id'], title: json['title']);
  }
}

Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/1');
  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Fail to load album');
  }
}

Future<Album> deleteAlbum(String id) async {
  final response = await http.delete(
    'https://jsonplaceholder.typicode.com/albums/$id',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Fail to remove album');
  }
}
