import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/Bloc/LoginBloc/bloc_bloc.dart';
import 'package:flutter_login/Provider/model_theme.dart';
import 'package:provider/provider.dart';
import 'Ui/FirstPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BlocBloc>(
            create: (BuildContext context) => BlocBloc(),
          ),
        ],
        child: ChangeNotifierProvider(
            create: (_) => ModelTheme(),
            child: Consumer<ModelTheme>(
                builder: (context, ModelTheme theme, child) {
                  return MaterialApp(
                    title: 'Flutter Demo',
                    theme: theme.isDark
                        ?
                    ThemeData(brightness: Brightness.dark)
                        :
                    ThemeData(
                        brightness: Brightness.light,
                        primaryColor: Colors.green,
                        primarySwatch: Colors.green
                    ),
                    home: const FirstPage(),
                  );
                }
            )
        )
    );
  }
}
