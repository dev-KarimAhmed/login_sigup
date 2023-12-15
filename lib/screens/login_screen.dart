import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_screen_with_bloc_firebase/components/custom_button.dart';
import 'package:login_register_screen_with_bloc_firebase/components/custom_clickable_text.dart';
import 'package:login_register_screen_with_bloc_firebase/components/custom_text.dart';
import 'package:login_register_screen_with_bloc_firebase/components/custom_text_field.dart';
import 'package:login_register_screen_with_bloc_firebase/cubit/auth_cubit.dart';
import 'package:login_register_screen_with_bloc_firebase/cubit/auth_state.dart';
import 'package:login_register_screen_with_bloc_firebase/screens/final_screen.dart';
import 'package:login_register_screen_with_bloc_firebase/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email;

  String? password;

  TextEditingController mailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          Text('Loading');
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, FinalScreen.id);
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errMessage);
        }
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customText(text: 'Welcome Back!', size: 32),
                  customText(text: 'Login to Continue', size: 22),
                  CustomTextField(
                    hintText: 'Mail ID',
                    onChanged: (data) {
                      email = data;
                    },
                    controller: mailController,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    isHidden: true,
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  CustomClickableText(
                    text: 'Forgot Password?',
                    onTap: () {
                      Navigator.pushNamed(context, RegisterScreen.id);
                    },
                    color: kSecondaryColor,
                    size: 18,
                  ),
                  CustomButton(
                    textLabel: 'Login',
                    color: kSecondaryColor,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context)
                            .login(email: email!, password: password!);
                      }
                    },
                  ),
                  CustomButton(
                    textLabel: 'Login by GOOGLE',
                    color: kSecondaryColor,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context).signInWithGoogle();
                      }
                    },
                  ),
                  CustomClickableText(
                      text: 'CREATE ACCOUNT',
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.id);
                      },
                      color: kSecondaryColor,
                      size: 18)
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  await  prefs.setString('mail', mailController.text);
   await prefs.setString('password', passwordController.text);
  }
}
