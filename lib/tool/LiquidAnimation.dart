import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:sensors/sensors.dart';

class LiquidAnimation extends StatefulWidget {
  LiquidAnimationState createState() => LiquidAnimationState();
}

const _numberOfWavePoints = 6;//11

class LiquidAnimationMap {
  List<double> heightMap;
  List<double> velocityMap;

  LiquidAnimationMap(this.heightMap, this.velocityMap);

  updateMaps(double timeInterval) {
    const _speed = 8;//15.0
    const _acceleration = 15;//15.0
    const _dampening = 0.9;//0.9

    double edge = 0;
    int a = _numberOfWavePoints - 3;
    const double _edgeMultiplier = 0.07;

    for (int i = 1; i < _numberOfWavePoints - 1; i++) {
      edge = (((2 * i - (2 + a)).toDouble()) / a.toDouble()).abs();

      velocityMap[i] += _acceleration *
          timeInterval *
          (((heightMap[i - 1] + heightMap[i + 1]) / 2.0) - heightMap[i]);
      velocityMap[i] *= pow(_dampening * (1 + _edgeMultiplier * edge),
          timeInterval * _acceleration);
    }

    double maxHeight = 0.0;

    for (int i = 1; i < _numberOfWavePoints - 1; i++) {
      heightMap[i] += _speed * timeInterval * velocityMap[i];
      maxHeight = max(maxHeight, heightMap[i].abs());
    }

    if (maxHeight > 1.0) {
      for (int i = 0; i < _numberOfWavePoints; i++) {
        heightMap[i] = heightMap[i] / maxHeight;
      }
    }
  }

  void disturb(double velocity, double point) {
    int index = (point * (_numberOfWavePoints - 3)).toInt() + 1;
    velocityMap[index] += velocity;
  }

  double maxVelocity() {
    return velocityMap.map((element) => element.abs()).reduce(max);
  }
}

class LiquidAnimationState extends State<LiquidAnimation> {
  LiquidAnimationMap _animationMap = LiquidAnimationMap(List.filled(_numberOfWavePoints, 0),List.filled(_numberOfWavePoints, 0),);

  DateTime _lastTimestamp = DateTime.now();
  Timer? _timer;
  StreamSubscription? listener;

  double _acceleration = 0;
  final _velocityFactor = 10.0;//10.0

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 16), ((Timer timer) {
      var now = DateTime.now();
      var interval =
          (now.millisecondsSinceEpoch - _lastTimestamp.millisecondsSinceEpoch)
              .toDouble() /
              1000;

      var velocity = (_acceleration * interval * _velocityFactor).abs();
      var disturbancePoint = _acceleration > 0 ? 0 : 1;

      setState(() {
        _animationMap.disturb(velocity, disturbancePoint.toDouble());
        _animationMap.updateMaps(interval);
        _lastTimestamp = now;
      });
    }));
    listener = accelerometerEvents.listen((AccelerometerEvent event) {
      const GRAVITY = 9.8;
      _acceleration = -event.x / GRAVITY;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity().scaled(2.0, 1, 1),
      child: CustomPaint(
        painter: LiquidPainter(_animationMap),
        child: Center(
          child: Text(""),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_timer!=null) _timer!.cancel();
    if (listener!=null) listener!.cancel();
    super.dispose();
  }
}

class LiquidPainter extends CustomPainter {
  LiquidAnimationMap map;
  final _waveHeight = 40.0;//50.0
  LiquidPainter(this.map);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    var surfacePath = _path(size);

    paint.color = Colors.lightBlue.shade700;
    var bodyPath = surfacePath;
    bodyPath.lineTo(size.width, size.height);
    bodyPath.lineTo(0, size.height);
    bodyPath.close();

    canvas.drawPath(bodyPath, paint);

    /*
    paint.color = Colors.blue[50];
    paint.strokeWidth = 2.0;
    paint.style = PaintingStyle.stroke;

    canvas.drawPath(surfacePath, paint);
     */
  }

  Path _path(Size size) {
    double pointDistance = size.width / (_numberOfWavePoints - 3);

    Path path = Path();
    Point _cp = Point(-pointDistance, _yValue(map.heightMap[0]));

    path.moveTo(_cp.x.toDouble(), _cp.y.toDouble());

    double edge = 0;
    int a = _numberOfWavePoints - 3;
    const double edgeMultiplier = 0.5;

    for (int x = 1; x < _numberOfWavePoints; x++) {
      edge = (((2 * x - (2 + a)).toDouble()) / a.toDouble()).abs();

      double y = _yValue(map.heightMap[x] * (1 + edgeMultiplier * edge));

      Point next = Point(_cp.x + pointDistance, y);
      Point cp1 = Point(_cp.x + pointDistance * 0.5, _cp.y);
      Point cp2 = Point(_cp.x + pointDistance * 0.5, y);

      path.cubicTo(cp1.x.toDouble(), cp1.y.toDouble(), cp2.x.toDouble(), cp2.y.toDouble(), next.x.toDouble(), next.y.toDouble());
      _cp = next;
    }

    return path;
  }

  double _yValue(double height) {
    return (1 - min(height, 1)) * _waveHeight;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}