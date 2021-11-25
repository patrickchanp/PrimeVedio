import 'package:flutter/material.dart';
import 'package:primevedio/ui/mepage/widget_two.dart';

final key = GlobalKey<_MyStatefulWidgetOneState>();

class GlobalKeyCommunication extends StatelessWidget {
  const GlobalKeyCommunication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Global Key Communication',
          style: TextStyle(fontSize: 14.0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyStatefulWidgetOne(key: key),
          const MyStatefulWidgetTwo(),
        ],
      ),
    );
  }
}

class MyStatefulWidgetOne extends StatefulWidget {
  const MyStatefulWidgetOne({Key? key}) : super(key: key);
  @override
  _MyStatefulWidgetOneState createState() => _MyStatefulWidgetOneState();
}

class _MyStatefulWidgetOneState extends State<MyStatefulWidgetOne> {
  String _message = "hhhhhhh world!";
  String get message => _message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 20.0,
          ),
          Text('Widget one message: ' + _message)
        ],
      ),
    );
  }

  void updateMessage(String msg) {
    setState(() {
      _message = msg;
      print('1111$_message');
    });
  }
}
