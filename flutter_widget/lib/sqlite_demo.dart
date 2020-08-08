import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}

class SqliteDemo extends StatelessWidget {
  final dogieService = DogieService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqlite demo'),
      ),
      body: DogList(dogieService: dogieService,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addDog();
        },
      ),
    );
  }

  void _addDog() async {
    final id = await dogieService.getLargestId() + 1;
    final dog = Dog(id: id, name: "Dog $id", age: id % 10);
    dogieService.insertDog(dog);
  }
}

class DogList extends StatefulWidget {
  final DogieService dogieService;
  DogList({@required this.dogieService});

  @override
  _DogListState createState() => _DogListState();
}

class _DogListState extends State<DogList> {

  StreamSubscription<void> _updateStreamSubscription;

  @override
  void initState() {
    super.initState();
    _updateStreamSubscription = widget.dogieService.updateStream().listen((event) {
      setState(() {

      });
    });
  }

  @override
  void deactivate() {
    _updateStreamSubscription.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Dog>>(
      future: widget.dogieService.dogs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData) {
          return Center(child: Text('No data'));
        }
        return _buildListView(context, snapshot.data);
      },
    );
  }

  Widget _buildListView(BuildContext context, List<Dog> dogList) {
    return ListView.builder(
      itemCount: dogList.length,
        itemBuilder: (context, index) {
        return ListTile(
          title: Text(dogList[index].name),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteDog(dogList[index]);
            },
          ),
        );
    });
  }

  void _deleteDog(Dog dog) async {
    await widget.dogieService.deleteDog(dog);
  }
}

class DogieService {
  final Future<Database> _database = _getDatabase();
  final StreamController<void> _updateStreamController = StreamController();

  Stream<void> updateStream() => _updateStreamController.stream;

  static Future<Database> _getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'dogie.db'), version: 1, onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)");
    });
  }

  Future<void> insertDog(Dog dog) async {
    final Database db = await _database;
    await db.insert('dogs', dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _updateStreamController.add(0);
  }

  Future<void> updateDog(Dog dog) async {
    final db = await _database;
    await db.update('dogs', dog.toMap(), where: "id = ?", whereArgs: [dog.id]);
    _updateStreamController.add(0);
  }

  Future<void> deleteDog(Dog dog) async {
    final db = await _database;
    await db.delete('dogs', where: "id = ?", whereArgs: [dog.id]);
    _updateStreamController.add(0);
  }

  Future<List<Dog>> dogs() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> mapList = await db.query('dogs');
    return List.generate(mapList.length, (i) {
      return Dog(
        id: mapList[i]['id'],
        name: mapList[i]['name'],
        age: mapList[i]['age'],
      );
    });
  }
  
  Future<int> getLargestId() async {
    final db = await _database;
    final List<Map<String, dynamic>> mapList = await db.rawQuery("SELECT MAX(id) AS max_id FROM dogs;");
    if (mapList.length == 0) { return 0; }
    final maxId = mapList[0]['max_id'] as int;
    if (maxId == null) { return 0; }
    return maxId;
  }
}