import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/Bloc/bloc_bloc.dart';
import 'package:flutter_login/Repository/repository.dart';
import 'package:flutter_login/Ui/ErrorScreen.dart';
import 'package:flutter_login/Ui/HomeScreen.dart';
import 'package:flutter_login/Ui/LoadingScreen.dart';

import 'LoginScreen.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final BlocBloc blocBloc = BlocBloc(LoginRepo());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (_) => blocBloc,
      child: BlocConsumer<BlocBloc, BlocState>(
          builder: (BuildContext context, state) {
        if (state is LoginLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const LoginScreen();
      }, listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(state.data)),
              (route) => false);
        } else if (state is LoginErrorState) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ErrorScreen()));
        }
      }),
    ));
  }
}