class WinnerModel {
  final String name;
  final String? image;
  final String prize;

  WinnerModel({
    required this.name,
    required this.image,
    required this.prize,
  });

  factory WinnerModel.fromMap(Map<String, dynamic> map) {
    return WinnerModel(
      name: map['name'],
      image: map['image'] ?? "",
      prize: map['prize'].toString(),
    );
  }
}
