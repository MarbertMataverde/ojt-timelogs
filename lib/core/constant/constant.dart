class CoreConstant {
  //regex patterm
  static const regexPatternEmail =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
  static const String wrongPasswordMessage =
      'Sorry, that password is incorrect. Please try again or click \'Reset Password\' to update your password.';
  static const String userNotFoundMessage =
      'Sorry, we were unable to find an account with the provided information. Please double check your login credentials and try again. If you are having trouble accessing your account, you can try resetting your password or contacting our support team for assistance.';
  static const String userDisabledMessage =
      'Unfortunately, your account has been disabled by the application administrator. If you believe this is a mistake or have any questions, please contact the administrator for further assistance. Thank you for your understanding.';
  static const String tooManyRequestMessage =
      'Sorry, you have exceeded the maximum number of requests allowed for this application. Please try again later or contact the support team for assistance.';
  static const String networkRequestFailedMessage =
      'We apologize, but it looks like you are currently not connected to the internet. Please check your internet connection and try again.';

  static const String morningAssetPath = 'assets/gifs/morning.gif';
  static const String nightAssetPath = 'assets/gifs/night.gif';
  static const String sunriseAssetPath = 'assets/gifs/sunrise.gif';
}
