import 'package:hooks_riverpod/hooks_riverpod.dart';

final billsPageProvider = StateProvider<String>((ref) => "pay");
final foodPageProvider = StateProvider<String>((ref) => "register");
final rentPageProvider = StateProvider<String>((ref) => "house");
final landPageProvider = StateProvider<String>((ref) => "payland");
final businessPageProvider = StateProvider<String>((ref) => "renew");
final parkingPageProvider = StateProvider<String>((ref) => "daily");
