class Schedule {
  final int id;
  final String startTime;
  final String endTime;
  final String repeat;

  Schedule({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.repeat,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      repeat: json['repeat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'repeat': repeat,
    };
  }
}
