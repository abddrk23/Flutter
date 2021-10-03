class UserModel {
  String? uid;
  String? name;
  String? email;
  bool? isAdmin;

  UserModel();

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    name = map['name'];
    email = map['email'];
    isAdmin = map['isAdmin'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
    };
  }
}
