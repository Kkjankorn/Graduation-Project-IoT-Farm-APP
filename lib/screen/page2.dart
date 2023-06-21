import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Page2 extends StatefulWidget {
  final bool pump_mush, auto_mush;
  Page2({
    Key? key,
    required this.pump_mush,
    required this.auto_mush,
  }) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final databaseRef = FirebaseDatabase.instance.ref();
  String statuspump = '';
  var humidity = '', temperature = '', vol = '';
  var time = DateTime.now();

  bool toggleValue = false,
      tatus_pump = false,
      auto_mush = false,
      pump_mush = false,
      value = false;

  int hum_out = 0, _currentValue = 0, a = 0;

  void setdata_hum() {
    setState(() {
      a = hum_out;
      value = true;
      databaseRef.child('farmapp/mushroom').update({'sethum': hum_out});
      databaseRef.child('farmapp/mushroom').update({'value': value});
      Future.delayed(Duration(seconds: 5), () {
        databaseRef.child('farmapp/mushroom').update({'value': false});
        // code to be executed after 2 seconds
      });
    });
  }

  void autoButton() {
    setState(() {
      auto_mush = !auto_mush;
      databaseRef.child('farmapp/mushroom').update({'auto': auto_mush});
    });
  }

  void _toggleon() {
    setState(() {
      statuspump = 'ON';
      databaseRef.child('farmapp/mushroom').update({'pump': 1});
    });
  }

  void _toggleoff() {
    setState(() {
      statuspump = 'OFF';
      databaseRef.child('farmapp/mushroom').update({'pump': 0});
    });
  }

  void initState() {
    super.initState();
    getdata();
    getdata_pump();
    getdata_auto();
  }

  void getdata_auto() async {
    databaseRef.child('farmapp/mushroom/auto').onValue.listen((event) {
      final Object? getdataPump = event.snapshot.value;
      if (getdataPump == true) {
        setState(() {
          auto_mush = true;
        });
      } else {
        setState(() {
          auto_mush = false;
        });
      }
    });
  }

  void getdata_pump() async {
    databaseRef.child('farmapp/mushroom/pump').onValue.listen((event) {
      final Object? getdataPump = event.snapshot.value;
      if (getdataPump == true) {
        setState(() {
          pump_mush = true;
          statuspump = 'ON';
        });
      } else {
        setState(() {
          pump_mush = false;
          statuspump = 'OFF';
        });
      }
    });
  }

  void getdata() {
    databaseRef.child('farmapp/mushroom/humidity').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        humidity = '$getdata';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double a = double.parse(humidity);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ระบบโรงเพาะเห็ด'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 50),
                    LiteRollingSwitch(
                      value: widget.auto_mush,
                      textOn: "ON",
                      textOff: "OFF",
                      colorOff: Colors.red,
                      colorOn: Colors.green,
                      iconOn: Icons.done,
                      iconOff: Icons.do_disturb_off_outlined,
                      textSize: 18,
                      onChanged: (statusPump) async {},
                      onDoubleTap: (bool positon) {},
                      onTap: () {
                        setState(() {
                          autoButton();
                        });
                      },
                      onSwipe: () {},
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 10.0),
                    Text(
                      'เปิด-ปิด ระบบอัตโนมัติ',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      interval: 10,
                      startAngle: 150,
                      endAngle: 30,
                      showTicks: false,
                      showLabels: false,
                      axisLineStyle: AxisLineStyle(thickness: 20),
                      pointers: <GaugePointer>[
                        RangePointer(
                            value: a,
                            width: 20,
                            color: Color.fromARGB(255, 14, 158, 14),
                            enableAnimation: true,
                            cornerStyle: CornerStyle.bothCurve)
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(100),
                                  child: Text(
                                    'ความชื้นในอากาศ $humidity %',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                            angle: 300,
                            positionFactor: 0.1)
                      ])
                ]),
                Text(
                  'การทำงานระบบ : $statuspump',
                  style: const TextStyle(
                      fontSize: 30.0, color: Color.fromARGB(255, 214, 50, 44)),
                ),
                SizedBox(
                  height: 30,
                ),
                LiteRollingSwitch(
                  value: widget.pump_mush,
                  textOn: "ON",
                  textOff: "OFF",
                  colorOff: Colors.red,
                  colorOn: Colors.green,
                  iconOn: Icons.done,
                  iconOff: Icons.do_disturb_off_outlined,
                  textSize: 18,
                  onChanged: (statuspump) {},
                  onDoubleTap: (bool positon) {},
                  onTap: () {
                    setState(() {
                      pump_mush = !pump_mush;
                      databaseRef
                          .child('farmapp/mushroom')
                          .update({'pump': pump_mush});
                      if (pump_mush == true) {
                        statuspump = 'ON';
                      } else {
                        statuspump = 'OFF';
                      }
                    });
                  },
                  onSwipe: (statuspump) {},
                ),
                SizedBox(height: 10),
                NumberPicker(
                  value: hum_out,
                  minValue: 0,
                  maxValue: 100,
                  onChanged: (value) => setState(() => hum_out = value),
                ),
                SizedBox(height: 10),
                AnimatedButton(
                  color: Color.fromARGB(255, 57, 218, 65),
                  onPressed: setdata_hum,
                  enabled: true,
                  shadowDegree: ShadowDegree.light,
                  width: 150.0,
                  height: 50.0,
                  child: const Text(
                    'ตกลง',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
