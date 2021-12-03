import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/utils/common_text.dart';

class PageLicence extends StatefulWidget {
  const PageLicence({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PageLicenceState();
}

class _PageLicenceState extends State<PageLicence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CommonText.aboutText('Licence'),
      ),
      body: const LicensePage(),
    );
  }
}
