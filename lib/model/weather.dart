class Weather {
  String locationName;
  String wx;
  int pop;
  double minT;
  double maxT;
  String ci;
  int? meanT;

  Weather({
    required this.locationName,
    required this.wx,
    required this.pop,
    required this.minT,
    required this.maxT,
    required this.ci,
    this.meanT,
  });
}
