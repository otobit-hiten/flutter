import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Model/LoginModel.dart';

abstract class Repository {
  Future<LoginModel> loginCall(String phoneNumber, String pin);
}

class LoginRepo extends Repository {

  @override
  Future<LoginModel> loginCall(String phoneNumber, String pin) async {
    var client = http.Client();
    late LoginModel loginModel;
    try {
      var response = await client.post(Uri.parse('http://192.168.1.221:4000/auth/login'),
          body: {"phoneNumber": phoneNumber, "pin": pin});
      loginModel = LoginModel.fromJson(json.decode(response.body));
      print(loginModel);
      log(loginModel.data.toString());
      return loginModel;
    } catch (e) {
      log(loginModel.data.toString());
      print(e.toString());
      throw Exception("Failed to Login");
    }
  }
}

