import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;


Future<bool> register(String username,String city,String password) async{
  final box = Hive.box('UserAuth');
   var url = Uri.parse('https://webappapi-1tfr.onrender.com/api/Auth/register');
   Map<String,dynamic> mp = {
    "username" : username,
    "passwordHash": password,
    "city" : city
   };
   try{
     final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(mp), 
    );
    if(response.statusCode == 200){
      print("user registered successfully");
      return true;
    }
    else{
      print("could not register");
      return false;
    }
   }
   catch(e){print("could not register user");
   return false;
   }
}

Future<bool> login(String name,String password)async{
  final box = Hive.box('UserAuth');
  var url = Uri.parse("https://webappapi-1tfr.onrender.com/api/Auth/login");
  Map<String,dynamic> mp = {
    "id": null,
    "username" : name,
    "passwordHash": password,
    "city" : "whatever"
   };
   try{
    final response = await http.post(url,
    headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(mp)
    );

    if(response.statusCode == 200){
      print("LoginSuccessful");
      final data = jsonDecode(response.body);
      box.put('JWT', data['token']);
      GetUserInfo();
      return true;
    }
    else{
      print("login failed after connection with " +(response.statusCode).toString());
      return false;
    }
   }
   catch(e){
    print("login failed");
    return false;
   }
}

void GetUserInfo() async{
  final box = Hive.box('UserAuth');
  final user = Hive.box('user');
  String token = box.get('JWT') ?? "whatever";
  final url = Uri.parse('https://webappapi-1tfr.onrender.com/api/user/UserInfo');
  try{
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',  
        'Content-Type': 'application/json',
      },
    );
    if(response.statusCode == 200){
     print("Succesfully fetched the user");
     final data = jsonDecode(response.body);
     final name = data['username'];
     final city = data['city'];
     user.put('name', name);
     user.put('city', city);
     print(city);
    }
    else{
      print("error");
    }
  }
  catch(e){
    print("failed with exception $e");
  }
}