import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_login/Model/ModelGetRole.dart';
import 'package:http/http.dart' as http;
import '../Model/LoginModel.dart';
import '../Model/ModelUpdate.dart';


abstract class Repository {
  Future<LoginModel> loginCall(String phoneNumber, String pin);
}

class LoginRepo extends Repository {
  var client = http.Client();
  late LoginModel loginModel;
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjg4MzgwOTIxLCJleHAiOjE2OTAxMDg5MjF9.ZsOQbwM4FGcrwcahazulZgf_iGM6og-jVJNPZGpxi7I";
  ModelUpdate updateModel = ModelUpdate();

  @override
  Future<LoginModel> loginCall(String phoneNumber, String pin) async {
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

  Future<ModelUpdate> update(String email, String id, String phoneNumber, String  gender, DataRoles role) async {
    try {
      log(id);
      log(phoneNumber);
      log(gender);
      log(email);
      final bodyy = jsonEncode({
        "phoneNumber": phoneNumber,
        "email": email,
        "gender": gender,
        "role": role
      });

      var response = await client.patch(Uri.parse('http://192.168.1.221:4000/user/$id'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: bodyy);
      updateModel = ModelUpdate.fromJson(json.decode(response.body));
      log(updateModel.toString());
      return updateModel;
    } catch (e) {
      log(updateModel.toString());
      log(e.toString());
      throw Exception("Failed to update");
    }
  }

}

