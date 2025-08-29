import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:matrimony_app/global_variable.dart';
import 'package:matrimony_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony_app/service/manage_http_request.dart';

class PartnerController {


  // send-request to user
  Future<String> sendRequest({
    required String senderId,
    required String receiverId,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/send-request'),
        body: jsonEncode({'senderId': senderId, 'receiverId': receiverId}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['msg'];
      } else {
        return 'Something went wrong';
      }
    } catch (e) {
      print(e.toString());
      return 'Something went wrong';
    }
  }

  // accept request
  Future<String> acceptRequest({
    required String senderId,
    required String receiverId,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/accept-request'),
        body: jsonEncode({'senderId': senderId, 'receiverId': receiverId}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['msg'];
      } else {
        return 'Something went wrong';
      }
    } catch (e) {
      print(e.toString());
      return 'Something went wrong';
    }
  }

  // reject request
  Future<String> rejectRequest({
    required String senderId,
    required String receiverId,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/reject-request'),
        body: jsonEncode({'senderId': senderId, 'receiverId': receiverId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['msg'];
      } else {
        return 'Something went wrong';
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Something went wrong');
    }
  }

  // suggestion for partners
  Future<List<User>> fetchPartners({
    required String userId,
    required BuildContext context,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/suggestion/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<User> partners =
            data.map((partner) => User.fromMap(partner)).toList();
        return partners;
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      throw Exception("Something went wrong:$e");
    }
  }

  // reject suggestion
  Future<String> rejectSuggetion({
    required String userId,
    required String targetId,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/reject'),
        body: jsonEncode({'userId': userId, 'targetId': targetId}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['msg'];
      } else {
        return 'Something went wrong';
      }
    } catch (e) {
      print(e.toString());
      return 'Something went wrong';
    }
  }
}
