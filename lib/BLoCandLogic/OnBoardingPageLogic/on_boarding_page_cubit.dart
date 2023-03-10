import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/Pages/OnBoardingPages/on_boarding_main.dart';
import 'package:talkhost/Pages/OnBoardingPages/sign_in_page.dart';
import 'package:talkhost/Pages/OnBoardingPages/sign_up_page.dart';
import 'package:talkhost/Utilities/routes.dart';

import '../../Pages/DrawerPages/drawer.dart';

part 'on_boarding_page_model.dart';

class OnBoardingPageCubit extends Cubit<OnBoardingPageModel> {
  OnBoardingPageCubit() : super(OnBoardingPageModel());

  void setPage(String key){
    state.changePage(key);
    emit(state.copyWith());
  }

  Widget getOnBoardingPage(){
    return state.getPageOnBoarding();
  }

}
