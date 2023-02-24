import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

Future<dynamic> coreShowCustomDialogWidget({
  required BuildContext context,
  required String title,
  required String content,
  String? assetPath, // default: notice animated icon
  String? buttonLeftText,
  String? buttonRightText,
  bool? isContentCentered,
  bool? isTwoButton = false,
  TextStyle? contentTextStyle,
  Function()? buttonLeftVoidCallback,
  Function()? buttonRightVoidCallback,
}) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 200,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: RiveAnimation.asset(
                      assetPath ?? 'assets/rive/alert_icon.riv',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: isContentCentered ?? false
                    ? Alignment.center
                    : Alignment.centerLeft,
                child: Text(
                  content,
                  style: contentTextStyle,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: isTwoButton == true
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: isTwoButton ?? true,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,
                      ),
                      onPressed: buttonLeftVoidCallback ??
                          () => Navigator.pop(context),
                      child: Text(
                        buttonLeftText ?? 'Dismiss',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed:
                        buttonRightVoidCallback ?? () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      buttonRightText ?? 'Okay, Continue',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
