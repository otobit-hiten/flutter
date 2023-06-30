import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Update Information'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: TextField(
                controller: phoneCtrl,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                decoration: (const InputDecoration(
                    labelText: 'PhoneNumber', icon: Icon(Icons.phone))),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: TextField(
                controller: emailCtrl,
                inputFormatters: [LengthLimitingTextInputFormatter(6)],
                decoration: const InputDecoration(
                    labelText: 'Email', icon: Icon(Icons.email)),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: TextField(
                controller: nameCtrl,
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
                decoration: const InputDecoration(
                    labelText: 'Name', icon: Icon(Icons.person)),
              ),
            ),
            MaterialButton
              (
              color: Colors.blue,
                onPressed: () {},
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
