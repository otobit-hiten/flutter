import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/blocs/bloc.dart';
import 'blocs/bloc.dart';
import 'blocs/state.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<InternetBloc, InternetState>(
            builder: (context, state){
                if (state is InternetGainedState) {
                  return const Text("Connected");
                }else if (state is InternetLostState){
                  return const Text("Not Connected");
                }else{
                  return const Text("Loading...");
                }
            },
          ),
        ),
      ),
    );
  }
}
