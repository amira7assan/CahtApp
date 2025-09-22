import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/screens/register_screen.dart';
import '../constants.dart';
import '../helper/showSnackBar.dart';
import '../widgets/custom_Buton.dart';
import '../widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/screens/register_screen.dart';
import 'package:scholar_chat/screens/cubits/ChatCubit/chat_cubit.dart';
import 'chat_screen.dart';
import 'cubits/authenticationCubit/auth_cubit.dart';

class LoginPage extends StatelessWidget {
  bool isLoading = false;
  static String id = 'Login Page';
  GlobalKey<FormState> formkey = GlobalKey();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is LoginLoading)
          isLoading = true ;
        else if (state is LoginFailure) {
          showSnakBar(context, state.errorMsg);
          isLoading = false;
        }        else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatScreen.id);
          isLoading = false;
        }},
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  SizedBox(height: 70,),
                  Image.asset('assets/images/scholar.png',
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Scholar Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  CustomFormTextField(
                    onchange: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  SizedBox(height: 15),
                  CustomFormTextField(
                    obscureText: true,
                    onchange: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(height: 25),
                  CustomButon(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        if (email != null && email!.isNotEmpty &&
                            password != null && password!.isNotEmpty) {
                          BlocProvider.of<AuthCubit>(context)
                              .LoginUser(email: email!, password: password!);
                        } else {
                          showSnakBar(context, "Please enter both email and password");
                        }
                      }
                    },
                    title: 'Login',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                            color: Color(0XFFC7EDE6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
