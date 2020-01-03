library network;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpError{
  int errorCode;
  int statusCode;
  String message;

  HttpError(int errorCode, Map<String, dynamic> json){
    this.errorCode = errorCode;
    this.statusCode = json['statusCode'];
    this.message = json['message'];
  }

  @override
  String toString() {
    return "HTTP Error - httpcode:" + errorCode.toString() + " , server status code:" + statusCode.toString() + " , message:" + this.message;
  }
}


class Network{

  static final String host = "https://kevinvosburgh.com:40000/";

  static Future<Map<String,dynamic>> get(dynamic path) async {
    Map<String,String> headers = {};
    final response = await http.get(host + path,headers: headers);
    if(response.statusCode == 200|| response.statusCode == 201){
      return json.decode(response.body)["data"];
    }else{
      throw new HttpError(response.statusCode, json.decode(response.body));
    }
  }

  static Future<Map<String,dynamic>> post(dynamic path, Map<String,dynamic> body) async {
    Map<String,String> headers = {};
    final response = await http.post(host + path,headers: headers, body: body);
    if(response.statusCode == 200){
      return json.decode(response.body)["data"];
    }else{
      throw new HttpError(response.statusCode, json.decode(response.body));
    }
  }

  static Future<Map<String,dynamic>> delete(dynamic path) async {
    Map<String,String> headers = {};
    final response = await http.delete(host + path,headers: headers);
    print("TESTING DELETE: "+response.body);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw new HttpError(response.statusCode, json.decode(response.body));
    }
  }

  static Future<Map<String,dynamic>> put(dynamic path, Map<String,String> headers) async {
    Map<String,String> headers = {};
    final response = await http.put(host + path,headers: headers);
    print("TESTING GET: "+response.body);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw new HttpError(response.statusCode, json.decode(response.body));
    }
  }

  static Future<Map<String,dynamic>> postJsonBody(dynamic path, Map<String,String> headers, Map<String,dynamic> body) async {
    Map<String,String> headers = {"Content-Type": "application/json"};
    print("headers: " + headers.toString());
    final response = await http.post(host + path,headers: headers, body: json.encode(body));
    print("TESTING POST: "+response.body);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw new HttpError(response.statusCode, json.decode(response.body));
    }
  }

  /*
  static Future<Map<String,dynamic>> uploadMedia(String signedURL, String file_path) async{
    signedURL = Service.host + "/upload";
    var uri = Uri.parse(signedURL);
    var request = new http.MultipartRequest("POST", uri);
    request.headers['sessionToken'] = User.getUserSessionToken();
    request.files.add(await http.MultipartFile.fromPath(
      'file',
        file_path
    ));
    var streamedResponse = await request.send();
    var response = await Response.fromStream(streamedResponse);
    return json.decode(response.body);
  }
   */

}