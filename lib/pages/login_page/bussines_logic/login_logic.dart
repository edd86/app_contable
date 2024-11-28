import 'package:app_contable/repository/user_repository.dart';
import 'package:app_contable/variables/global_variables.dart';

class LoginLogic {
  Future<bool> verifyUser(String email, String password) async {
    final user = await UserRepository().getUserByEmail(email);
    if (user != null) {
      GlobalVariables.userLogged = user;
      return user.password == password ? true : false;
    }
    return false;
  }
}
