class AdjustedScheduleResult {
  final List<String> times; // e.g. ["8:15am","2:00pm"]
  final List<String> days; // e.g. ["Sunday","Tuesday"]
  final String frequency; // "Daily" or "Weekly"

  const AdjustedScheduleResult({
    required this.times,
    required this.days,
    required this.frequency,
  });
}
