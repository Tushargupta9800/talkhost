import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/OnBoardingPageLogic/sign_in_page_cubit.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';
import 'package:talkhost/Utilities/buttons.dart';
import 'package:talkhost/Utilities/debuggin_handler.dart';
import 'package:talkhost/Utilities/textfields.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
          controller: getSignInPageModel(context: context).emailController,
        ),
        authTextField(
          title: "Password",
          controller: getSignInPageModel(context: context).passwordController,
          visible: getSignInPageModel(context: context).passwordVisibility,
          onPressed: () {
            getSignInPageCubit(context: context).changeVisibility();
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              getSignInPageModel(context: context).forgetPassword(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            child: const Text(
              "Forget Password",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        pushButton(
            title: "SignIn",
            onPressed: () {
              getSignInPageCubit(context: context).onPressedLoginButton(context);
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
            getSignInPageCubit(context: context).onPressedGoogleButton(context);
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
  Widget build(BuildContext context) {
    if(signInDebuggingEnabled) {
      Future.delayed(Duration.zero).then((value) {
        getSignInPageCubit(context: context).onPressedLoginButton(context);
      });
    }
    return BlocBuilder<SignInPageCubit, SignInPageModel>(
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
                    'Sign In to \nTalkHost',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "If you don't have an account",
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
                          getSignInPageModel(context: context)
                              .openSignUpPage(context);
                        },
                        child: const Text(
                          "Register here!",
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
