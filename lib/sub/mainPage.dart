import 'dart:async';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart';
import '../model.dart';
import '../main.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, title}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage>{
  int _allTasksCount = MyApp.allTasksRealm.all<UserTask>().length;
  int _importantTasksCount = MyApp.importantTasksRealm.all<UserTask>().length;
  int _normalTasksCount = MyApp.normalTasksRealm.all<UserTask>().length;
  late final StreamSubscription _subscription;


  void _createImportantTasks() async {
    var importantTasks = MyApp.importantTasksRealm.all<UserTask>();
    var allTasksCount = MyApp.allTasksRealm.all<UserTask>();

    setState(() {
      _importantTasksCount = importantTasks.length;
      _allTasksCount = allTasksCount.length;
    });
  }

  @override
  void initState()
  {
    super.initState();
    _subscription = MyApp.allTasksRealm.all<UserTask>().changes.listen((c) {
      c.inserted; // indexes of inserted objects
      for (int index in c.inserted) {
        setState(() {
          _allTasksCount = MyApp.allTasksRealm.all<UserTask>().length;
          _importantTasksCount = MyApp.importantTasksRealm.all<UserTask>().length;
          _normalTasksCount = MyApp.normalTasksRealm.all<UserTask>().length;

          print("Data is inserted ${index}, ${c.inserted.toString()} ${MyApp.allTasksRealm.all<UserTask>().length}");

        });
      }
      for (int index in c.deleted) {
        setState(() {
          _allTasksCount = MyApp.allTasksRealm.all<UserTask>().length;
          _importantTasksCount = MyApp.importantTasksRealm.all<UserTask>().length;
          _normalTasksCount = MyApp.normalTasksRealm.all<UserTask>().length;
          print("Data is deleted ${_allTasksCount}, ${_importantTasksCount} ${_normalTasksCount}");

          print("Data is deleted ${index}, ${c.inserted.toString()} ${MyApp.allTasksRealm.all<UserTask>().length}");

        });
      }
      c.modified; // indexes of modified objects
      c.deleted; // indexes of deleted objects
      c.newModified; // indexes of modified objects
      c.results; // the full List of objects

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Task Manager", style: TextStyle(fontWeight:FontWeight.bold, fontSize: 30)),
            const Text(""),
            const Text(""),
            Image.asset('repo/images/MongoDB_Logo.svg.png', width:200,height:50, fit: BoxFit.fill),
            const Text(""),
            const Text(""),
            const Text('All tasks count:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('$_allTasksCount', style: Theme.of(context).textTheme.headline4),
            const Text('Important tasks count:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red,fontSize: 20)),
            Text('$_importantTasksCount', style: Theme.of(context).textTheme.headline4),
            const Text('Normal tasks count:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green,fontSize: 20)),
            Text('$_normalTasksCount', style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
    );
  }
}
