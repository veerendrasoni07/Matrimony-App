

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_app/controller/auth_controller.dart';
import 'package:matrimony_app/provider/user_provider.dart';
import 'package:matrimony_app/views/Widgets/header_widget.dart';
import 'package:matrimony_app/views/Widgets/profile_widget.dart';
import 'package:matrimony_app/views/authentication/setup_profile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}
bool isShownModal = false;
class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final user = ref.watch(userProvider);
    if( !isShownModal && user!.dob.isEmpty){
      WidgetsBinding.instance.addPostFrameCallback((_){
        isShownModal = true;
        showProfileDialog();
      });
    }
  }

  void showProfileDialog(){
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        useSafeArea: true,
        useRootNavigator: true,
        enableDrag: true,
        builder: (context){
          return SetupProfile();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider.notifier);
    final userData = ref.watch(userProvider);
    print(userData!.image);
    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: Drawer(),
      appBar: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.20), child: const HeaderWidget()),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: (){
                AuthController().signOut(context: context, ref: ref);
              },
              child:Text("Log-Out")
          ),
          Text(
            "Suggestions",
            style: GoogleFonts.cabinSketch(
            fontSize: 26,
            fontWeight: FontWeight.bold
            ),
          ),
          Expanded(child: ProfileWidget(user: userData!))
        ],
      ),
    );
  }
}
