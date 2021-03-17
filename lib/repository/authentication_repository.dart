import 'package:e_revenue_flutter/networking/api_base_provider.dart';
import 'package:e_revenue_flutter/res/values.dart';

class AuthenticationRepository {
  ApiBaseProvider _apiProvider;

  AuthenticationRepository() {
    _apiProvider = ApiBaseProvider();
  }

  Future register(body) {
    return _apiProvider.post(SELFREG_POST, body);
  }

  Future signIn(body) {
    return _apiProvider.post(LOGIN_POST, body);
  }

  Future changePIN(body) {
    return _apiProvider.post(PINCHANGE_POST, body);
  }
}
