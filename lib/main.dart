import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/DrawerPagesLogic/create_meet_cubit.dart';
import 'package:talkhost/BLoCandLogic/DrawerPagesLogic/drawer_cubit.dart';
import 'package:talkhost/BLoCandLogic/DrawerPagesLogic/edit_profile_cubit.dart';
import 'package:talkhost/BLoCandLogic/DrawerPagesLogic/my_hosted_meet_cubit.dart';
import 'package:talkhost/BLoCandLogic/OnBoardingPageLogic/on_boarding_page_cubit.dart';
import 'package:talkhost/BLoCandLogic/OnBoardingPageLogic/sign_in_page_cubit.dart';
import 'package:talkhost/BLoCandLogic/OnBoardingPageLogic/sign_up_page_cubit.dart';
import 'package:talkhost/Pages/OnBoardingPages/on_boarding_page.dart';
import 'package:talkhost/Utilities/routes.dart';
import 'package:talkhost/Utilities/secrets.dart';
import 'package:talkhost/Utilities/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Secrets secret = Secrets();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: secret.apiKey,
      authDomain: secret.authDomain,
      projectId: secret.projectId,
      storageBucket: secret.storageBucket,
      messagingSenderId: secret.messagingSenderId,
      appId: secret.appId,
      measurementId: secret.measurementId,
    ),
  );
  runApp(
    const TalkHost(),
  );
}

class TalkHost extends StatelessWidget {
  const TalkHost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnBoardingPageCubit()),
        BlocProvider(create: (context) => SignInPageCubit()),
        BlocProvider(create: (context) => SignUpPageCubit()),
        BlocProvider(create: (context) => DrawerCubit()),
        BlocProvider(create: (context) => EditProfileCubit()),
        BlocProvider(create: (context) => CreateMeetCubit()),
        BlocProvider(create: (context) => MyHostedMeetCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TalkHost",
        theme: ThemeData(
          primaryColor: ThemeD.primaryColor,
          primarySwatch: ThemeD.primaryMaterialColor
        ),
        home: const OnBoardingPage(),
      ),
    );
  }
}
