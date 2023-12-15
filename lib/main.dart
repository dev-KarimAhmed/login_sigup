import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_screen_with_bloc_firebase/cubit/auth_cubit.dart';
import 'package:login_register_screen_with_bloc_firebase/screens/final_screen.dart';
import 'package:login_register_screen_with_bloc_firebase/screens/login_screen.dart';
import 'package:login_register_screen_with_bloc_firebase/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
 
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          FinalScreen.id: (context) => FinalScreen()
        },
        title: 'Login-Register',
        initialRoute: getData() == null ? LoginScreen.id : FinalScreen.id,
      ),
    );
  }

  Future<List<String?>> getData()async{
          SharedPreferences prefs =await SharedPreferences.getInstance();
  final String? mail =  prefs.getString('mail');
  final String? password =  prefs.getString('password');
  return [mail,password];
  }
}
