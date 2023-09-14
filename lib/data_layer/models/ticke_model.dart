class UserTicketModel {
  final String createAt;
  final String endAt;
  final String lotteryId;
  final bool status;
  final String ticketId;
  final int ticketNumber;
  final String type;
  final String userId;

  UserTicketModel({
    required this.createAt,
    required this.endAt,
    required this.lotteryId,
    required this.status,
    required this.ticketId,
    required this.type,
    required this.userId,
    required this.ticketNumber,
  });

  factory UserTicketModel.fromMap(Map<String, dynamic> map) {
    return UserTicketModel(
      ticketNumber: map['ticket_number'] ?? "",
      createAt: map['create_at'] ?? "",
      endAt: map['end_at'] ?? "",
      lotteryId: map['lottery_id'] ?? "",
      status: map['status'] ?? false,
      ticketId: map['ticket_id'] ?? "",
      type: map['type'] ?? "",
      userId: map['user_id'] ?? "",
    );
  }
}
