import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_app/global_variable.dart';
import 'package:matrimony_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony_app/provider/user_provider.dart';
import 'package:matrimony_app/service/managa_http_request.dart';
import 'package:matrimony_app/views/authentication/login_screen.dart';
import 'package:matrimony_app/views/main_screen.dart';
import 'package:matrimony_app/views/nav_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthController {

   // sign-up user by email and password
  Future<void> signUpUser({
    required String email,
    required String fullname,
    required BuildContext context,
    required String password,
})async{
    try{
      User user = User(id: '', fullname: fullname, email: email, password: password,age: 0, dob: '', height: '', weight: '', marital_status: '', state: '', city: '', address: '', religion: '', caste: '', subcaste: '', mother_tongue: '', gender: '', education: '', work: '',workRole: '', annual_income: '', diet:'' , family_type: '', phone: '', image: ''
          '');
      http.Response response = await http.post(
          Uri.parse('$uri/api/sign-up'),
        body: user.toJson(),
        headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
        }
      );

      manageHttpRequest(res: response, context: context, onSuccess: (){
        showSnackBar(text: 'Account created successfully', context: context);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
        showSnackBar(text: 'Login with the same credentials', context: context);
      });

    }catch(e){
      showSnackBar(text: e.toString(), context: context);
    }
  }


  // sign-in user by email and password
  Future<void> signInUser({
    required String email,
    required String password,
    required WidgetRef ref,
    required BuildContext context,
})async{
    try{
      http.Response response = await http.post(
          Uri.parse('$uri/api/sign-in'),
        body: jsonEncode({
          'email':email,
          'password':password
        }),
        headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
        }
      );

      manageHttpRequest(
          res: response,
          context: context,
          onSuccess: ()async{
            SharedPreferences preferences = await SharedPreferences.getInstance();
            final token = jsonDecode(response.body)['token'];
            await preferences.setString('auth-token', token);
            final userJson = jsonEncode(jsonDecode(response.body)['user']);
            await preferences.setString('user', userJson);
            ref.read(userProvider.notifier).setUser(userJson);
            showSnackBar(text: 'Login Successfully', context: context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>MainScreen()), (route) => false);
          }
      );


    }catch(e){
      showSnackBar(text: e.toString(), context: context);
    }
  }

  Future<void> updateProfile({
    required String id,
    required String dob,
    required String height,
    required String weight,
    required String marital_status,
    required String state,
    required String city,
    required String address,
    required String religion,
    required String caste,
    required String subcaste,
    required String mother_tongue,
    required String gender,
    required String education,
    required String work,
    required String workRole,
    required String annual_income,
    required String diet,
    required String family_type,
    required String phone,
    required String image,
    required WidgetRef ref,
    required BuildContext context,
})async{
    try{
      http.Response response = await http.put(
          Uri.parse('$uri/api/update-profile'),
        body: jsonEncode({
          '_id':id,
          'dob':dob,
          'height':height,
          'weight':weight,
          'marital_status':marital_status,
          'state':state,
          'city':city,
          'address':address,
          'religion':religion,
          'caste':caste,
          'subcaste':subcaste,
          'mother_tongue':mother_tongue,
          'gender':gender,
          'education':education,
          'work':work,
          'workRole':workRole,
          'annual_income':annual_income,
          'diet':diet,
          'family_type':family_type,
          'phone':phone,
          'image':image,
        }),
        headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
        }
      );

      manageHttpRequest(res: response, context: context, onSuccess: ()async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final updatedUser = jsonDecode(response.body);
        final userJson = jsonEncode(updatedUser);
        await preferences.setString('user', userJson);
        ref.read(userProvider.notifier).setUser(userJson);
        Navigator.pop(context);
        WidgetsBinding.instance.addPostFrameCallback((_){
          showSnackBar(text: 'Your Profile Is Updated, Now You Can Explore!', context: context);
        });
      });

    }
    catch(e){
      print(e.toString());
      showSnackBar(text: e.toString(), context: context);
    }
}

  // sign-in user by otp

  // sign-out user
  Future<void> signOut({
    required BuildContext context,
    required WidgetRef ref,
  })async{

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(
              "Are you sure you want to logout?",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: ()async{
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      await preferences.remove('auth-token');
                      ref.read(userProvider.notifier).signOut();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route)=>false);
                      showSnackBar(
                          text:'Logout Successfully',
                        context: context
                      );
                    },
                    child: Text("Yes",
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface
                      ),
                    )
                ),
                SizedBox(width: 15,),
                TextButton(onPressed: ()=>Navigator.pop(context), child: Text("No",style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface
                ),))
              ],
            ),
          );
        }
    );
  }


  // profile pic
  


}