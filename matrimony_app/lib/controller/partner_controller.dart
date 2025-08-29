import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:matrimony_app/global_variable.dart';
import 'package:matrimony_app/models/user.dart';
import 'package:http/http.dart' as http;

class PartnerController {
  Future<List<User>> fetchPartners({
    required String userId ,
    required BuildContext context,
})async{
    try{
      http.Response response = await http.get(
          Uri.parse('$uri/api/suggestion/$userId'),
        headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
        }
      );
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<User> partners = data.map((partner)=>User.fromMap(partner)).toList();
        return partners;
      }
      else{
        throw Exception("Something went wrong");
      }
    }catch(e){
      throw Exception("Something went wrong:$e");
    }
  }

}