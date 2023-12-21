import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdsc_movie_app/models/user/user_model.dart';

class UserRepository {
  FirebaseFirestore firestore;

  UserRepository({required this.firestore});

  Future<UserModel?> findUser(String uid) async {
    final doc =
        await firestore.collection('users').where('uid', isEqualTo: uid).get();

    if (doc.docs.isEmpty) {
      return null;
    } else {
      return UserModel.fronJson(doc.docs.first.data());
    }
  }

  Future<void> joinUser(UserModel user) async {
    await firestore.collection('users').add(user.toJson());
  }
}
