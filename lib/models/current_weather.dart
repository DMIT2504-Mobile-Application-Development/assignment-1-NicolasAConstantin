class CurrentWeather {
  late String _city;
  late String _description;
  late double _currentTemp;
  late DateTime _currentTime;
  late DateTime _sunrise;
  late DateTime _sunset;

  String get city => _city;
  String get description => _description;
  double get currentTemp => _currentTemp;
  DateTime get currentTime => _currentTime;
  DateTime get sunrise => _sunrise;
  DateTime get sunset => _sunset;

  CurrentWeather({
    required String city,
    required String description,
    required double currentTemp,
    required DateTime currentTime,
    required DateTime sunrise,
    required DateTime sunset,
  }) {
    _city = city;
    _description = description;
    _currentTemp = currentTemp;
    _currentTime = currentTime;
    _sunrise = sunrise;
    _sunset = sunset;
  }

  factory CurrentWeather.fromOpenWeatherData(dynamic data) {
    return CurrentWeather(
      city: data['name'],
      description: data['weather'][0]['description'],
      currentTemp: data['main']['temp'],
      currentTime: DateTime.fromMillisecondsSinceEpoch((data['dt'] * 1000).toInt()),
      sunrise: DateTime.fromMillisecondsSinceEpoch((data['sys']['sunrise'] * 1000).toInt()),
      sunset: DateTime.fromMillisecondsSinceEpoch((data['sys']['sunset'] * 1000).toInt()),
    );
  }


  set city(String value) {
    if (value.trim().isEmpty) {
      throw Exception('City cannot be empty');
    }
    _city = value;
  }

  set currentTemp(double value) {
    if (value < -100 || value > 100) {
      throw Exception('Temperature must be between -100 and 100');
    }
    _currentTemp = value;
  }

  set currentTime(DateTime value) {
    if (value.isAfter(DateTime.now())) {
      throw Exception('Current time cannot be in the future');
    }
    _currentTime = value;
  }

  set sunrise(DateTime value) {
    if (value.day != _currentTime.day ||
        value.month != _currentTime.month ||
        value.year != _currentTime.year) {
      throw Exception('Sunrise must be on the same day as current time');
    }
    if (value.isAfter(_sunset)) {
      throw Exception('Sunrise cannot be after sunset');
    }

    _sunrise = value;
  }

  set sunset(DateTime value) {
    if (value.day != _currentTime.day ||
        value.month != _currentTime.month ||
        value.year != _currentTime.year) {
      throw Exception('Sunset must be on the same day as current time');
    }

    if (value.isBefore(_sunrise)) {
      throw Exception('Sunset cannot be before sunrise');
    }
    _sunset = value;
  }

  set description(String value) {
    if (value.trim().isEmpty) {
      throw Exception('Description cannot be empty');
    }
    _description = value;
  }

  @override
  String toString() {
    return 'City: $_city, Description: $_description, Current Temperature: $_currentTemp, Current Time: $_currentTime, Sunrise: $_sunrise, Sunset: $_sunset';
  }
}


