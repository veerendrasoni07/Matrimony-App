import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony_app/controller/profile_pic_controller.dart';
import 'package:matrimony_app/provider/user_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  final ImagePicker picker = ImagePicker();
  File? image;
  final ProfilePicController profilePicController = ProfilePicController();
  void pickProfilePicFromGallery()async{
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final user = ref.read(userProvider);
    if(pickedImage!=null){
      setState(() {
        image = File(pickedImage.path);
      });
      await profilePicController.uploadProfilePic(userId: user!.id, image: image!, context: context,ref: ref);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Your Profile",style: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: 30
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: MediaQuery.of(context).size.height*.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TODO: Profile pic,username,name,edit profile option
                    GestureDetector(
                      onTap: (){
                        pickProfilePicFromGallery();
                      },
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey[400],
                        backgroundImage: image!=null ? FileImage(image!) : (user!.image.isNotEmpty ? NetworkImage(user.image) as ImageProvider : null),
                        child: (image==null && user!.image.isEmpty)  ? Text("${user!.fullname[0]}",style: GoogleFonts.montserrat(
                          fontSize: 50,
                          fontWeight: FontWeight.bold
                        ),) : null,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
