class WeatherModel {
  String cityName;
  String description;
  WeatherMain main;
  WeatherWind wind;

  WeatherModel({
    required this.wind,
    required this.main,
    required this.cityName,
    required this.description,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      description: json['weather'][0]['description'],
      main: WeatherMain.fromJson(json['main']),
      wind: WeatherWind.fromJson(json['wind']),
    );
  }
}

class WeatherMain {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;

  double pressure;
  double humidity;

  WeatherMain({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory WeatherMain.fromJson(Map<String, dynamic> json) {
    return WeatherMain(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}

class WeatherWind {
  double speed;
  double deg;
  double gust;

  WeatherWind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory WeatherWind.fromJson(Map<String, dynamic> json) {
    return WeatherWind(
      speed: json['speed'],
      deg: json['deg'],
      gust: json['gust'],
    );
  }
}
