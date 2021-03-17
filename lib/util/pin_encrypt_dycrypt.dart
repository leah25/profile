// import 'package:flutter_string_encryption/flutter_string_encryption.dart';

// var key = "null";
// String encryptedS, decryptedS;
// var password = "null";
// PlatformStringCryptor cryptor;

// // method to Encrypt String Password
// encrypt(String pin) async {
//   cryptor = PlatformStringCryptor();
//   final salt = await cryptor.generateSalt();
//   password = pin;
//   key = await cryptor.generateKeyFromPassword(password, salt);
//   // here pass the password entered by user and the key
//   encryptedS = await cryptor.encrypt(password, key);
//   print("encryptedS $encryptedS");
//   return encryptedS;
// }

// // method to decrypt String Password
// decrypt(String pin) async {
//   try {
//     //here pass encrypted string and the key to decrypt it
//     decryptedS = await cryptor.decrypt(pin, key);
//     print("decryptedS $decryptedS");
//   } on MacMismatchException {}
// }
