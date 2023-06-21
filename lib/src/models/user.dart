class User {
  String? email;
  String? password;
  String? name;
  int? age;
  List<String>? interests;
  // d'autres propriétés peuvent être ajoutées ici en fonction des besoins
  User({this.email, this.password, this.name, this.age, this.interests});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      age: json['age'],
      interests: json['interests'] != null? List<String>.from(json['interests']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'age': age,
        'interests': interests,
      };
}