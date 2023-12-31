import 'dart:convert';

import 'package:app/Models/todo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/Constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:app/Widgets/app_bar.dart';
import 'package:app/Widgets/todo_container.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int complete = 0;
  int incomplete = 0;
  List<Todo> myTodos = [];
  bool isLoading = true;
  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(api));
      var data = json.decode(response.body);
      data.forEach((todo) {
        Todo t = Todo(
          id: todo['id'],
          title: todo['title'],
          desc: todo['desc'],
          isDone: todo['isDone'],
          date: todo['date'],
        );
        if (t.isDone) {
          complete++;
        } else {
          incomplete++;
        }

        myTodos.add(t);
      });

      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print("Complete: $complete");
        print("Incomplete: $incomplete");
        // print(myTodos.length);
        // print(response.body);
      }
      
      
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: myTodos.length,
              itemBuilder: (context, index) {
                return TodoContainer(
                  id: myTodos[index].id,
                  title: myTodos[index].title,
                  desc: myTodos[index].desc,
                  isDone: myTodos[index].isDone,
                  date: myTodos[index].date,
                );
              },
            ),
    );
  }
}