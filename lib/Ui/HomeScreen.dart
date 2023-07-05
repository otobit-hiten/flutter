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
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjg4NTMyMTk3LCJleHAiOjE2OTAyNjAxOTd9.eZGQ-qjqQb_wlNnwL_9PpdURXKzgN1jc1aClz2SYJdc";
  List<String> listGender = <String>['Male', 'Female', 'Others'];
  String selectedGender = "";
  int selectedRoleId = 0;
  List<DataRoles> roles = [];
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
                String roleName = "";
                for (var i = 0; i < roles.length; i++) {
                  if (roles[i].id == selectedRoleId) {
                    roleName = roles[i].name.toString();
                  }
                }
                final success = state as UpdateSuccess;
                id = "${success.modelUpdate.id}";
                phoneCtrl.text = "${success.modelUpdate.phoneNumber}";
                emailCtrl.text = "${success.modelUpdate.email}";
                genderCtrl.text = "${success.modelUpdate.gender}";
                return Scaffold(
                  backgroundColor: Colors.black,
                    appBar: AppBar(
                      backgroundColor: Colors.black,
                      title: const Text('Home Screen'),
                      actions: [
                        if (update)
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<BlocBloc>(context).add(
                                  UpdateEvent(phoneCtrl.text, selectedGender,
                                      emailCtrl.text, id, selectedRoleId));
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
                              height: 75,
                              child: GestureDetector(
                                onTap: () {
                                  if(update == false){
                                    showDialogForUpdate(context);
                                  }
                                },
                                child: Card(
                                    color: Colors.grey.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0)),
                                    child: Row(
                                        children: [
                                          const SizedBox(height: 10,width: 10,),
                                          const Text("Phone: ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                          !update
                                              ? Text(
                                              "${success.modelUpdate.phoneNumber}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500))
                                              : Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(right:10),
                                                width: 150,
                                                height: 50,
                                                child: TextField(
                                                  style: const TextStyle(
                                                      color: Colors.white
                                                  ),
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        10)
                                                  ],
                                                  controller: phoneCtrl,
                                                  cursorColor: Colors.white,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  decoration:
                                                  const InputDecoration(
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 2, color:  Colors.white
                                                        )
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 2, color: Colors.grey
                                                        )
                                                    ),
                                                    fillColor: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        ])),
                              )),
                          SizedBox(
                              height: 75,
                              child: GestureDetector(
                                onTap: () {
                                  if(update == false){
                                    showDialogForUpdate(context);
                                  }
                                },
                                child: Card(
                                    color: Colors.grey.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const SizedBox(height: 10,width: 10,),
                                      const Text("Email: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text("${success.modelUpdate.email}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: Container(
                                                height: 50,
                                                width: 150,
                                                padding: const EdgeInsets.only(right:10),
                                                child: TextField(
                                                style: const TextStyle(
                                                    color: Colors.white
                                                ),
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      20)
                                                ],
                                                controller: emailCtrl,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration:
                                                    const InputDecoration(
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 2, color:  Colors.white
                                                          )
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 2, color: Colors.grey
                                                          )
                                                      ),
                                                      fillColor: Colors.white,
                                                ),
                                              ),
                                            ))
                                    ])),
                              )),
                          SizedBox(
                              height: 75,
                              child: GestureDetector(
                                onTap: () {
                                  if(update == false){
                                    showDialogForUpdate(context);
                                  }
                                },
                                child: Card(
                                    color: Colors.grey.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const SizedBox(height: 10,width: 10,),
                                      const Text("Role: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text("${roleName}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(right:10),
                                                width: 150,
                                                child: FutureBuilder(
                                                  future: getRoleList(),
                                                  builder: (context, dataHere) {
                                                    return dataHere.hasData
                                                        ? DropdownButtonFormField(
                                                      icon: Icon(Icons.arrow_drop_down,color: Colors.white,),

                                                      dropdownColor: Colors.black,
                                                            hint: Container(
                                                              padding: const EdgeInsets.only(left:10),
                                                              child: const Text("Enter Role",style: TextStyle(
                                                                color: Colors.white
                                                              ),),
                                                            ),
                                                            items: dataHere.data?.map<
                                                                DropdownMenuItem<int>>((item) {
                                                              return DropdownMenuItem(
                                                                  value: item.id,
                                                                  child: Text(item
                                                                      .name!,style: TextStyle(color: Colors.white),));
                                                            }).toList(),
                                                            onChanged: (value) {
                                                              selectedRoleId =
                                                                  value!;
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
                              height: 75,
                              child: GestureDetector(
                                onTap: () {
                                  if(update == false){
                                    showDialogForUpdate(context);
                                  }
                                },
                                child: Card(
                                  color: Colors.grey.withOpacity(0.3),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const SizedBox(height: 10,width: 10,),
                                      const Text("Gender: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text(
                                              "${success.modelUpdate.gender}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: Container(
                                                width: 150,
                                                padding: const EdgeInsets.only(right:10),
                                              child: DropdownButtonFormField(
                                                  icon: Icon(Icons.arrow_drop_down,color: Colors.white),
                                                  dropdownColor: Colors.black,
                                                  hint: Container(
                                                    padding: const EdgeInsets.only(left:10),
                                                    child: const Text(
                                                        "Enter Gender", style: TextStyle(color: Colors.white),),
                                                  ),
                                                  items: listGender.map<
                                                      DropdownMenuItem<
                                                          String>>((item) {
                                                    return DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item, style: TextStyle(color: Colors.white),));
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    selectedGender = value!;
                                                  }),
                                            ))
                                    ])),
                              )),
                        ],
                      ),
                    ));
              default:
                return Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      backgroundColor: Colors.black,
                      title: const Text('Home Screen'),
                      actions: [
                        if (update)
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<BlocBloc>(context).add(
                                  UpdateEvent(phoneCtrl.text, selectedGender,
                                      emailCtrl.text, id, selectedRoleId));
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
                              height: 75,
                              child: GestureDetector(
                                onTap: () {
                                  if(update == false){
                                    showDialogForUpdate(context);
                                  }
                                },
                                child: Card(
                                    color: Colors.grey.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(
                                        children: [
                                          const SizedBox(height: 10,width: 10,),
                                      const Text("Phone: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text(
                                              "${widget.data.data?.user?.phoneNumber}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(right:10),
                                              width: 150,
                                              height: 50,
                                              child: TextField(
                                                style: const TextStyle(
                                                  color: Colors.white
                                                ),
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                controller: phoneCtrl,
                                                cursorColor: Colors.white,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          width: 2, color:  Colors.white
                                                        )
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          width: 2, color: Colors.grey
                                                        )
                                                      ),
                                                      fillColor: Colors.white,
                                                ),
                                              ),
                                            )),
                                    ])),
                              )),
                          SizedBox(
                              height: 75,
                              child: GestureDetector(
                                onTap: () {
                                  if(update == false){
                                    showDialogForUpdate(context);
                                  }
                                },
                                child: Card(
                                    color: Colors.grey.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const SizedBox(height: 10,width: 10,),
                                      const Text("Email: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text("${widget.data.data?.user?.email}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500))
                                          : Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(right:10),
                                            height: 50,
                                            width: 150,
                                            child: TextField(
                                              style: const TextStyle(color: Colors.white),
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    20)
                                              ],
                                              controller: emailCtrl,
                                              keyboardType:
                                              TextInputType.emailAddress,
                                              decoration:
                                              const InputDecoration(
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2, color:  Colors.white
                                                    )
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2, color: Colors.grey
                                                    )
                                                ),
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ))
                                    ])),
                              )),
                          SizedBox(
                              height: 75,
                              child: GestureDetector(
                                onTap: () {
                                  if(update == false){
                                    showDialogForUpdate(context);
                                  }
                                },
                                child: Card(
                                    color: Colors.grey.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    child: Row(
                                        children: [
                                      const SizedBox(height: 10,width: 10,),
                                      const Text("Role: ",
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white)),
                                      !update
                                          ? Text(
                                              "${widget.data.data?.user?.role?.name}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(right:10),
                                                height: 50,
                                                width: 150,
                                              child: FutureBuilder(
                                                  future: getRoleList(),
                                                  builder: (context, dataHere) {
                                                    return dataHere.hasData
                                                        ? DropdownButtonFormField(
                                                      icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                                      dropdownColor: Colors.black,
                                                      hint: Container(
                                                                padding: const EdgeInsets.only(left:10),
                                                                child: const Text("Enter Role",style: TextStyle(color: Colors.white),)),
                                                            items: dataHere.data?.map<
                                                                DropdownMenuItem<
                                                                    int>>((item) {
                                                              return DropdownMenuItem(
                                                                  value:
                                                                      item.id,
                                                                  child: Text(item
                                                                      .name!,style: TextStyle(color: Colors.white)));
                                                            }).toList(),
                                                            onChanged: (value) {
                                                              selectedRoleId =
                                                                  value!;
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
                              height: 75,
                              child: GestureDetector(
                                onTap: () {
                                  if(update == false){
                                    showDialogForUpdate(context);
                                  }
                                },
                                child: Card(
                                    color: Colors.grey.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    child: Row(children: [
                                      const SizedBox(height: 10,width: 10,),
                                      const Text("Gender: ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                      !update
                                          ? Text(
                                              "${widget.data.data?.user?.gender}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500))
                                          : Expanded(
                                              child: Container(
                                                  padding: const EdgeInsets.only(right:10),
                                                  width: 150,
                                                  child:
                                                      DropdownButtonFormField(
                                                        icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                                          dropdownColor: Colors.black,
                                                          hint: Container(
                                                            padding: const EdgeInsets.only(left:10),
                                                            child: const Text(
                                                                "Enter Gender", style: TextStyle(color: Colors.white),),
                                                          ),
                                                          items: listGender.map<
                                                              DropdownMenuItem<
                                                                  String>>((item) {
                                                            return DropdownMenuItem(
                                                                value: item,
                                                                child: Text(item,style: TextStyle(color: Colors.white),));
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            selectedGender =
                                                                value!;
                                                          })),
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

  showDialogForUpdate(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Update Info"),
            content: const Text("Do you want to update Info"),
            actions: <Widget>[
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              },child: const Text("No")),
              TextButton(onPressed: () {
               setState(() {
                 update = !update;
                 Navigator.of(context).pop();
               });
              }, child: const Text('Yes'))
            ],
          );
        });
  }
}
