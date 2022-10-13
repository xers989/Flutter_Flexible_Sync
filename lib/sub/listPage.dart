import 'dart:async';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flexible_sync/sub/detailPage.dart';

import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart';
import '../model.dart';
import '../main.dart';
import 'detailPage.dart';

class listView extends StatefulWidget {
  const listView({Key? key}) : super(key: key);

  @override
  State<listView> createState() => _listViewState();
}

class _listViewState extends State<listView> {
  //late final StreamSubscription _subscription;
  late RealmResults<UserTask> _results;
  late List<UserTask> _userList = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _results = MyApp.allTasksRealm.all<UserTask>();
  }

  @override
  void dispose() {
    //_subscription.cancel();
    super.dispose();
  }
  String _getImagePath(String level)
  {
    String imagePath = "";
    if (level == "top")
      imagePath = "repo/images/top.png";
    else if (level == "normal")
      imagePath = "repo/images/middle.png";
    else
      imagePath = "repo/images/low.png";
    return imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Center(
          child: _results.length ==0 ? Text ('There is no Task', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)
              : ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => detailView(usertask: _results[index]) ));
                    },

                      child: Row(
                        children: <Widget> [
                          Image.asset(
                            _getImagePath(_results[index].priority!),
                            height: 40,
                            width: 40,
                            fit: BoxFit.contain,
                          ),
                          Column(
                            children: <Widget>[
                              Text("Title : ${_results[index].title!} ", style: TextStyle(fontSize:16),
                                textAlign: TextAlign.left,
                              ),
                              Text("Task : ${_results[index].task!} ", style: TextStyle(fontSize:16),
                                textAlign: TextAlign.left,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width -180,
                                child: Text("Due date is  ${_results[index].dueDate}" ,
                                  textAlign: TextAlign.left, style: TextStyle(fontSize:14, color: Colors.blue),
                                ),
                              )
                            ],
                          ),

                        ],

                      )

                  ),

                  );
              }

          )
        ),

      ),
    );
  }
}