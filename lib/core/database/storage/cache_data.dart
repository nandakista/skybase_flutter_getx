class CacheData<T> {
  final T value;
  final DateTime expiredDate;

  CacheData({required this.value, DateTime? expiredDate})
      : expiredDate = expiredDate ??
            DateTime.now().add(
              const Duration(minutes: 1),
            );

  factory CacheData.fromJson(Map<String, dynamic> json) => CacheData(
        value: json["value"],
        expiredDate: DateTime.parse(json["expiredDate"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "expiredDate": expiredDate.toIso8601String(),
      };
}
