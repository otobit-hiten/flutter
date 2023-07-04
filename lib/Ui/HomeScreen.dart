import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/Bloc/bloc_bloc.dart';
import 'package:flutter_login/Model/LoginModel.dart';
import 'package:flutter_login/Model/ModelGetRole.dart';
import '../Repository/repository.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final LoginModel data;

  const HomeScreen(this.data, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BlocBloc blocBloc = BlocBloc(LoginRepo());
  bool update = false;
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjg4NDc1MTc3LCJleHAiOjE2OTAyMDMxNzd9.iqfpLMmieEUIsz-7fCYkXok5ZSrWiABOCh0Bp-xZvHM";
  List<String> listGender = <String>['Male', 'Female', 'Others'];
  String selectedGender = "";
  DataRoles? selectedRole;
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController roleCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();
  late String id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    id = "${widget.data.data?.user?.id}";
    phoneCtrl.text = "${widget.data.data?.user?.phoneNumber}";
    emailCtrl.text = "${widget.data.data?.user?.email}";
    genderCtrl.text = "${widget.data.data?.user?.gender}";

    return MaterialApp(
        home: BlocProvider(
      create: (_) => blocBloc,
      child: BlocConsumer<BlocBloc, BlocState>(
          builder: (BuildContext context, state) {
            switch (state.runtimeType) {
              case UpdateLoading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case UpdateError:
                return const Center(
                  child: Text('Error Update'),
                );
              case UpdateSuccess:
                final success = state as UpdateSuccess;
                id = "${success.modelUpdate.id}";
                phoneCtrl.text = "${success.modelUpdate.phoneNumber}";
                emailCtrl.text = "${success.modelUpdate.email}";
                genderCtrl.text = "${success.modelUpdate.gender}";
                return Scaffold(
                    appBar: AppBar(
                      title: const Text('Home Screen'),
                      actions: [
                        if (update)
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<BlocBloc>(context).add(
                                  UpdateEvent(phoneCtrl.text, selectedGender, emailCtrl.text, id, selectedRole!));
                              setState(() {
                                update = !update;
                              });
                            },
                            icon: const Icon(Icons.check),
                          ),
                      ],
                    ),
                    body: Center(
                      child: ListView(
                        children: [
                          SizedBox(
                              height: 100,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    update = !update;
                                  });
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const Text("Phone: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text(
                                              "${success.modelUpdate.phoneNumber}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: SizedBox(
                                              width: 150,
                                              child: TextField(
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                controller: phoneCtrl,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ))
                                    ])),
                              )),
                          SizedBox(
                              height: 100,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    update = !update;
                                  });
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const Text("Email: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text("${success.modelUpdate.email}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: SizedBox(
                                              width: 150,
                                              child: TextField(
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      20)
                                                ],
                                                controller: emailCtrl,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ))
                                    ])),
                              )),
                          SizedBox(
                              height: 100,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    update = !update;
                                  });
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const Text("Role: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text(
                                              "${success.modelUpdate.gender}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: SizedBox(
                                              child: FutureBuilder(
                                                  future: getRoleList(),
                                                  builder: (context, dataHere) {
                                                    return dataHere.hasData
                                                        ? DropdownButtonFormField(
                                                            hint: const Text(
                                                                "Enter Role"),
                                                            items: dataHere.data?.map<
                                                                    DropdownMenuItem<
                                                                        DataRoles>>(
                                                                (item) {
                                                              return DropdownMenuItem(
                                                                  value: selectedRole,
                                                                  child: Text(
                                                                      item.name!));
                                                            }).toList(),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedRole = value!;
                                                              });
                                                                })
                                                        : const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                  }),
                                            ))
                                    ])),
                              )),
                          SizedBox(
                              height: 100,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    update = !update;
                                  });
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const Text("Gender: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text(
                                              "${success.modelUpdate.gender}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: SizedBox(
                                              child: DropdownButtonFormField(
                                                  hint: const Text("Enter Gender"),
                                                  items: listGender.map<DropdownMenuItem<String>>((item) {
                                                    return DropdownMenuItem(
                                                        value: selectedGender,
                                                        child: Text(item));
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedGender = value!;
                                                    });
                                                  }
                                              )
                                                ,
                                            ))
                                    ])),
                              )),
                        ],
                      ),
                    ));
              default:
                return Scaffold(
                    appBar: AppBar(
                      title: const Text('Home Screen'),
                      actions: [
                        if (update)
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<BlocBloc>(context).add(
                                  UpdateEvent(emailCtrl.text,phoneCtrl.text,id, selectedGender, selectedRole!));
                              setState(() {
                                update = !update;
                              });
                            },
                            icon: const Icon(Icons.check),
                          ),
                      ],
                    ),
                    body: Center(
                      child: ListView(
                        children: [
                          SizedBox(
                              height: 100,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    update = !update;
                                  });
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const Text("Phone: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text(
                                              "${widget.data.data?.user?.phoneNumber}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: SizedBox(
                                              width: 150,
                                              child: TextField(
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                controller: phoneCtrl,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            )),
                                    ])),
                              )),
                          SizedBox(
                              height: 100,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    update = !update;
                                  });
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const Text("Email: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text(
                                              "${widget.data.data?.user?.email}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: SizedBox(
                                              width: 150,
                                              child: TextField(
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      20)
                                                ],
                                                controller: emailCtrl,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ))
                                    ])),
                              )),
                          SizedBox(
                              height: 100,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    update = !update;
                                  });
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const Text("Role: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text(
                                              "${widget.data.data?.user?.role?.name}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: SizedBox(
                                              width: 150,
                                              child: FutureBuilder(
                                                  future: getRoleList(),
                                                  builder: (context, dataHere) {
                                                    return dataHere.hasData
                                                        ? DropdownButtonFormField(
                                                            hint: const Text(
                                                                "Enter Role"),
                                                            items: dataHere.data?.map<
                                                                    DropdownMenuItem<
                                                                        String>>(
                                                                (item) {
                                                              return DropdownMenuItem(
                                                                  value: selectedRole!.name!,
                                                                  child: Text(
                                                                      selectedRole!.name!));
                                                            }).toList(),
                                                            onChanged: (value){

                                                            },
                                                    )
                                                        : const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                  }),
                                            ))
                                    ])),
                              )),
                          SizedBox(
                              height: 100,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    update = !update;
                                  });
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const Text("Gender: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text(
                                              "${widget.data.data?.user?.gender}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: SizedBox(
                                                  width: 150,
                                                  child:
                                                      DropdownButtonFormField(
                                                          hint: const Text("Enter Gender"),
                                                          items: listGender.map<DropdownMenuItem<String>>((item) {
                                                            return DropdownMenuItem(
                                                                value: selectedGender,
                                                                child: Text(item));
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedGender = value!;
                                                            });
                                                          }
                                                      )
                                              ),
                                            )
                                    ])),
                              )),
                        ],
                      ),
                    ));
            }
          },
          listener: (context, state) {}),
    ));
  }

  Future<List<DataRoles>> getRoleList() async {
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
      List<String> roles = [];
      return modelGetRoles.data!;
    } catch (e) {
      log(modelGetRoles.data.toString());
      log(e.toString());
      throw Exception("Failed to get roles");
    }
  }

}
