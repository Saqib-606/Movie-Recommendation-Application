class UserModel {
  String id, name, email;
  String? photoUrl;

  UserModel(this.id, this.name, this.email, this.photoUrl);

  Map <String, dynamic> toMap () => {
    "id" : id,
    "name" : name,
    "email" : email,
    "photoUrl" : photoUrl,
  };
}

