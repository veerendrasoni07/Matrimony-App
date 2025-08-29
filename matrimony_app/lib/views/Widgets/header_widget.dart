import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*.15,
      width: MediaQuery.of(context).size.width,
      child:Stack(
        children: [
          Image.asset('assets/images/heart_bg.jpg',fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),
          Positioned(
            bottom: 20,
              left: 80,
              child: SizedBox(
                height: 50,
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Icon(Icons.search,color: Colors.grey,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    ),
                    filled: true,
                    fillColor: Colors.white
                    )
                ),
              )
          ),
        Positioned(
            top: 20,
            left: 5,
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
        ],
      ) ,
    );
  }
}
