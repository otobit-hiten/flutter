import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/Ui/ErrorScreen.dart';

import '../Bloc/LoginBloc/bloc_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController pinCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    phoneCtrl.text = '9090909090';
    pinCtrl.text = '101010';
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Login Screen'),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: phoneCtrl,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'PhoneNumber',
                      icon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: pinCtrl,
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Pin',
                      icon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Center(
                  child: MaterialButton(
                    onPressed: () => BlocProvider.of<BlocBloc>(context).add(LoginFetchEvent(phoneCtrl.text, pinCtrl.text)),
                    color: Colors.blue,
                    child: const Text('Submit',
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            )));
  }
}
