import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/Bloc/bloc_bloc.dart';
import 'package:flutter_login/Model/LoginModel.dart';
import 'package:flutter_login/Model/ModelUpdate.dart';

import '../Repository/repository.dart';

class HomeScreen extends StatefulWidget {
  final LoginModel data;
  final ModelUpdate updatedata;

  const HomeScreen(this.data, this.updatedata, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final BlocBloc blocBloc = BlocBloc(LoginRepo());
  bool update = false;
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
    roleCtrl.text = "${widget.data.data?.user?.role?.name}";
    emailCtrl.text = "${widget.data.data?.user?.email}";
    genderCtrl.text = "${widget.data.data?.user?.gender}";

    return MaterialApp(
        home: BlocProvider(
          create: (_) => blocBloc,
          child: BlocConsumer<BlocBloc, BlocState>(builder: (BuildContext context, state){
            switch(state.runtimeType){
              case UpdateLoading :
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case UpdateError :
                return const Center(
                  child: Text('Error Updste'),
                );
              default: return Scaffold(
                  appBar: AppBar(
                    title: const Text('Home Screen'),
                    actions: [
                      if (update)
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<BlocBloc>(context).add(UpdateEvent(emailCtrl.text, id));
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
                                  update = true;
                                });
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  child: Row(children: [
                                    const Text("Phone: ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    Text("${widget.data.data?.user?.phoneNumber}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(width: 20),
                                    if (update == true)
                                      Expanded(
                                          child: SizedBox(
                                            width: 150,
                                            child: TextField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(10)
                                              ],
                                              controller: phoneCtrl,
                                              keyboardType: TextInputType.number,
                                              decoration: const InputDecoration(
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
                                  update = true;
                                });
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  child: Row(children: [
                                    const Text("Role: ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    Text("${widget.data.data?.user?.role?.name}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(width: 20),
                                    if (update == true)
                                      Expanded(
                                          child: SizedBox(
                                            width: 150,
                                            child: TextField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(10)
                                              ],
                                              controller: roleCtrl,
                                              keyboardType: TextInputType.number,
                                              decoration: const InputDecoration(
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
                                  update = true;
                                });
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  child: Row(children: [
                                    const Text("Email: ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    Text("${widget.data.data?.user?.email}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(width: 20),
                                    if (update == true)
                                      Expanded(
                                          child: SizedBox(
                                            width: 150,
                                            child: TextField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(10)
                                              ],
                                              controller: emailCtrl,
                                              keyboardType: TextInputType.emailAddress,
                                              decoration: const InputDecoration(
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
                                  update = true;
                                });
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  child: Row(children: [
                                    const Text("Gender: ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    Text("${widget.data.data?.user?.gender}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(width: 20),
                                    if (update == true)
                                      Expanded(
                                          child: SizedBox(
                                            width: 150,
                                            child: TextField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(10)
                                              ],
                                              controller: genderCtrl,
                                              keyboardType: TextInputType.number,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ))
                                  ])),
                            )),
                      ],
                    ),
                  ));
            }
          }, listener: (context, state){
            if(state is UpdateSuccess){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(LoginModel(),state.modelUpdate)), (route) => false);
            }
          }),

        )
    );
  }
}
