class Weather {
  final String sehirAdi;
  final double sicaklik;
  final String havaDurumu;

  Weather(
      {required this.sehirAdi,
      required this.sicaklik,
      required this.havaDurumu});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        sehirAdi: json["name"],
        sicaklik: json["main"]["temp"].toDouble(),
        havaDurumu: json["weather"][0]["main"]);
  }
}
