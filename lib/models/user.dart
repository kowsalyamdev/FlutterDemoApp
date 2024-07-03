import 'dart:convert';

List<User> UserFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String UserToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final String id;
  final String lastName;
  final String firstName;
  final String email;
  final String picture;
  final double? latitude;
  final double? longitude;

  User({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.picture,
    required this.latitude,
    required this.longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      lastName: json['name']['last'],
      firstName: json['name']['first'],
      email: json['email'],
      picture: json['picture'],
      latitude: json['location']['latitude'] ?? 0.0,
      longitude: json['location']['longitude'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': {
        'last': lastName,
        'first': firstName,
      },
      'email': email,
      'picture': picture,
      'location': {
        'latitude': latitude,
        'longitude': longitude,
      },
    };
  }
}
