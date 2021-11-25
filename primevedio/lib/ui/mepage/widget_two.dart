import 'package:flutter/material.dart';

import 'me_page.dart';

class MyStatefulWidgetTwo extends StatefulWidget {
  const MyStatefulWidgetTwo({Key? key}) : super(key: key);

  @override
  MyStatefulWidgetTwoState createState() => MyStatefulWidgetTwoState();
}

class MyStatefulWidgetTwoState extends State<MyStatefulWidgetTwo> {
  String _objectOne = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        const Text('Widget two'),
        Container(
          height: 20.0,
        ),
        RaisedButton(
          child: const Text("Get Current Message"),
          onPressed: () {
            setState(() {
              _objectOne = key.currentState!.message;
            });
          },
        ),
        Text(_objectOne),
        RaisedButton(
          child: const Text("Update Message"),
          onPressed: () {
            setState(() {
              key.currentState!.updateMessage("new message");
            });
          },
        ),
      ],
    );
  }
}
