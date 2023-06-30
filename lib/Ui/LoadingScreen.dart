import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/Ui/ErrorScreen.dart';
import 'package:flutter_login/Ui/HomeScreen.dart';

import '../Bloc/bloc_bloc.dart';
import '../Repository/repository.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BlocBloc blocBloc = BlocBloc(LoginRepo());

    return MaterialApp(
        home: BlocProvider(
      create: (_) => blocBloc,
      child: BlocConsumer<BlocBloc, BlocState>(
          builder: (BuildContext context, state) {
              return const LoadingScreen();
          },
          listener: (context, state) {
            if(state is LoginSuccessState){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(state.data)));
            }
          }),
    ));
  }
}
