part of 'on_boarding_page_cubit.dart';

class OnBoardingPageModel {
  static String pageOpen = "SignIn";
  String signInPageKey = "SignIn";
  String signUpPageKey = "SignUp";
  String homeKey = "Home";
  String contactUsKey = "Contact Us";
  String aboutUsKey = "About Us";

  void changePage(String key) {
    pageOpen = key;
  }

  Widget getPageOnBoarding() {
    if (pageOpen == "SignIn") {
      return const SignInPage();
    } else if (pageOpen == "SignUp") {
      return const SignUpPage();
    }

    return const OnBoardingMainPage();
  }

  OnBoardingPageModel copyWith() {
    return OnBoardingPageModel();
  }

  void openDrawer(BuildContext context) {
    navigateTo(
      context: context,
      route: DrawerPage.routeNamex,
      enablePopAndPush: true,
    );
  }
}
