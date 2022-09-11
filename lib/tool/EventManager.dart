
import 'package:eventify/eventify.dart';
import 'package:flutter/cupertino.dart';

class EventManager{
  static EventEmitter emitter = new EventEmitter();

  static String EVENT_LOGOUT = 'LOGOUT';
  static String EVENT_CART_CLEAR = 'EVENT_CART_CLEAR';
  static String EVENT_ORDERS_REFRESH = 'EVENT_ORDERS_REFRESH';

}