import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/screens/login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helper/showSnackBar.dart';
import '../widgets/custom_Buton.dart';
import '../widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';
import 'cubits/registerCubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  static String id = 'register';

  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterScreen>(
      listener: (context, state) {
          if(state is RegisterLoading)
            isLoading = true ;
          else if (state is RegisterFailure) {
            showSnakBar(context, state.errorMSG);
            isLoading = false;
          }        else if (state is RegisterSuccess) {
            Navigator.pushNamed(context, ChatScreen.id);
            isLoading = false;
          }      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                    Image.asset('assets/images/scholar.png', height: 100,),
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
                          "REGISTER",
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
                        email = data; // Correct assignment
                      },
                      hintText: 'Email', // Correct hint
                    ),
                    SizedBox(height: 15),
                    CustomFormTextField(
                      onchange: (data) {
                        password = data; // Correct assignment
                      },
                      hintText: 'Password', // Correct hint
                    ),
                    SizedBox(height: 25),
                    CustomButon(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context)
                              .RegisterUser(email: email!, password: password!);
                        }
                        else {}
                      },
                      title: 'REGISTER',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            ' LOGIN',
                            style: TextStyle(color: Color(0XFFC7EDE6)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}




