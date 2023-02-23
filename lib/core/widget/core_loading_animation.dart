import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

Align coreLoadingAnimationWidget() {
  return const Align(
    alignment: Alignment.center,
    child: SizedBox(
      width: 40,
      height: 40,
      child: RiveAnimation.asset('assets/rive/loading.riv'),
    ),
  );
}
