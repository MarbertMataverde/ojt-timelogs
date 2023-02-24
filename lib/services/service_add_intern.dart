import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> addNewIntern({
  required BuildContext context,
  required String newInternName,
  required String newInternEmail,
  required String newInternpassword,
}) async {
  FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: newInternEmail, password: newInternpassword)
      .then(
        (value) => value.user!.updateDisplayName(newInternName),
      )
      .then((value) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Yey! Named $newInternName added!',
        ),
      ),
    );
  }).whenComplete(
    () {
      Navigator.pop(context);
    },
  );
}
