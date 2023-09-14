class WinnerModel {
  final String name;
  final String? image;
  final String prize;
  final String? ticket_id;
  final String ticket_number;
  WinnerModel({
    required this.name,
    required this.image,
    required this.prize,
    required this.ticket_id,
    required this.ticket_number,
  });

  factory WinnerModel.fromMap(Map<String, dynamic> map) {
    return WinnerModel(
      name: map['name'],
      image: map['image'] ?? "",
      prize: map['prize'].toString(),
      ticket_id: map['ticket_id'] ?? "",
      ticket_number: map['ticket_number'].toString(),
    );
  }
}
