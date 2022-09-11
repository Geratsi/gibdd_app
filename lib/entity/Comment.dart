
import 'package:car_online/entity/Notif.dart';

class Comment {
  int id;
  String userName;
  String date;
  String text;
  int likes;
  List<Comment> comments;

  Comment(this.id, this.userName, this.date, this.text, this.likes, this.comments);
}
