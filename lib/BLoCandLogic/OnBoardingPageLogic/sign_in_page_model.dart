part of 'sign_in_page_cubit.dart';

class SignInPageModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisibility = true;

  SignInPageModel(
      {TextEditingController? emailC,
      TextEditingController? passC,
      bool? passVis}) {
    if (emailC != null && passC != null && passVis != null) {
      emailController.text = emailC.text;
      passwordController.text = passC.text;
      passwordVisibility = passVis;
    }
  }

  void openSignUpPage(BuildContext context) {
    getOnBoardingPageBloc(context: context).setPage(
      getOnBoardingPageState(context: context).signUpPageKey,
    );
  }

  SignInPageModel copyWith() {
    return SignInPageModel(
      emailC: emailController,
      passVis: passwordVisibility,
      passC: passwordController,
    );
  }

  bool passwordValidate(BuildContext context) {
    String validate = passwordChecker(passwordController.text);
    if (validate.isEmpty) return true;
    showAlertDialog(context,error: validate);
    return false;
  }

  void forgetPassword(BuildContext context) async {
    AuthState state = AuthState();
    bool status = await state.sendPasswordResetEmail(emailController.text);
    if (!status && context.mounted) {
      showAlertDialog(context,);
    }
    if (status && context.mounted) {
      showAlertDialog(
        context,
        error: "Check your inbox",
        title: "Password change email has been sent.",
      );
    }
  }

  Future<bool> onPressedGoogleSignedIn(BuildContext context) async {
    AuthState authState = AuthState();
    bool loginStatus = await authState.letUserSignedInWithGoogle();
    return loginStatus;
  }

  Future<bool> onPressedLoginButton(
    BuildContext context,
  ) async {
    if (signInDebuggingEnabled) {
      emailController.text = debugUserId;
      passwordController.text = debugUserPassword;
    }
    if (!passwordValidate(context)) return false;
    AuthState authState = AuthState();
    bool loginStatus = await authState.letUserSignedInWithEmailAndPassword(
      emailController.text,
      passwordController.text,
    );
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
