import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebasAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebasAuthProvider).authStateChanges());

final authUidProvider =
    Provider<String?>((ref) => ref.watch(authStateChangesProvider).value?.uid);
