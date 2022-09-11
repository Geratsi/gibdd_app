import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:car_online/activity/profile/MyCarsActivity.dart';
import 'package:car_online/activity/profile/OperationsHistoryActivity.dart';
import 'package:car_online/activity/profile/PersonalInfoActivity.dart';
import 'package:car_online/activity/profile/ProfileSettingsActivity.dart';
import 'package:car_online/activity/profile/documents/DocumentsPage.dart';
import 'package:car_online/activity/services/inspector/models/InspectorMaterialModel.dart';
import 'package:car_online/entity/Notif.dart';
import 'package:car_online/activity/profile/check_pdd/domain/model/PddTestItem.dart';
import 'package:car_online/entity/ProfileMenuItem.dart';
import 'package:car_online/entity/Traffic.dart';
import 'package:car_online/entity/Weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'entity/News.dart';


class Api{

  static Future<Weather?> getWeatherInfo() async {
    /*
    var response = await http.get(Uri.parse(
        'https://api.weather.yandex.ru/v2/informers?lang=ru_RU&lat=55.040235&lon=49.040235&limit=1&hours=false&extra=false'
    ), headers: {
      'X-Yandex-Api-Key': '8fbd0958-d486-40f0-91b7-fe8239aba874',
    });

    var res = json.decode(response.body);

     */
    var body = '{"now":1643187738,"now_dt":"2022-01-26T09:02:18.337153Z","info":{"url":"https://yandex.ru/pogoda/99779?lat=55.040235\u0026lon=49.040235","lat":55.040235,"lon":49.040235},"fact":{"obs_time":1643187600,"temp":-1,"feels_like":-16,"temp_water":0,"icon":"ovc","condition":"overcast","wind_speed":2.2,"wind_dir":"s","pressure_mm":756,"pressure_pa":1007,"humidity":87,"daytime":"d","polar":false,"season":"winter","wind_gust":4.6},"forecast":{"date":"2022-01-26","date_ts":1643144400,"week":4,"sunrise":"07:45","sunset":"16:06","moon_code":4,"moon_text":"moon-code-4","parts":[{"part_name":"evening","temp_min":-12,"temp_avg":-12,"temp_max":-11,"temp_water":0,"wind_speed":2.1,"wind_gust":3.8,"wind_dir":"sw","pressure_mm":755,"pressure_pa":1006,"humidity":88,"prec_mm":0.6,"prec_prob":40,"prec_period":360,"icon":"ovc_-sn","condition":"light-snow","feels_like":-17,"daytime":"n","polar":false},{"part_name":"night","temp_min":-13,"temp_avg":-13,"temp_max":-12,"temp_water":0,"wind_speed":2.4,"wind_gust":4.2,"wind_dir":"sw","pressure_mm":756,"pressure_pa":1007,"humidity":87,"prec_mm":0.6,"prec_prob":30,"prec_period":360,"icon":"ovc_-sn","condition":"light-snow","feels_like":-18,"daytime":"n","polar":false}]}}';

    var res = json.decode(body);
    return Weather(res);
  }

  static List<ProfileMenuItem> getProfileMenuButtons() {
    return [
      ProfileMenuItem('Мои\nавтомобили',
          Image.asset("assets/img/ic_car.png", width: 50, height: 50,), MyCarsActivity()),
      ProfileMenuItem('Мои\nдокументы',
          Image.asset("assets/img/Driver License.png", width: 50, height: 50,), MyDocumentsActivity()),
      ProfileMenuItem('Личные\nданные',
          Image.asset("assets/img/person_info.png", width: 50, height: 50,), PersonalInfoActivity()),
      ProfileMenuItem('История\nопераций',
          Padding(
            padding: EdgeInsets.only(top: 4, bottom: 4),
              child: Opacity(
                child: Image.asset("assets/img/operations_history.png", width: 42, height: 42,),
                opacity: 0.5,
              ),
            ), OperationsHistoryActivity()),
      ProfileMenuItem('Мои\nнастройки',
          Image.asset("assets/img/settings_icon.png", width: 50, height: 50,), ProfileSettingsActivity()),
    ];
  }

  static Future<List<News>> getNewsList() async {
    List<News> news = [];
    news.add(News(
      1, "Ухудшение погодных условий", "assets/img/n1.png","assets/img/n1.png",
      "Госавтоинспекция МВД по Республике Татарстан\nпредупреждает об ухудшении погодных условий\n3 февраля на территории Республики Татарстан ожидается сильный снег, метель с ухудшением видимости, сильный ветер порывами до 17 м/с, на дорогах возможно образование гололедицы и снежных заносов.\nВодители транспортных средств в сложных метеорологических условиях должны руководствоваться не максимально разрешенной скоростью движения, а выбирать такую скорость, которая обеспечивала бы безопасность в складывающейся обстановке. Следует воздерживаться от опасных маневров, в особенности, связанных с выездом на сторону дороги, предназначенную для встречного движения. Необходимо пристегиваться ремнями безопасности и перевозить пассажиров, пристегнутых ремнями безопасности. Перевозить детей в легковом автомобиле на переднем сиденье до 12 лет, на заднем сиденье до 7 лет с использованием только детских удерживающих устройств.\nПешеходы обязаны переходить проезжую часть только по пешеходному переходу и на разрешающий сигнал светофора, убедившись в безопасности дальнейшего движения. В темное время суток или в условиях недостаточной видимости пешеходам необходимо иметь при себе предметы со световозвращающими элементами и обеспечивать видимость этих предметов водителями транспортных средств.\nГосавтоинспекция МВД по Республике Татарстан напоминает о необходимости неукоснительного соблюдения правил дорожного движения и призывает участников дорожного движения быть крайне внимательными и осторожными.",
    ));
    news.add(News(
      2, "Cотрудники ДПС изъяли патроны", "assets/img/n2.png","assets/img/n2.png",
      "В Нижнекамском районе сотрудники ГИБДД остановили автомобиль «Лада», где обнаружили патроны.\nЗа рулем находился 26-летний местный житель. При проверке документов водитель вел себя подозрительно, и автоинспекторы решили провести досмотр. В кармашке левой передней двери сотрудники ДПС обнаружили и изъяли патроны в количестве 9 штук.\nИзъятые предметы были направлены на исследование, которое показало, что патроны относятся к категории боеприпасов и предназначены для стрельбы из охотничьего ружья.\nВ настоящее время по данному факту проводится проверка.\nВ отношении фигуранта составлен административный материал по ч.1 ст.20.12 КоАП РФ «Пересылка оружия, нарушение правил перевозки, транспортирования или использования оружия и патронов к нему»."
    ));
    news.add(News(
      3, "Акция «Письмо водителю»", "assets/img/n3.png","assets/img/n3.png",
      "Дошколята вручали автолюбителям послания с просьбами о соблюдении ПДД.\nДля привлечения внимания участников дорожного движения к проблеме детского травматизма в Тюлячиснком районе Татарстана была проведена профилактическая акция «Письмо водителю». В рамках мероприятия воспитанники детского сада заранее подготовили послания автомобилистам, в которых поделились историями из своей жизни.\nПрочитать эти письма водители смогли благодаря сотрудникам Госавтоинспекции и юным инспекторам движения, которые раздавали заветные конверты и призывали быть внимательными и осторожными на дороге, особенно в сложных погодных условиях, и не нарушать правила дорожного движения.\nВодители позитивно реагировали на призыв детей к соблюдению правил дорожного движения.\nВ Госавтоинспекции выразили надежду на то, что такой неординарный подход к информированию водителей о возможных последствиях ДТП заставит их ещё раз задуматься о высоком уровне ответственности, которая лежит на их плечах."
    ));
    news.add(News(
      4, "Мастер класс для будущих мам", "assets/img/n4.png","assets/img/n4.png",
      "В Татарстане сотрудники Госавтоинспекции провели мастер класс для будущих мам.\nС целью профилактики аварийности с участием детей сотрудники Госавтоинспекции и работники ГБУ \"Безопасность дорожного движения\" в перинатальных центрах, родильных домах и женских консультациях города Казани проводят обучающие тренинги с родителями по обеспечению безопасной перевозки детей.\nВ женской консультации № 13 при ГАУЗ «Городская поликлиника № 18» стражи порядка напомнили, что, начиная с первого дня жизни ребенка, его перевозка в автомобиле должна осуществляться только в детском удерживающем устройстве. Автоинспекторы объясняли, как правильно подобрать детское автокресло с учетом веса, роста и возраста ребенка, а также напомнили, к каким последствиям может привести игнорирование средств безопасности.\nБудущие мамы с интересом слушали сотрудников Госавтоинспекции и задавали интересующие их вопросы. В завершении мероприятия всем участниками были вручены тематические памятки по использованию детских автокресел, а также световозвращающие элементы."
    ));
    return news;
  }
  static Future<News?> getNews(int id) async {
    List<News> news = await getNewsList();
    for(var news1 in news){
      if (news1.id==id)
        return news1;
    }
    return null;
  }
  static Future<News> addNewsLike(News news) async {
    news.likes++;
    return news;
  }

  static Future<List<Traffic>> getTraffics() async {
    List<Traffic> traffics = [];
    traffics.add(Traffic(id: 1, name:'ул.Ершова - ул.Гвардейская',
      points: 3, isSelected: true,
      point: Point(latitude: 55.7938487, longitude: 49.1715019),));
    traffics.add(Traffic(id: 2, name:'Перекресток ТЦ "Кольцо"',
      points: 6, isSelected: true,
      point: Point(latitude: 55.78787, longitude: 49.12331),));
    traffics.add(Traffic(id: 3, name:'Сибирский тракт',
      points: 9, isSelected: true,
      point: Point(latitude: 55.82181, longitude: 49.18462),));
    traffics.add(Traffic(id: 4, name:'Солнечный город',
      points: 10, isSelected: true,
      point: Point(latitude: 55.73438, longitude: 49.1796),));
    return traffics;
  }
  static Future<Traffic?> getTraffic(int id) async {
    List<Traffic> traffics = await getTraffics();
    for(var traffic in traffics){
      if (traffic.id==id)
        return traffic;
    }
    return null;
  }


  static Future<List<Notif>> getNotifs() async {
    List<Notif> notifs = [];
    notifs.add(Notif(1, "Мои автомобили", "12.01.2022 в 10:30", "Ваш полис ОСАГО истекает 15 февраля 2022 года"));
    notifs.add(Notif(1, "Оформление ДТП", "12.01.2022 в 12:30", "Ваша заявка принята к рассмотрению.\nВашей заявке присвоен номер 47944.\nНаправляйтесь в Центр оформления ДТП по адресу Сибирский Tракт, 48"));
    notifs.add(Notif(2, "Народный инспектор", "12.01.2022 в 10:30", "Ваша заявка успешно рассмотрена.\nВам начислено 12 баллов.\nСпасибо за проявленную активную гражданскую позицию.\nВместе мы делаем мир лучше!"));
    notifs.add(Notif(3, "Штрафы", "11.01.2022 в 18:30", "Начислен новый штраф.\nОплатите штраф ГИБДД со скидкой 50%. Основное условие - нужно совершить платеж не позднее 20 дней с даты вынесения постановления."));
    return notifs;
  }

  static Future<List<PddTestItem>> getPddTestItems() async {
    return [
      PddTestItem('По какой траектории Вам разрешено выполнить разворот?', 'assets/img/pdd-test-1.jpg',
        <PddTestOption>[
          PddTestOption('Только по А', true),
          PddTestOption('Только по Б'),
          PddTestOption('По любой из указанных'),
        ],
      ),

      PddTestItem(
        'В каком случае водителю разрешается поставить автомобиль на стоянку в указанном месте?',
        'assets/img/pdd-test-2.jpg',
        <PddTestOption>[
          PddTestOption('Только если расстояние до сплошной линии разметки не менее 3 м'),
          PddTestOption('Только если расстояние до края пересекаемой проезжей части не менее 5 м'),
          PddTestOption('При соблюдении обоих перечисленных условий', true),
        ],
      ),

      PddTestItem('По какой траектории Вам разрешено выполнить разворот?', 'assets/img/pdd-test-3.jpg', <PddTestOption>[
        PddTestOption('Только по А'),
        PddTestOption('Только по Б', true),
        PddTestOption('По любой из указанных'),
      ]),

      PddTestItem('Разрешён ли Вам такой маневр при выключенных реверсивных светофорах?', 'assets/img/pdd-test-4.jpg', <PddTestOption>[
        PddTestOption('Разрешен'),
        PddTestOption('Разрешен, если нет встречных транспортных средств'),
        PddTestOption('Разрешен только для обгона'),
        PddTestOption('Запрещен', true),
      ]),

      PddTestItem('При таких сигналах светофора и жесте регулировщика Вы должны:', 'assets/img/pdd-test-5.jpg', <PddTestOption>[
        PddTestOption('Остановиться у стоп-линии', true),
        PddTestOption('Продолжить движение только прямо'),
        PddTestOption('Продолжить движение прямо или направо'),
      ]),

      PddTestItem('Вам разрешено продолжить движение:', 'assets/img/pdd-test-6.jpg', <PddTestOption>[
        PddTestOption('Только по траектории А'),
        PddTestOption('Только по траектории Б', true),
        PddTestOption('Только по траектории А или Б'),
        PddTestOption('Только по траектории Б или В'),
        PddTestOption('По любой траектории из указанных'),
      ]),

      PddTestItem('Разрешено ли Вам ставить автомобиль на стоянку в этом месте по четным числам месяца?', 'assets/img/pdd-test-7.jpg', <PddTestOption>[
        PddTestOption('Разрешено', true),
        PddTestOption('Разрешено только после 19 часов'),
        PddTestOption('Запрещено'),
      ]),

      PddTestItem('Этот знак предупреждает о приближении к перекрестку, на котором Вы:', 'assets/img/pdd-test-8.jpg', <PddTestOption>[
        PddTestOption('Имеете право преимущественного проезда'),
        PddTestOption('Должны уступить дорогу всем транспортным средствам, движущимся по пересекаемой дороге'),
        PddTestOption('Должны уступить дорогу только транспортным средствам, приближающимся справа', true),
      ]),

      PddTestItem('Вы намерены продолжить движение прямо при желтом мигаюшем сигнале светофора. Ваши действия?', 'assets/img/pdd-test-9.jpg', <PddTestOption>[
        PddTestOption('Остановитесь и продолжите движение только после включения зеленого сигнала светофора'),
        PddTestOption('Уступите дорогу гужевой повозке', true),
        PddTestOption('Проедете перекресток первым вместе со встречным автомобилем'),
      ]),

      PddTestItem('Вам можно выполнить разворот:', 'assets/img/pdd-test-10.jpg', <PddTestOption>[
        PddTestOption('Только по траектории А'),
        PddTestOption('Только по траектории Б', true),
        PddTestOption('По любой тректории из указанных'),
      ]),
    ];
  }

  static Future<void> sendFilesToServer(List<InspectorMaterialModel> data) async {
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    data.forEach((model) async {
      try {
        await dio.post(
          'https://gibdd.itback.ru/api/event/',
          data: FormData.fromMap({
            'comment': '${model.comments}',
            'lat': '${model.lat}',
            'lon': '${model.long}',
            'files[]': [
              await MultipartFile.fromFile(model.sourceURL, filename: model.sourceURL.split('/').last),
            ]
          })
        );

      }on DioError catch (e) {
        print(e);
      }
    });


    /*
    const Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'token': 'token',
    };


    final http.MultipartRequest request = http.MultipartRequest("POST", Uri.parse(""),);

    request.headers['token'] = 'token';
    request.headers["Content-Type"]='multipart/form-data';

    request.fields["name"] = "hardik";
    request.fields["email"] = "h@gmail.com";
    request.fields["mobile"] = "00000000";
    request.fields["address"] = "afa";
    request.fields["city"] = "fsf";

    data.forEach((model) async {
      if (!model.isAsset) {
        final String filename = model.sourceURL.split('/').last;
        final List<int> fileAsBytes = await File(model.sourceURL).readAsBytesSync();

        print('i am here with your location');
        print(model.lat);
        print(model.long);
        print(model.comments);

        request.files.add(
          http.MultipartFile.fromBytes(
            filename,
            fileAsBytes,
            filename: filename.split('.').first,
            contentType: MediaType(
              model.isImage ? 'image' : 'video',
              filename.split('.').last,
            ),
          ),
        );
      }
    });


    request.fields["reminder_interval"] = "1";

     */

    // request.send().then((onValue) {
    //   log('${onValue.statusCode}');
    //   log('${onValue.headers}');
    //   log('${onValue.contentLength}');
    // });
  }
}

