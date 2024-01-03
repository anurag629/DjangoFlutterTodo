import "package:flutter/material.dart";

AppBar customAppBar() {
  return AppBar(
    title: const Text(
      "Task Manager",
      style: TextStyle(
        color: Color.fromARGB(255, 252, 252, 252),
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    backgroundColor: Color.fromARGB(255, 243, 162, 70),
    elevation: 0.0,

  );
}