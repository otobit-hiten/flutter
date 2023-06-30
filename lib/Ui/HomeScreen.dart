import 'package:flutter/material.dart';
import 'package:flutter_login/Model/LoginModel.dart';

class HomeScreen extends StatefulWidget {
  final LoginModel data;

  const HomeScreen(this.data, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: Center(
          child: ListView(
            children: [
              SizedBox(
                height: 100,
                child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Center(child: Text("Phone :${widget.data.data.user.phoneNumber}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)))
                ),
              ),
              SizedBox(
                height: 100,
                child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Center(child: Text("Role : ${widget.data.data.user.role}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)))
                ),
              ),
              SizedBox(
                height: 100,
                child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Center(child: Text("Email : ${widget.data.data.user.email}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)))
                ),
              ),
              SizedBox(
                height: 100,
                child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Center(child: Text("Gender : ${widget.data.data.user.gender}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)))
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
