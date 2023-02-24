import 'package:firebase_auth/firebase_auth.dart';

Future<void> logout() async {
  FirebaseAuth.instance.signOut();
}
