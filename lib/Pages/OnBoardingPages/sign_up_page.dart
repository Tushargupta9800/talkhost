import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/OnBoardingPageLogic/sign_up_page_cubit.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';

import '../../Utilities/buttons.dart';
import '../../Utilities/textfields.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Widget _formLogin() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "Assets/Images/talkhost_logo.png",
                width: 50,
              ),
              Image.asset(
                "Assets/Images/talkhost_text.png",
                width: 150,
              ),
            ],
          ),
        ),
        authTextField(
          title: "Email",
          controller: getSignUpPageModel(context: context).emailController,
        ),
        authTextField(
            title: "Password",
            controller: getSignUpPageModel(context: context).passwordController,
            visible: getSignUpPageModel(context: context).passwordVisibility,
            onPressed: () {
              getSignUpPageCubit(context: context).changeVisibility();
            }),
        pushButton(
            title: "SignUp",
            onPressed: () {
              getSignUpPageCubit(context: context)
                  .onPressedSignUpButton(context);
            }),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey[400],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Or continue with"),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            getSignUpPageCubit(context: context).onPressedGoogleButton(context);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.grey)),
            child: Center(
              child: Image.asset(
                "Assets/Images/google.png",
                width: 150,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    getSignUpPageModel(context: context).emailController.dispose();
    getSignUpPageModel(context: context).passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpPageCubit, SignUpPageModel>(
        builder: (context, snapshot) {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up to \nTalkHost',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "You can",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          getSignUpPageModel(context: context)
                              .openSignInPage(context);
                        },
                        child: const Text(
                          "Login here!",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'Assets/Images/illustration-2.png',
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
            Image.asset(
              'Assets/Images/illustration-1.png',
              width: MediaQuery.of(context).size.width / 3 - 80,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.symmetric(vertical: 100),
              width: MediaQuery.of(context).size.width / 3,
              child: _formLogin(),
            ),
          ],
        ),
      );
    });
  }
}
