import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showSnackBar({
  required String text,
  required BuildContext context,
}) {
  // prevent lookup if widget is already disposed
  if (!context.mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}


void manageHttpRequest({
  required http.Response res,
  required BuildContext context,
  required VoidCallback onSuccess,
}){

  switch(res.statusCode){
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(text: jsonDecode(res.body)['msg'], context: context);
      break;
    case 401:
      showSnackBar(text: jsonDecode(res.body)['msg'], context: context);
      break;
    case 403:
      showSnackBar(text: jsonDecode(res.body)['msg'], context: context);
      break;
    case 500 :
      showSnackBar(text: jsonDecode(res.body)['error'], context: context);
      break;
    default:
      showSnackBar(text: jsonDecode(res.body)['msg'], context: context);
  }

}