import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_login/Model/ModelGetRole.dart';
import 'package:http/http.dart' as http;
import '../Model/LoginModel.dart';
import '../Model/ModelGetUserById.dart';
import '../Model/ModelUpdate.dart';


abstract class Repository {
  Future<LoginModel> loginCall(String phoneNumber, String pin);
}

class LoginRepo extends Repository {
  var client = http.Client();
  late LoginModel loginModel;
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjg4MzgwOTIxLCJleHAiOjE2OTAxMDg5MjF9.ZsOQbwM4FGcrwcahazulZgf_iGM6og-jVJNPZGpxi7I";
  ModelUpdate updateModel = ModelUpdate();
  ModelGetUserById modelGetUserById = ModelGetUserById();

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

  Future<ModelUpdate> update(String phoneNumber, String  gender, String email, String id,  int roleId) async {
    try {
      log(id + phoneNumber + email + roleId.toString() + gender);

      final bodyy = jsonEncode({
        "phoneNumber": phoneNumber,
        "email": email,
        "gender": gender,
        "role": roleId
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

  Future<ModelGetUserById> getUserById(int id) async{
    try{
      var response = await client.get(Uri.parse("http://192.168.1.221:4000/user/$id"));
      modelGetUserById = ModelGetUserById.fromJson(jsonDecode(response.body));
      log("GetUserByIdResponse: ${response.body}");
      return modelGetUserById;
    }catch(e){
      log("GetUserByIdError : ${e.toString()}");
      throw Exception("Failed to Get User");
    }
  }
}

