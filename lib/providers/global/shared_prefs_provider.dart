import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProvider = FutureProvider.autoDispose((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ref.maintainState = true;
  return prefs;
});
