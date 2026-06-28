class UserModel {
  String id, name, email;

  UserModel(this.id, this.name, this.email);

  Map <String, dynamic> toMap () => {
    "id" : id,
    "name" : name,
    "email" : email,
  };
}

