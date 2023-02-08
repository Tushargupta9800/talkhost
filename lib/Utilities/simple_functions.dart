
final RegExp _passwordRegex = RegExp(
  r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$',
);

String passwordChecker(String password){
  if(password.length < 8) {
    return 'Password must contains at least 8 letters';
  } else if (!_passwordRegex.hasMatch(password)) {
    return 'Invalid Password.\nPassword must contain at least\n1 uppercase letter. \n1 lowercase letter.\n1 number.\nshould be 8 characters long';
  }
  return '';
}