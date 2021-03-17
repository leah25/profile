import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Providers are declared globally and specifies how to create a state
// ignore: top_level_function_literal_block
final numberProvider = StateNotifierProvider((ref) {
  return Number();
});

class Number extends StateNotifier<String> {
  Number() : super('');

  number(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', phoneNumber);

    print('categoryList $phoneNumber');

    print('num $phoneNumber');

    state = phoneNumber;
  }
}
