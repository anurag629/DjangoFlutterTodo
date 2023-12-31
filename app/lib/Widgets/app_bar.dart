import "package:flutter/material.dart";

AppBar customAppBar() {
  return AppBar(
    title: const Text(
      "Personal Todo",
      style: TextStyle(
        color: Color(0xffe94560),
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.blueGrey[900],
    elevation: 0.0,

  );
}