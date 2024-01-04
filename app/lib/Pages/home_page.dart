import 'dart:convert';
import 'dart:math';

import 'package:app/Constants/colors.dart';
import 'package:app/Models/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/Constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:app/Widgets/app_bar.dart';
import 'package:app/Widgets/todo_container.dart';
import 'package:app/Widgets/pie_chart.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int complete = 0;
  List<Todo> myTodos = [];
  bool isLoading = true;

  void _showModel() {
    String title = "";

    String desc = "";

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            color: whitegreybg,
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    color: green,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Add Todo',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          desc = value;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      padding: const EdgeInsets.all(15.0),
                    ),
                    onPressed: () => _postData(
                      title: title,
                      desc: desc,
                    ),
                    child: const Text(
                      "Add Todo",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                  ),
                ],
              ),
            ),
          );
        });
  }

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
        }

        myTodos.add(t);
      });

      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print("Complete: $complete");
        print(myTodos.length);
        print(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  void _postData({String title = "", String desc = ""}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(api),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "desc": desc,
          "isDone": false,
        }),
      );
      if (response.statusCode == 201) {
        if (kDebugMode) {
          print("Post Response: ${response.body}");
        }
        setState(() {
          myTodos = [];
          isLoading = false;
          complete = 0;
        });
        fetchData();
      } else {
        if (kDebugMode) {
          print("Error: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  void delete_todo(String id) async {
    try {
      http.Response response =
          await http.delete(Uri.parse(api + "/" + id + "/"));

      setState(() {
        myTodos = [];
        isLoading = false;
        complete = 0;
      });
      fetchData();
      if (kDebugMode) {
        print("Delete Response: ${response.body}");
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
        backgroundColor: whitegreybg,
        appBar: customAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    )
                  : PieChartWidget(
                      complete: complete,
                      total: myTodos.length,
                    ),
              Column(
                children: myTodos.map((todo) {
                  return TodoContainer(
                    onPress: () => delete_todo(todo.id.toString()),
                    id: todo.id,
                    title: todo.title,
                    desc: todo.desc,
                    isDone: todo.isDone,
                    date: todo.date,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showModel(),
          child: const Icon(Icons.add),
        ));
  }
}
