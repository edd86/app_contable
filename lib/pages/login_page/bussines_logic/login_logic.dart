import 'package:app_contable/repository/user_repository.dart';

class LoginLogic {
  Future<bool> verifyUser(String email, String password) async {
    final user = await UserRepository().getUserByEmail(email);
    if (user != null) {
      return user.password == password ? true : false;
    }
    return false;
  }
}
