import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/DrawerPagesLogic/drawer_cubit.dart';
import 'package:talkhost/BLoCandLogic/DrawerPagesLogic/edit_profile_cubit.dart';
import 'package:talkhost/BLoCandLogic/OnBoardingPageLogic/on_boarding_page_cubit.dart';
import 'package:talkhost/BLoCandLogic/OnBoardingPageLogic/sign_in_page_cubit.dart';

import 'OnBoardingPageLogic/sign_up_page_cubit.dart';

OnBoardingPageCubit getOnBoardingPageBloc({required BuildContext context}){
  return BlocProvider.of<OnBoardingPageCubit>(context);
}

OnBoardingPageModel getOnBoardingPageState({required BuildContext context}){
  return getOnBoardingPageBloc(context: context).state;
}

SignInPageCubit getSignInPageCubit({required BuildContext context}){
  return BlocProvider.of<SignInPageCubit>(context);
}

SignInPageModel getSignInPageModel({required BuildContext context}){
  return getSignInPageCubit(context: context).state;
}
SignUpPageCubit getSignUpPageCubit({required BuildContext context}){
  return BlocProvider.of<SignUpPageCubit>(context);
}

SignUpPageModel getSignUpPageModel({required BuildContext context}){
  return getSignUpPageCubit(context: context).state;
}

DrawerCubit getDrawerPageCubit({required BuildContext context}){
  return BlocProvider.of<DrawerCubit>(context);
}

DrawerState getDrawerPageState({required BuildContext context}){
  return getDrawerPageCubit(context: context).state;
}

EditProfileCubit getEditProfileCubit({required BuildContext context}){
  return BlocProvider.of<EditProfileCubit>(context);
}

EditProfileState getEditProfileState({required BuildContext context}){
  return getEditProfileCubit(context: context).state;
}
