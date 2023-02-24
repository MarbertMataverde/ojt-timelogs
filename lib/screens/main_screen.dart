import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ojt_timelogs/authentication/auth_logout.dart';
import 'package:ojt_timelogs/core/constant/constant.dart';
import 'package:ojt_timelogs/core/widget/core_show_dialog.dart';
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
    super.initState();
  }

  DateFormat dateFormat = DateFormat('MMMM d (EEEE)').add_jm();

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
            color: Colors.black.withOpacity(0.1),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.white38,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 120),
            child: Align(
              alignment: Alignment.topRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.white38,
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
                          onPressed: () {},
                        ),
                      ),
                    ],
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
