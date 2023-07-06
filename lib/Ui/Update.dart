import 'package:flutter/material.dart';

import '../Model/ModelGetUserById.dart';
class Update extends StatefulWidget {
  final UsersData usersData;
  Update(this.usersData, {super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title:  const Text("Edit Details")
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(onPressed: (){
                Navigator.of(context).pop('String');

              }),
              Text("${widget.usersData.name}",style: const TextStyle(fontSize: 30)),
            ],
          ),
        ),
      ),
    );
  }
}
