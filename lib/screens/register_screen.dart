
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_screen_with_bloc_firebase/components/custom_button.dart';
import 'package:login_register_screen_with_bloc_firebase/components/custom_clickable_text.dart';
import 'package:login_register_screen_with_bloc_firebase/components/custom_text.dart';
import 'package:login_register_screen_with_bloc_firebase/components/custom_text_field.dart';
import 'package:login_register_screen_with_bloc_firebase/cubit/auth_cubit.dart';
import 'package:login_register_screen_with_bloc_firebase/cubit/auth_state.dart';
import 'package:login_register_screen_with_bloc_firebase/screens/login_screen.dart';

import '../constants/colors.dart';
import 'final_screen.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  static String id = 'RegisterScreen';
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit , AuthState>(
      listener: (BuildContext context, state) {
        if(state is RegisterLoading){
          Text('Loading');
        }
        else if(state is RegisterSuccess){
          Navigator.pushNamed(context, FinalScreen.id);
        }
        else if(state is RegisterFailure){
          showSnackBar(context, state.errMessage);
        }
      },
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customText(text: 'Create Account', size: 32),
                  CustomTextField(
                      hintText: 'Mail ID',
                    onChanged: (data){
                        email = data;
                    },
                  ),
                 // CustomTextField(hintText: 'Full Name'),
                  CustomTextField(
                      hintText: 'Password',
                      isHidden: true,
                    onChanged: (data){
                        password = data;
                    },
                  ),
                  CustomButton(
                    textLabel: 'Create',
                    color: kPrimaryColor,
                    onTap: () async{
                     if(formKey.currentState!.validate()){
                       BlocProvider.of<AuthCubit>(context).register(email: email!, password: password!);
                     }
                    },
                  ),
                  CustomClickableText(
                      text: 'Login',
                      onTap: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.id);
                      },
                      color: kPrimaryColor,
                      size: 18
                      )
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
}

