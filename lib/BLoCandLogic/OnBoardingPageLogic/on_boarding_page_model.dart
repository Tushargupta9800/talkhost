part of 'on_boarding_page_cubit.dart';

class OnBoardingPageModel{

  static String pageOpen = "SignIn";
  String signInPageKey = "SignIn";
  String signUpPageKey = "SignUp";
  String homeKey = "Home";
  String contactUsKey = "Contact Us";
  String aboutUsKey = "About Us";
  static bool loadingScreenVisibility = false;

  void changePage(String key){
    pageOpen = key;
  }

  void changeVisibility(){
    loadingScreenVisibility = !loadingScreenVisibility;
  }

  Widget getPageOnBoarding(){
    if(pageOpen == "SignIn"){
      return const SignInPage();
    }
    else if(pageOpen == "SignUp"){
      return const SignUpPage();
    }

    return const OnBoardingMainPage();
  }

  OnBoardingPageModel copyWith(){
    return OnBoardingPageModel();
  }

}