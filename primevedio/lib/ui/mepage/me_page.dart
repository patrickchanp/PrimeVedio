import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/scoped_models/db_helper.dart';
import 'package:primevedio/scoped_models/employee.dart';

import 'demo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Employee employee = Employee("", "", "", "");

  late String firstname;
  late String lastname;
  late String emailId;
  late String mobileno;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('Saving Employee'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.view_list),
          tooltip: 'Next choice',
          onPressed: () {
            navigateToEmployeeList();
          },
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (val) => val!.isEmpty ? "Enter FirstName" : null,
                onSaved: (val) => firstname = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (val) => val!.isEmpty ? 'Enter LastName' : null,
                onSaved: (val) => lastname = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Mobile No'),
                validator: (val) => val!.isEmpty ? 'Enter Mobile No' : null,
                onSaved: (val) => mobileno = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email Id'),
                validator: (val) => val!.isEmpty ? 'Enter Email Id' : null,
                onSaved: (val) => emailId = val!,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  onPressed: _submit,
                  child: Text('Save Employee'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    } else {
      return;
    }
    var employee = Employee(firstname, lastname, mobileno, emailId);
    var dbHelper = DBHelper();
    dbHelper.saveEmployee(employee);
    _showSnackBar("Data saved successfully");
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(text)));
  }

  void navigateToEmployeeList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyEmployeeList()),
    );
  }
}
