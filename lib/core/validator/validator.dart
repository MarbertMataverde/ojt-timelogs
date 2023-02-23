import 'package:ojt_timelogs/core/constant/constant.dart';

String? internEmailValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter your intern email';
  }
  if (!RegExp(CoreConstant.regexPatternEmail).hasMatch(value)) {
    return 'Please enter a valid intern email';
  }
  return null;
}

String? passwordValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter an password';
  }
  return null;
}
