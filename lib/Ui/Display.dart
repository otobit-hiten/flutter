import 'dart:async';

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
  final BlocBloc blocBloc = BlocBloc(LoginRepo());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocBloc>(
      create: (_) => blocBloc,
      child: BlocConsumer<BlocBloc, BlocState>(
          builder: (context, state) {
            if (state is GetUserBySuccess) {
              return displayScreen(state.modelGetUserById.data);
            } else if (state is GetUserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetUserByError) {
              return const Center(
                child: Text("Something went wrong!!"),
              );
            }else{
              BlocProvider.of<BlocBloc>(context).add(GetUserById(1));
              return  const Center(
                child: CircularProgressIndicator()
              );
            }
          },
          listener: (context, state) {}),
    );
  }

  Widget displayScreen(UsersData?usersData) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  const Text("User's Details")
        ),
        body: Container(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Update(usersData!))).then(goBack);
            },
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${usersData?.phoneNumber}",style: const TextStyle(fontSize: 20)),
                  Text("${usersData?.email}",style: const TextStyle(fontSize: 20)),
                  Text("${usersData?.gender}",style: const TextStyle(fontSize: 20)),
                  Text("${usersData?.role?.name}",style: const TextStyle(fontSize: 20)),
                ],
              ),
          ),
        ),
        )
    );
  }

    goBack(dynamic value) {
    BlocProvider.of<BlocBloc>(context).add(GetUserById(1));
    setState(() {

    });
  }
}


