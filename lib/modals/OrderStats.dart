class OrderStats {
  final String date;
  final double itemCount;
  final double totalAmount;

  OrderStats({
    this.date,
    this.itemCount,
    this.totalAmount,
  });

  factory OrderStats.fromJson(Map json) {
    return OrderStats(
      date: json['date'],
      itemCount: json['itemCount'].toDouble(),
      totalAmount: json['totalAmount'].toDouble(),
    );
  }
}
