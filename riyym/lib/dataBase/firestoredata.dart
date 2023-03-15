import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riyym/dataBase/authentication.dart';
import '../model/user.dart';

class FireStore {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUser({required Users user}) async {
    String uids = Authentication().userUID;
    _firebaseFirestore.collection('users').doc(uids).set(
      {
        'name': user.name,
        'surName': user.surName,
        'email': user.email,
        'moviesFav': user.moviesFav,
        'musicsFav': user.musicsFav,
        'booksFav': user.booksFav,
      },
    );
  }

  Future<Users>  getUserInfo() async {
    String uids = Authentication().userUID;
    Users user = Users();
    await _firebaseFirestore.collection('users').doc(uids).get().then((value) {
      user = Users(
        name: value['name'],
        surName: value['surName'],
        email: value['email'],
        moviesFav: value['moviesFav'],
        booksFav: value['booksFav'],
        musicsFav: value['musicsFav'],
      );
    }
    );
    return user;
  }
}
