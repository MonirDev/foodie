import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/app/data/datasource_reference/datasource_reference.dart';
import 'package:foodie/app/data/models/user_model.dart';
import 'package:foodie/app/utils/strings.dart';

class UserService {
  //upload user data
  Future<void> uploadUserData(
    String uId,
    String name,
    String email,
    String password,
  ) async {
    await DataSourceReference.userRef
        .doc(uId)
        .set(
          UserModel(
            uId: uId,
            name: name,
            email: email,
            password: password,
          ),
        )
        .then(
      (_) {
        //
      },
    ).onError((error, stackTrace) {
      throw error.toString();
    });
  }

  //get User data
  Future<UserModel> fetchUserData(String uId) async {
    try {
      QuerySnapshot<UserModel> querySnapshot = await DataSourceReference.userRef
          .where(Strings.uId, isEqualTo: uId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      } else {
        throw Strings.userDoesNotExist;
      }
    } catch (e) {
      rethrow;
    }
  }

  //login
  Future<UserModel> login(String email, String password) async {
    try {
      QuerySnapshot<UserModel> querySnapshot = await DataSourceReference.userRef
          .where(Strings.emailKey, isEqualTo: email)
          .where(Strings.passwordKey, isEqualTo: password)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      } else {
        throw Strings.userDoesNotExist;
      }
    } catch (e) {
      rethrow;
    }
  }
}
