class WeatherData {
  final Request request;
  final Location location;
  final Current current;

  WeatherData({
    required this.request,
    required this.location,
    required this.current,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      request: Request.fromJson(json['request']),
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request': request.toJson(),
      'location': location.toJson(),
      'current': current.toJson(),
    };
  }
}

class Request {
  final String type;
  final String query;
  final String language;
  final String unit;

  Request({
    required this.type,
    required this.query,
    required this.language,
    required this.unit,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      type: json['type'],
      query: json['query'],
      language: json['language'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'query': query,
      'language': language,
      'unit': unit,
    };
  }
}

class Location {
  final String name;
  final String country;
  final String region;
  final String lat;
  final String lon;
  final String timezoneId;
  final String localtime;
  final int localtimeEpoch;
  final String utcOffset;

  Location({
    required this.name,
    required this.country,
    required this.region,
    required this.lat,
    required this.lon,
    required this.timezoneId,
    required this.localtime,
    required this.localtimeEpoch,
    required this.utcOffset,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      country: json['country'],
      region: json['region'],
      lat: json['lat'],
      lon: json['lon'],
      timezoneId: json['timezone_id'],
      localtime: json['localtime'],
      localtimeEpoch: json['localtime_epoch'],
      utcOffset: json['utc_offset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'region': region,
      'lat': lat,
      'lon': lon,
      'timezone_id': timezoneId,
      'localtime': localtime,
      'localtime_epoch': localtimeEpoch,
      'utc_offset': utcOffset,
    };
  }
}

class Current {
  final String observationTime;
  final int temperature;
  final int weatherCode;
  final List<String> weatherIcons;
  final List<String> weatherDescriptions;
  final Astro astro;
  final AirQuality airQuality;
  final int windSpeed;
  final int windDegree;
  final String windDir;
  final int pressure;
  final double precip;
  final int humidity;
  final int cloudcover;
  final int feelslike;
  final int uvIndex;
  final int visibility;
  final String isDay;

  Current({
    required this.observationTime,
    required this.temperature,
    required this.weatherCode,
    required this.weatherIcons,
    required this.weatherDescriptions,
    required this.astro,
    required this.airQuality,
    required this.windSpeed,
    required this.windDegree,
    required this.windDir,
    required this.pressure,
    required this.precip,
    required this.humidity,
    required this.cloudcover,
    required this.feelslike,
    required this.uvIndex,
    required this.visibility,
    required this.isDay,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      observationTime: json['observation_time'],
      temperature: json['temperature'],
      weatherCode: json['weather_code'],
      weatherIcons: List<String>.from(json['weather_icons']),
      weatherDescriptions: List<String>.from(json['weather_descriptions']),
      astro: Astro.fromJson(json['astro']),
      airQuality: AirQuality.fromJson(json['air_quality']),
      windSpeed: json['wind_speed'],
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressure: json['pressure'],
      precip: json['precip'].toDouble(),
      humidity: json['humidity'],
      cloudcover: json['cloudcover'],
      feelslike: json['feelslike'],
      uvIndex: json['uv_index'],
      visibility: json['visibility'],
      isDay: json['is_day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'observation_time': observationTime,
      'temperature': temperature,
      'weather_code': weatherCode,
      'weather_icons': weatherIcons,
      'weather_descriptions': weatherDescriptions,
      'astro': astro.toJson(),
      'air_quality': airQuality.toJson(),
      'wind_speed': windSpeed,
      'wind_degree': windDegree,
      'wind_dir': windDir,
      'pressure': pressure,
      'precip': precip,
      'humidity': humidity,
      'cloudcover': cloudcover,
      'feelslike': feelslike,
      'uv_index': uvIndex,
      'visibility': visibility,
      'is_day': isDay,
    };
  }
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
  });

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moonPhase: json['moon_phase'],
      moonIllumination: json['moon_illumination'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sunrise': sunrise,
      'sunset': sunset,
      'moonrise': moonrise,
      'moonset': moonset,
      'moon_phase': moonPhase,
      'moon_illumination': moonIllumination,
    };
  }
}

class AirQuality {
  final String co;
  final String no2;
  final String o3;
  final String so2;
  final String pm25;
  final String pm10;
  final String usEpaIndex;
  final String gbDefraIndex;

  AirQuality({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm25,
    required this.pm10,
    required this.usEpaIndex,
    required this.gbDefraIndex,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      co: json['co'],
      no2: json['no2'],
      o3: json['o3'],
      so2: json['so2'],
      pm25: json['pm2_5'],
      pm10: json['pm10'],
      usEpaIndex: json['us-epa-index'],
      gbDefraIndex: json['gb-defra-index'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'co': co,
      'no2': no2,
      'o3': o3,
      'so2': so2,
      'pm2_5': pm25,
      'pm10': pm10,
      'us-epa-index': usEpaIndex,
      'gb-defra-index': gbDefraIndex,
    };
  }
}
