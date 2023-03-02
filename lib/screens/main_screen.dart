import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:ojt_timelogs/authentication/auth_logout.dart';
import 'package:ojt_timelogs/core/constant/constant.dart';
import 'package:ojt_timelogs/core/widget/core_add_intern_dialog.dart';
import 'package:ojt_timelogs/core/widget/core_show_dialog.dart';
import 'package:ojt_timelogs/services/serive_time_out_record.dart';
import 'package:ojt_timelogs/services/service_time_in_record.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late final String timeNow;

  String getBackgroundAssetPath() {
    if (timeNow == '6 PM' ||
        timeNow == '7 PM' ||
        timeNow == '8 PM' ||
        timeNow == '9 PM' ||
        timeNow == '10 PM' ||
        timeNow == '11 PM' ||
        timeNow == '12 AM' ||
        timeNow == '1 AM' ||
        timeNow == '2 AM') {
      return CoreConstant.nightAssetPath;
    } else if (timeNow == '3 AM' ||
        timeNow == '4 AM' ||
        timeNow == '5 AM' ||
        timeNow == '6 AM') {
      return CoreConstant.sunriseAssetPath;
    } else {
      return CoreConstant.morningAssetPath;
    }
  }

  @override
  void initState() {
    timeNow = DateFormat('j').format(DateTime.now());
    currentUserName = FirebaseAuth.instance.currentUser!.displayName;
    super.initState();
  }

  late String? currentUserName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              getBackgroundAssetPath(),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Row(
              children: [
                Text(
                  currentUserName.toString() == 'null'
                      ? 'Admin'
                      : currentUserName.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: FirebaseAuth.instance.currentUser!.uid ==
                      CoreConstant.adminUid,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    label: const Text(
                      'Add Intern',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (context) => const CoreAddInternDialog(),
                      );
                    },
                    icon: const Icon(
                      Icons.person_add_alt_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  label: const Text(
                    'History',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => logout(),
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'v1.0.0',
              style: TextStyle(
                color: Colors.white60,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DigitalClock(
                    hourMinuteDigitTextStyle: const TextStyle(
                      fontSize: 80,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    secondDigitTextStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    colon: const Text(
                      ":",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    is24HourTimeFormat: false,
                    amPmDigitTextStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Time In'),
                          onPressed: () {
                            coreShowCustomDialogWidget(
                              buttonRightText: 'Confirm',
                              buttonRightVoidCallback: () => timeInRecord(
                                internName: currentUserName.toString(),
                                activeInternTimeIn: Timestamp.now(),
                                context: context,
                              ).then((value) => Navigator.pop(context)),
                              context: context,
                              title: 'Confirm Time In',
                              isTwoButton: true,
                              isContentCentered: true,
                              buttonLeftText: 'Cancel',
                              contentTextStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              content: dateFormat.format(
                                DateTime.now(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Time Out'),
                          onPressed: () {
                            coreShowCustomDialogWidget(
                              buttonRightText: 'Confirm',
                              buttonRightVoidCallback: () => timeOutRecord(
                                context: context,
                                internName: currentUserName.toString(),
                              ).then((value) => Navigator.pop(context)),
                              context: context,
                              title: 'Confirm Time Out',
                              isTwoButton: true,
                              isContentCentered: true,
                              buttonLeftText: 'Cancel',
                              contentTextStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              content: dateFormat.format(
                                DateTime.now(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(currentUserName.toString())
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Text('No Data');
                        } else {
                          final data = snapshot.data!.docs;

                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SpinKitPulse(
                                  color: Colors.green,
                                  size: 40.0,
                                ),
                                const Text(
                                  'Active Time In',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                // dateFormat.format(data[0]['time-in'])
                                ConvertedTimestampToFormatedDateTime(
                                  timestamp: data[0]['time-in'],
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DateFormat dateFormat = DateFormat('MMMM d (EEEE)').add_jm();

class ConvertedTimestampToFormatedDateTime extends StatelessWidget {
  final Timestamp timestamp;

  const ConvertedTimestampToFormatedDateTime(
      {super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = timestamp.toDate();
    String formattedDateTime = dateFormat.format(dateTime);
    return Text(
      formattedDateTime,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
