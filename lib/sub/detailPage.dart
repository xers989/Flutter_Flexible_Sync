import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart';
import '../model.dart';
import '../main.dart';

class detailView extends StatelessWidget {
  final UserTask? usertask;
  const detailView({Key? key, this.usertask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Task Detail")),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text("Priority : ${usertask!.priority}", style: TextStyle(fontSize:20),
        textAlign: TextAlign.left),
                Text('Task : ${usertask!.task}', style: TextStyle(fontSize:20),
                    textAlign: TextAlign.left),
                Text('Memo : ${usertask!.memo}', style: TextStyle(fontSize:20),
                    textAlign: TextAlign.left),
                Text('Due Date : ${usertask!.dueDate}', style: TextStyle(fontSize:20),
                    textAlign: TextAlign.left),
                Text('Title : ${usertask!.title}', style: TextStyle(fontSize:20),
                    textAlign: TextAlign.left),
                Text('Important : ${usertask!.isImportant}', style: TextStyle(fontSize:20),
                    textAlign: TextAlign.left),
                Text('Completed : ${usertask!.isCompleted}', style: TextStyle(fontSize:20),
                    textAlign: TextAlign.left),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Go back'),

                ),
              ]
          )
      ),
    );
  }
}
