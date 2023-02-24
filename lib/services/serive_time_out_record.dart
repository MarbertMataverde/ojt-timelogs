import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat('MMMM d (EEEE)').add_jm();

Future<void> timeOutRecord({
  required BuildContext context,
  required String internName,
}) async {
  // this will get the active time in timestamp
  late Timestamp timeIn;
  await FirebaseFirestore.instance
      .collection(internName)
      .doc('active-time-in')
      .get()
      .then((value) async => timeIn = await value.get('time-in'));

  // this will record the time in and out to time-in-and-out-doc as random docs
  await FirebaseFirestore.instance
      .collection(internName)
      .doc('time-in-and-out-records')
      .collection('records')
      .doc()
      .set({
    'intern-name': internName,
    'time-in': dateFormat.format(timeIn.toDate()),
    'time-out': dateFormat.format(DateTime.now()),
  });

  // this delete active time in
  await FirebaseFirestore.instance
      .collection(internName)
      .doc('active-time-in')
      .delete();
}
