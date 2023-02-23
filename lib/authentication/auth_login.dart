import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ojt_timelogs/core/constant/constant.dart';
import 'package:ojt_timelogs/core/widget/core_show_dialog.dart';

Future<void> internLogin({
  required BuildContext context,
  required String internEmail,
  required String internPassword,
}) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: internEmail, password: internPassword);
  } on FirebaseAuthException catch (error) {
    switch (error.code) {
      case 'wrong-password':
        coreShowCustomDialogWidget(
            context: context,
            title: 'Wrong Password',
            content: CoreConstant.wrongPasswordMessage);
        break;
      case 'user-not-found':
        coreShowCustomDialogWidget(
            context: context,
            title: 'User Not Found',
            content: CoreConstant.userNotFoundMessage);
        break;
      case 'user-disabled':
        coreShowCustomDialogWidget(
            context: context,
            title: 'User Disabled',
            content: CoreConstant.userDisabledMessage);
        break;
      case 'too-many-requests':
        coreShowCustomDialogWidget(
            context: context,
            title: 'Too Many Request',
            content: CoreConstant.tooManyRequestMessage);
        break;
      case 'network-request-failed':
        coreShowCustomDialogWidget(
            context: context,
            title: 'No Internet Connection',
            content: CoreConstant.networkRequestFailedMessage);
        break;
      default:
        coreShowCustomDialogWidget(
            context: context,
            title: error.code,
            content: error.message.toString());
    }
  } catch (error) {
    coreShowCustomDialogWidget(
      context: context,
      title: 'Something Went Wrong',
      content: error.toString(),
    );
  }
}
