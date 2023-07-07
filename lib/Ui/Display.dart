
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/Model/ModelGetUserById.dart';

import '../Bloc/LoginBloc/bloc_bloc.dart';
import '../Repository/repository.dart';
import 'Update.dart';

class Display extends StatefulWidget {
  const Display(int? id, {super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  final BlocBloc blocBloc = BlocBloc();
  LoginRepo loginRepo = LoginRepo();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocBloc>(
      create: (_) => BlocBloc()..add(GetUserById(1)),
      child: BlocConsumer<BlocBloc, BlocState>(
          builder: (context, state) {
            if (state is GetUserLoading) {
              return const MaterialApp(
                home:
                    Scaffold(body: Center(child: CircularProgressIndicator())),
              );
            }
            if (state is GetUserBySuccess) {
              return displayScreen(state.modelGetUserById.data);
            }
            if (state is GetUserByError) {
              return const Center(child: Text("Something went wrong!!"));
            }
            return Container();
          },
          listener: (context, state) {}),
    );
  }

  Widget displayScreen(UsersData? usersData) {
    return BlocProvider<BlocBloc>(
      create: (context) => BlocBloc(),
      child: MaterialApp(
          home: Scaffold(
        appBar: AppBar(title: const Text("User's Details")),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute<String>(builder: (context) => Update(usersData!))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Text("${usersData?.phoneNumber}",
                        style: const TextStyle(fontSize: 20))),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Text("${usersData?.email}",
                        style: const TextStyle(fontSize: 20))),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Text("${usersData?.role?.name}",
                        style: const TextStyle(fontSize: 20))),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Text("${usersData?.gender}",
                        style: const TextStyle(fontSize: 20))),
              ],
            ),
          ),
        ),
      )),
    );
  }

  tapFunction(UsersData? usersData) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => BlocProvider<BlocBloc>.value(
          value: BlocProvider.of<BlocBloc>(context),
          child: Update(usersData!),
        ),
      ),
    );
  }
}
