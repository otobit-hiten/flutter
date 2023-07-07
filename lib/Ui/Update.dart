import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/Bloc/LoginBloc/bloc_bloc.dart';
import 'package:flutter_login/Ui/Display.dart';
import 'package:flutter_login/Ui/FirstPage.dart';
import '../Model/ModelGetRole.dart';
import '../Model/ModelGetUserById.dart';
import 'package:http/http.dart' as http;

class Update extends StatefulWidget {
  final UsersData usersData;

  Update(this.usersData, {super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjg4NTMyMTk3LCJleHAiOjE2OTAyNjAxOTd9.eZGQ-qjqQb_wlNnwL_9PpdURXKzgN1jc1aClz2SYJdc";
  List<String> listGender = <String>['Male', 'Female', 'Others'];
  String selectedGender = "";
  int selectedRoleId = 0;
  List<DataRoles> roles = [];
  late String id;

  @override
  Widget build(BuildContext context) {
    phoneCtrl.text = widget.usersData.phoneNumber!;
    emailCtrl.text = widget.usersData.email!;
    id = "${widget.usersData.id}";
    return BlocProvider<BlocBloc>(
        create: (_) => BlocBloc(),
        child: BlocConsumer<BlocBloc, BlocState>(
          builder: (context, state) {
            return MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                    leading: BackButton(
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: const Text("Edit Details")),
                body: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          controller: phoneCtrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Phone Number",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          controller: emailCtrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: FutureBuilder(
                            future: getRoleList(),
                            builder: (context, usersData) {
                              return usersData.hasData
                                  ? DropdownButtonFormField(
                                  hint: Container(
                                    padding:
                                    const EdgeInsets.only(left: 10),
                                    child: const Text("Enter Role"),
                                  ),
                                  items: usersData.data?.map<DropdownMenuItem<int>>((item) {
                                    return DropdownMenuItem(
                                        child: Text("${item.name}"),
                                        value: item.id);
                                  }).toList(),
                                  onChanged: (value) {
                                    selectedRoleId = value!;
                                  })
                                  : const CircularProgressIndicator();
                            }),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: DropdownButtonFormField(
                              hint: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text("Enter Gender"),
                              ),
                              items: listGender
                                  .map<DropdownMenuItem<String>>((item) {
                                return DropdownMenuItem(
                                    value: item, child: Text("${item}"));
                              }).toList(),
                              onChanged: (value) {
                                selectedGender = value!;
                              })),
                      Container(
                        width: double.infinity,
                        child: MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            showLoader(context);
                            BlocProvider.of<BlocBloc>(context).add(UpdateEvent(
                                phoneCtrl.text,
                                selectedGender,
                                emailCtrl.text,
                                id,
                                selectedRoleId));
                          },
                          child: Text("Update"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if(state is UpdateSuccess){
              Navigator.push(context, MaterialPageRoute<String>(builder: (context) => Display(1)));
            }
          },
        ));
  }

  showLoader(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Future<List<DataRoles>?> getRoleList() async {
    var client = http.Client();
    ModelGetRoles modelGetRoles = ModelGetRoles();

    try {
      var response = await client
          .get(Uri.parse("http://192.168.1.221:4000/user/role"), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      modelGetRoles = ModelGetRoles.fromJson(json.decode(response.body));
      log(response.body.toString());
      log(modelGetRoles.data.toString());
      modelGetRoles.data?.forEach((element) {
        roles.add(element);
      });
      return modelGetRoles.data;
    } catch (e) {
      log(modelGetRoles.data.toString());
      log(e.toString());
      throw Exception("Failed to get roles");
    }
  }
}


