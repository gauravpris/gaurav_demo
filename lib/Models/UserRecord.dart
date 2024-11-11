class Userrecord {
  String name;
  String phone;
  String city;
  String image;
  String rupee;

  Userrecord({
    required this.name,
    required this.phone,
    required this.city,
    required this.image,
    required this.rupee,
  });

  factory Userrecord.fromJson(Map<String, dynamic> json) {
    return Userrecord(
      name: json['name'],
      phone: json['phone'].toString(), // Convert phone to string
      city: json['city'],
      image: json['image'],
      rupee: json['rupee'],
    );
  }
}
