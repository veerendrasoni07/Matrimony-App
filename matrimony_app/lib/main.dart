import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony_app/provider/user_provider.dart';
import 'package:matrimony_app/views/authentication/login_screen.dart';
import 'package:matrimony_app/views/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    Future<void> checkTokenAndUser()async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth-token');
      String? user = preferences.getString('user');
      if(token!=null && user!=null){
        ref.read(userProvider.notifier).setUser(user);
      }
      else{
        ref.read(userProvider.notifier).signOut();
      }
    }

    return  MaterialApp(
      home: FutureBuilder(
          future: checkTokenAndUser(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            final user = ref.watch(userProvider);
            return user != null ? MainScreen() : LoginScreen();
          }
      ),
    );
  }
}
