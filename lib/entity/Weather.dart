
import 'dart:collection';

import 'package:flutter_weather_bg/utils/weather_type.dart';

class Weather {
  var data;
  int temp = 0;
  double wind = 0;
  String iconUrl = '';
  WeatherType weatherType = WeatherType.sunny;
  String conditionStr = '';
  bool isDay = true;
  LinkedHashMap<String, String> info = new LinkedHashMap();

  Weather(this.data){
    temp = data['fact']['temp'];
    wind = double.parse('${data['fact']['wind_speed']}');
    iconUrl = 'https://yastatic.net/weather/i/icons/funky/light/${data['fact']['icon']}.svg';

    var day = data['forecast']['parts'][0];

    DateTime now = DateTime.now();
    isDay = now.hour>6 && now.hour<21;
    
    info["Вероятность осадков"] = '${day['prec_prob']} %';
    info["Ветер"] = '${day['wind_speed']} м/с';
    info["Давление"] = '${day['pressure_mm']} мм рт. ст';
    info["Влажность воздуха"] = '${day['humidity']} %';
    info["Температура воды"] = '${day['temp_water']} °';

    switch(day['condition']){
      case 'clear':
        conditionStr = 'ясно';
        weatherType = isDay ? WeatherType.sunny : WeatherType.sunnyNight;
        break;
      case 'partly-cloudy':
        conditionStr = 'малооблачно';
        weatherType = isDay ? WeatherType.cloudy : WeatherType.cloudyNight;
        break;
      case 'cloudy':
        conditionStr = 'облачно с прояснениями';
        weatherType = isDay ? WeatherType.cloudy : WeatherType.cloudyNight;
        break;
      case 'overcast':
        conditionStr = 'пасмурно';
        weatherType = WeatherType.overcast;
        break;
      case 'drizzle':
        conditionStr = 'морось';
        weatherType = WeatherType.overcast;
        break;
      case 'light-rain':
        conditionStr = 'небольшой дождь';
        weatherType = WeatherType.lightRainy;
        break;
      case 'rain':
        conditionStr = 'дождь';
        weatherType = WeatherType.middleRainy;
        break;
      case 'moderate-rain':
        conditionStr = 'умеренно сильный дождь';
        weatherType = WeatherType.middleRainy;
        break;
      case 'heavy-rain':
        conditionStr = 'сильный дождь';
        weatherType = WeatherType.middleRainy;
        break;
      case 'continuous-heavy-rain':
        conditionStr = 'длительный сильный дождь';
        weatherType = WeatherType.heavyRainy;
        break;
      case 'showers':
        conditionStr = 'ливень';
        weatherType = WeatherType.heavyRainy;
        break;
      case 'wet-snow':
        conditionStr = 'дождь со снегом';
        weatherType = WeatherType.lightSnow;
        break;
      case 'light-snow':
        conditionStr = 'небольшой снег';
        weatherType = WeatherType.lightSnow;
        break;
      case 'snow':
        conditionStr = 'снег';
        weatherType = WeatherType.middleSnow;
        break;
      case 'snow-showers':
        conditionStr = 'снегопад';
        weatherType = WeatherType.heavySnow;
        break;
      case 'hail':
        conditionStr = 'град';
        weatherType = WeatherType.middleRainy;
        break;
      case 'thunderstorm':
        conditionStr = 'гроза';
        weatherType = WeatherType.thunder;
        break;
      case 'thunderstorm-with-rain':
        conditionStr = 'дождь с грозой';
        weatherType = WeatherType.thunder;
        break;
      case 'thunderstorm-with-hail':
        conditionStr = 'гроза с градом';
        weatherType = WeatherType.thunder;
        break;
    }
  }

  @override
  String toString() {
    return 'WeatherWidget{temp: $temp, iconUrl: $iconUrl}';
  }
}
