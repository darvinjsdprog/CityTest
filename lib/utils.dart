import 'dart:async';
import 'package:flutter/material.dart';

Future<bool?> oneButtonsDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String button1,
}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text(title, style: TextStyle(color: Colors.black)),
        content: new SingleChildScrollView(
          child: new Text(
            content,
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: <Widget>[
          new TextButton(
            child: new Text(
              button1,
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}

Future<bool?> twoButtonsDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String button1,
  required String button2,
  positive = false,
}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text(title, style: TextStyle(color: Colors.black)),
        content: new SingleChildScrollView(
          child: new Text(
            content,
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: positive
            ? <Widget>[
                new TextButton(
                  child: new Text(
                    button2,
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                new RaisedButton(
                  child: new Text(
                    button1,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green[800],
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ]
            : <Widget>[
                new RaisedButton(
                  child: new Text(
                    button2,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                new TextButton(
                  child: new Text(
                    button1,
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
      );
    },
  );
}

Widget loading(
    {BuildContext? context,
    Widget? background,
    String? content,
    required bool loading}) {
  return Stack(
    children: [
      background!,
      if (loading)
        Scaffold(
          backgroundColor: Colors.white70,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    content! + ".\nEspere un momento, por favor.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 4,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue,
                        valueColor:
                            new AlwaysStoppedAnimation<Color?>(Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ],
  );
}
