class UserModel {
  final String code;
  final String image;
  final String name;
  final String phone;
  final String userId;
  final double wallet;
  final String? type;
  UserModel({
    required this.type,
    required this.code,
    required this.image,
    required this.name,
    required this.phone,
    required this.userId,
    required this.wallet,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      code: map['code'] ?? "",
      type: map['type'] ?? "",
      image: map['image'] ?? "",
      name: map['name'] ?? "",
      phone: map['phone'] ?? "",
      userId: map['userId'] ?? "",
      wallet: double.parse(map['wallet'].toString()),
    );
  }
}
