import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> timeInRecord({
  required BuildContext context,
  required String internName,
  required Timestamp activeInternTimeIn,
}) async {
  // this will check if there is an active time in
  // if yes it will just show a snackbar telling thats there is a
  // current active time in
  await FirebaseFirestore.instance
      .collection(internName)
      .doc('active-time-in')
      .get()
      .then((value) async {
    if (value.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'There is an active time in, you cannot time in multiple times.',
          ),
        ),
      );
    } else {
      await FirebaseFirestore.instance
          .collection(internName)
          .doc('active-time-in')
          .set({
        'intern-name': internName,
        'time-in': activeInternTimeIn,
        'time-out': 'Nothing yet'
      });
    }
  });
}
