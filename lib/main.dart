import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/Bloc/LoginBloc/bloc_bloc.dart';
import 'package:flutter_login/Repository/repository.dart';
import 'Ui/FirstPage.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<BlocBloc>(
      create: (context) => BlocBloc(LoginRepo()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const FirstPage();
  }
}
