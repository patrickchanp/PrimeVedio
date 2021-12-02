import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/ui_data.dart';

class LicencePage extends StatefulWidget {
  const LicencePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LicencePageState();
}

class _LicencePageState extends State<LicencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: UIData.primaryColor,
          title: CommonText.dialogText('Licence', color: Colors.white),
        ),
        backgroundColor: UIData.primaryColor,
        body: Center(
          child: Column(
            children: const [
              Text('test'),
            ],
          ),
        ));
  }
}
