import 'package:app_contable/data/database_helper.dart';
import 'package:app_contable/models/user.dart';

class UserRepository {
  Future<User?> addUser(User user) async {
    try {
      final db = await DatabaseHelper().database;
      int result = await db.insert('Users', user.toJson());
      return user.copyWith(id: result);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<User>> getUsers() async {
    final db = await DatabaseHelper().database;
    List<User> result = [];
    final users = await db.query('Users');
    for (var user in users) {
      result.add(User.fromJson(user));
    }
    return result;
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      final db = await DatabaseHelper().database;
      final result = await db.query('Users', where: 'email = ?', whereArgs: [email]);
      if(result.isNotEmpty){
        return User.fromJson(result.first);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
