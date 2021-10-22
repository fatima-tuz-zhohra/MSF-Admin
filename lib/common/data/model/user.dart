

class User {
  String name;
  String email;
  String phoneNo;
  String? role;
  String image;
  bool? isBloodDonor;
  String? bloodGroup;
  String? address;

  User({
    required this.name,
    required this.email,

    required this.phoneNo,
    this.role,
    required this.image,
    this.isBloodDonor = false,
    this.bloodGroup,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'phoneNo': this.phoneNo,
      'role': this.role,
      'image': this.image,
      'isBloodDonor': this.isBloodDonor,
      'bloodGroup': this.bloodGroup,
      'address': this.address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNo: map['phoneNo'] as String,
      role: map['role'] as String?,
      image: map['image'] as String,
      isBloodDonor: map['isBloodDonor'] as bool?,
      bloodGroup: map['bloodGroup'] as String?,
      address: map['address'] as String?,
    );
  }
}
