import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony_app/global_variable.dart';
import 'package:matrimony_app/provider/user_provider.dart';
import 'package:matrimony_app/service/manage_http_request.dart';
class ProfilePicController{


  Future<void> uploadProfilePic({
    required String userId,
    required File image,
    required BuildContext context,
    required WidgetRef ref
})async{
    try{
      final cloudinary = await CloudinaryPublic("dktwuay7l","Matrimony App");

      final imageByte = await image.readAsBytes();

      CloudinaryResponse? imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(imageByte, identifier: "pickerPic",folder: "profilePic")
      );

      final imageUrl = imageResponse.secureUrl;
      print(imageUrl);
      http.Response response = await http.put(
          Uri.parse('$uri/api/upload-profile-pic/$userId'),
        body: jsonEncode({
          'image':imageUrl,
        }),
        headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
        }
      );


      print(jsonDecode(response.body)['image']);
      manageHttpRequest(res: response, context: context, onSuccess: (){
        final data = jsonDecode(response.body);
        final image = data['image'];
        ref.read(userProvider.notifier).setProfilePic(image);
        showSnackBar(text: "Profile Pic Updated Successfully", context: context);
      });

    }
    catch(e){
      print(e.toString());
      showSnackBar(text: e.toString(), context: context);
    }
}

}