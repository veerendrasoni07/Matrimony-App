import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_app/controller/auth_controller.dart';
import 'package:matrimony_app/views/authentication/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body:Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            Text("Create An Account!",style: GoogleFonts.montserrat(
              fontSize: 26,
              fontWeight: FontWeight.bold
            ),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter your name";
                  }
                  return null;
                },
                controller:fullNameController ,
                decoration: InputDecoration(
                  hintText: "Enter your full name here.",
                  hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700,
                    fontSize: 16
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller:emailController ,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter you email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter your email here.",
                  hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700,
                    fontSize: 16
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller:passController ,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter your password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter your password here.",
                  hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700,
                    fontSize: 16
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                    },
                    child: Text(
                  "Login Now",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueAccent.shade700
                  ),
                ))
              ],
            ),
            InkWell(
              onTap: (){
                if(formKey.currentState!.validate()){
                  authController.signUpUser(
                      email: emailController.text,
                      fullname: fullNameController.text,
                      context: context,
                      password: passController.text
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.pink
                ),
                child: Center(
                  child: Text(
                   "Submit",
                   style: GoogleFonts.openSans(
                     fontSize: 26,
                     fontWeight: FontWeight.w700
                   ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
