import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiTokenProvider = FutureProvider.autoDispose<String>((ref) async {
  final firebaseToken = await FirebaseMessaging.instance.getToken();

  print('device Id $firebaseToken');

  return firebaseToken;
});
