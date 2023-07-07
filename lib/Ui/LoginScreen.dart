import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/Provider/model_theme.dart';
import 'package:flutter_login/Ui/ErrorScreen.dart';
import 'package:provider/provider.dart';

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
    return Consumer(builder: (context, ModelTheme theme, child){
      return MaterialApp(
          home: Scaffold(
            backgroundColor: theme.isDark ? Colors.grey.shade900: Colors.white,
              appBar: AppBar(
                backgroundColor: theme.isDark? Colors.grey.shade900:Colors.white10,
                actions: [
                  IconButton(color:theme.isDark? Colors.white:Colors.grey.shade900, icon : Icon(theme.isDark ? Icons.nightlight_round: Icons.sunny), onPressed: () {
                    theme.isDark ? theme.isDark = false : theme.isDark = true;
                  },)
                ],
                title: Text(theme.isDark ? 'Login Screen Dark': "Login Screen Light", style: TextStyle(
                  color: theme.isDark? Colors.white:Colors.grey.shade900
                ),),
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: phoneCtrl,
                        style: TextStyle(color: theme.isDark?Colors.white:Colors.grey.shade900),
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          labelText: 'PhoneNumber',
                          labelStyle: TextStyle(color: theme.isDark?Colors.white:Colors.grey.shade900),
                          icon: Icon(Icons.phone,color: theme.isDark? Colors.white: Colors.grey.shade900,),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: theme.isDark? Colors.white: Colors.grey.shade900)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: theme.isDark? Colors.white: Colors.grey.shade900)
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: pinCtrl,
                        style: TextStyle(color: theme.isDark?Colors.white:Colors.grey.shade900),
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: theme.isDark?Colors.white:Colors.grey.shade900),
                          icon: Icon(Icons.lock,color: theme.isDark? Colors.white: Colors.grey.shade900,),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: theme.isDark? Colors.white: Colors.grey.shade900)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: theme.isDark? Colors.white: Colors.grey.shade900)
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 8),
                      width: double.infinity,
                        child: MaterialButton(
                          onPressed: () => BlocProvider.of<BlocBloc>(context).add(LoginFetchEvent(phoneCtrl.text, pinCtrl.text)),
                          color: theme.isDark? Colors.white: Colors.white10,
                          child: Text('Submit',
                              style: TextStyle(color: theme.isDark? Colors.grey.shade900: Colors.black)),
                      ),
                    )
                  ],
                ),
              )));
    });

  }
}
