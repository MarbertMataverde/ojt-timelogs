import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojt_timelogs/authentication/auth_login.dart';
import 'package:ojt_timelogs/core/constant/constant.dart';
import 'package:ojt_timelogs/core/validator/validator.dart';
import 'package:ojt_timelogs/core/widget/core_loading_animation.dart';
import 'package:ojt_timelogs/main.dart';
import 'package:video_player/video_player.dart';

final isSigningInStateProvider = StateProvider((ref) => false);

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController internEmail;
  late final TextEditingController internPassword;

  // video player controller
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    internEmail = TextEditingController();
    internPassword = TextEditingController();
    videoPlayerController =
        VideoPlayerController.asset(CoreConstant.morningAssetPath)
          ..initialize().then((value) {
            videoPlayerController.play();
            videoPlayerController.setLooping(true);
            setState(() {});
          });
  }

  @override
  void dispose() {
    internEmail.dispose();
    internPassword.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f7f9),
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                height: videoPlayerController.value.size.height,
                width: videoPlayerController.value.size.width,
                child: VideoPlayer(videoPlayerController),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'OJT TIMELOGS LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: internEmail,
                          hintText: 'Intern Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: internEmailValidator,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: internPassword,
                          hintText: 'Password',
                          isPassword: true,
                          validator: passwordValidator,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return ref.watch(isSigningInStateProvider)
                          ? coreLoadingAnimationWidget()
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black87,
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    ref
                                        .read(isSigningInStateProvider.notifier)
                                        .update((state) => !ref
                                            .read(isSigningInStateProvider));
                                    await internLogin(
                                      context: context,
                                      internEmail: internEmail.text,
                                      internPassword: internPassword.text,
                                    );
                                    ref
                                        .read(isSigningInStateProvider.notifier)
                                        .update((state) => !ref
                                            .read(isSigningInStateProvider));
                                  }
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
