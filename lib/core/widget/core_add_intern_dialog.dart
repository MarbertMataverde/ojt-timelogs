import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojt_timelogs/core/validator/validator.dart';
import 'package:ojt_timelogs/core/widget/core_loading_animation.dart';
import 'package:ojt_timelogs/main.dart';
import 'package:ojt_timelogs/services/service_add_intern.dart';

final isAddingNewInternStateProvider = StateProvider<bool>((ref) {
  return false;
});

class CoreAddInternDialog extends ConsumerStatefulWidget {
  const CoreAddInternDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CoreAddInternDialogState();
}

class _CoreAddInternDialogState extends ConsumerState<CoreAddInternDialog> {
  late TextEditingController newInternName;
  late TextEditingController newInternEmail;
  late TextEditingController newInternPassword;
  @override
  void initState() {
    super.initState();
    newInternName = TextEditingController();
    newInternEmail = TextEditingController();
    newInternPassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    newInternName.dispose();
    newInternEmail.dispose();
    newInternPassword.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.black.withOpacity(0.4),
        child: SizedBox(
          width: 350,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'New Intern Form',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        hintText: 'Intern Full Name',
                        controller: newInternName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name required!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: 'Email',
                        controller: newInternEmail,
                        validator: internEmailValidator,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: 'Password',
                        controller: newInternPassword,
                        validator: passwordValidator,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(isAddingNewInternStateProvider)
                        ? coreLoadingAnimationWidget()
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(isAddingNewInternStateProvider
                                          .notifier)
                                      .update((state) => !ref.read(
                                          isAddingNewInternStateProvider));
                                  await addNewIntern(
                                    context: context,
                                    newInternName: newInternName.text,
                                    newInternEmail: newInternEmail.text,
                                    newInternpassword: newInternPassword.text,
                                  );
                                  ref
                                      .read(isAddingNewInternStateProvider
                                          .notifier)
                                      .update((state) => !ref.read(
                                          isAddingNewInternStateProvider));
                                }
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
