import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_app/controller/auth_controller.dart';
import 'package:matrimony_app/views/authentication/register_screen.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final AuthController authController = AuthController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome Back",
              style: GoogleFonts.montserrat(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ) ,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter Your email";
                  }
                  else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter Your Password";
                  }
                  else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
           SizedBox(height: 5,),
           Text(
             'OR',
             style: GoogleFonts.poppins(
             fontWeight: FontWeight.bold,
             fontSize: 24
           ),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Login With OTP",
                style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                  letterSpacing: 2
              ),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: GestureDetector(
                onTap: ()async{
                  if(formKey.currentState!.validate()){
                    await authController.signInUser(
                        email: emailController.text,
                        password: passController.text,
                        ref: ref,
                        context: context
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.pinkAccent
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        letterSpacing: 2,
                      ),),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>RegisterScreen()));
                    },
                    child: Text(
                      "Register Now",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue.shade700
                    ),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
