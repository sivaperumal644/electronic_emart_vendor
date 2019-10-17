class OrderStats {
  final String date;
  final double orderCount;
  final double totalAmount;

  OrderStats({
    this.date,
    this.orderCount,
    this.totalAmount,
  });

  factory OrderStats.fromJson(Map json) {
    return OrderStats(
      date: json['date'],
      orderCount: json['orderCount'].toDouble(),
      totalAmount: json['totalAmount'].toDouble(),
    );
  }
}
