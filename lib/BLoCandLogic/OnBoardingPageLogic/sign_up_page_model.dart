part of 'sign_up_page_cubit.dart';

class SignUpPageModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisibility = true;

  SignUpPageModel(
      {TextEditingController? emailC,
      TextEditingController? passC,
      bool? passVis}) {
    if (emailC != null && passC != null && passVis != null) {
      emailController.text = emailC.text;
      passwordController.text = passC.text;
      passwordVisibility = passVis;
    }
  }

  void openSignInPage(BuildContext context) {
    getOnBoardingPageBloc(context: context).setPage(
      getOnBoardingPageState(context: context).signInPageKey,
    );
  }

  SignUpPageModel copyWith() {
    return SignUpPageModel(
      emailC: emailController,
      passVis: passwordVisibility,
      passC: passwordController,
    );
  }

  bool passwordValidate(BuildContext context){
    String validate = passwordChecker(passwordController.text);
    if(validate.isEmpty) return true;
    showAlertDialog(context,error: validate);
    return false;
  }

  Future<bool> onPressedGoogleSignedIn(BuildContext context) async {
    AuthState authState = AuthState();
    bool loginStatus = await authState.letUserSignedInWithGoogle();
    return loginStatus;
  }

  Future<bool> onPressedSignUpButton(
    BuildContext context,
  ) async {
    if(!passwordValidate(context)) return false;
    AuthState authState = AuthState();
    bool loginStatus = await authState.letUserSignedInWithEmailAndPassword(
      emailController.text,
      passwordController.text,
    );
    if (!loginStatus) {
      loginStatus = await authState.createUserWithLoginAndPassword(
        emailController.text,
        passwordController.text,
      );
    }
    return loginStatus;
  }

  void openDrawer(BuildContext context) {
    navigateTo(
      context: context,
      route: DrawerPage.routeNamex,
      enablePopAndPush: true,
    );
  }
}
