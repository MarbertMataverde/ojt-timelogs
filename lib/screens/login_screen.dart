import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojt_timelogs/authentication/auth_login.dart';
import 'package:ojt_timelogs/core/validator/validator.dart';
import 'package:ojt_timelogs/core/widget/core_loading_animation.dart';
import 'package:ojt_timelogs/main.dart';
import 'package:rive/rive.dart';

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

  @override
  void initState() {
    super.initState();
    internEmail = TextEditingController();
    internPassword = TextEditingController();
  }

  @override
  void dispose() {
    internEmail.dispose();
    internPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0b1f24),
      body: Column(
        children: [
          const Expanded(
            child: RiveAnimation.asset(
              'assets/rive/work.riv',
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              width: 500,
              child: Column(
                children: [
                  const Text(
                    'OJT TIMELOGS LOGIN',
                    style: TextStyle(
                      color: Color(0xffafc5e9),
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
                  Consumer(builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return ref.watch(isSigningInStateProvider)
                        ? coreLoadingAnimationWidget()
                        : SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(isSigningInStateProvider.notifier)
                                      .update((state) =>
                                          !ref.read(isSigningInStateProvider));
                                  await internLogin(
                                    context: context,
                                    internEmail: internEmail.text,
                                    internPassword: internPassword.text,
                                  );
                                  ref
                                      .read(isSigningInStateProvider.notifier)
                                      .update((state) =>
                                          !ref.read(isSigningInStateProvider));
                                }
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}