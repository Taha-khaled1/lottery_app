class Withdrawal {
  final String userId;
  final String id; // Document ID
  final String status; // pending, completed, failed
  final String createdAt;
  final double money;
  final String paypalEmail;

  Withdrawal({
    required this.userId,
    required this.id,
    required this.status,
    required this.createdAt,
    required this.money,
    required this.paypalEmail,
  });

  factory Withdrawal.fromMap(Map<String, dynamic> map, String docId) {
    return Withdrawal(
      userId: map['user_id'] as String,
      id: docId,
      status: map['status'] as String,
      createdAt: map['create_at'] as String,
      money: (map['money'] as num).toDouble(),
      paypalEmail: map['paypal_email'] as String,
    );
  }
}
