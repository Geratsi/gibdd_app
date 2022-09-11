
import 'package:car_online/entity/Notif.dart';

class News {
  int id;
  String name;
  String image;
  String imageDetail;

  String des;
  bool isOpen = false;

  int likes = 30;
  int commentsLength = 3;
  String commentsBlockId = "news";

  News(this.id, this.name, this.image, this.imageDetail, this.des);
}
