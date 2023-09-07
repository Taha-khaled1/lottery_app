class LotteryModel {
  final String lotteryId;
  final DateTime timeEnd;
  final DateTime createAt;
  final String prize;
  final bool status;

  LotteryModel({
    required this.lotteryId,
    required this.timeEnd,
    required this.createAt,
    required this.prize,
    required this.status,
  });

  factory LotteryModel.fromJson(Map<String, dynamic> json) {
    return LotteryModel(
      lotteryId: json['lottery_id'],
      timeEnd: DateTime.parse(json['time_end']),
      createAt: DateTime.parse(json['create_at'].toString()),
      prize: json['prize'].toString(),
      status: json['status'],
    );
  }
}
