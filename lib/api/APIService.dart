import 'dart:convert';
import 'dart:io';

import 'package:ekidzee/api/request/change_password.dart';
import 'package:ekidzee/api/request/digital_resouce_request.dart';
import 'package:ekidzee/api/request/login_model.dart';
import 'package:ekidzee/api/response/DigitalResourseResponse.dart';
import 'package:ekidzee/api/response/change_password_response.dart';

import 'package:http/http.dart' as http;

import '../helper/LocalStrings.dart';

class APIService {
  String url = LocalStrings.developmentBaseUrl;

  Future<LoginResponseModel?> login(LoginRequestModel requestModel) async {
    try {
      print(requestModel.User_Name);
      print(requestModel.User_Password);
      print(Uri.parse(url + LocalStrings.GET_LOGIN));
      final response = await http.post(Uri.parse(url + LocalStrings.GET_LOGIN),
          headers: {
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: requestModel.toJson());
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 400) {
        return LoginResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        return null; //LoginResponseModel(token:"",Status:"Invalid/Wrong Login Details");
      }
    } catch (e) {
      print(e.toString());
      e.toString();
    }
  }

  Future<DigitalResourceResponseModel?> getDigitalResouce(DigitalResouceRequest requestModel) async {
    try {
      print("UserId ${requestModel.User_id}");
      print("KeySupport "+requestModel.KeySupport);
      print(requestModel.toJson());
      print(Uri.parse(url + LocalStrings.API_DIGITAL_RESOURCE));
      final response = await http.post(Uri.parse(url + LocalStrings.API_DIGITAL_RESOURCE),
          headers: {
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: requestModel.toJson());
      //print('response -----');
      //print(response.body);
      print('response -----DONE');
      String body = "{\"data\": ${response.body}";
      body = body.replaceAll("]", "");
      body = "${body}]}";
      //body = body.replaceAll("[", "");
      //body = body.replaceAll("]", "");
      //print(body);
      if (response.statusCode == 200 || response.statusCode == 400) {
        return DigitalResourceResponseModel.fromJson(
          json.decode(body) as Map<String, dynamic>,
        );
        print('response -----Decode');
      } else {
        return null; //LoginResponseModel(token:"",Status:"Invalid/Wrong Login Details");
      }
    } catch (e) {
      print(e.toString());
      e.toString();
    }
  }

  Future<ChangePasswordResponse?> changePassword(ChangePasswordRequest requestModel) async {
    try {
      //requestModel.Username='P1683013';
      print(requestModel.Username);
      print(requestModel.newPassword);
      print(requestModel.OldPassword);
      print(requestModel.userType);
      print(Uri.parse(url + LocalStrings.API_CHANGE_PASSWORD));
      final response = await http.post(Uri.parse(url + LocalStrings.API_CHANGE_PASSWORD),
          headers: {
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: requestModel.toJson());
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 400) {
        String body = response.body;
        body = body.replaceAll("[", "");
        body = body.replaceAll("]", "");
        print(body);
        return ChangePasswordResponse.fromJson(
          json.decode(body),
        );
      } else {
        return null; //LoginResponseModel(token:"",Status:"Invalid/Wrong Login Details");
      }
    } catch (e) {
      print(e.toString());
      e.toString();
    }
  }

  Future<TokenResponseModel> getToken(LoginRequestModel requestModel) async {
    final response = await http.post(Uri.parse(url + LocalStrings.GET_TOKEN),
        body: requestModel.toJson());
    if (response.statusCode == 200) {
      return TokenResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return TokenResponseModel(
          token: "", Status: "Invalid/Wrong Login Details");
    }
  }
}
