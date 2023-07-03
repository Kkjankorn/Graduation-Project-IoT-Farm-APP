// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Page4 extends StatefulWidget {
  final bool pump_fish, auto_fish;

  Page4({
    Key? key,
    required this.pump_fish,
    required this.auto_fish,
  }) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  bool loading = false;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  String statuspump = '';
  var time_fish = '', secound_in = '';
  var time = DateTime.now();

  bool toggleValue = false,
      status_pump = false,
      value = false,
      auto_fish = false,
      pump_fish = false;

  int secound_out = 0, _currentValue = 0, a = 0;

  void setdata_timer() {
    setState(() {
      a = secound_out;
      value = true;
      databaseRef.child('farmapp/fish').update({'times': secound_out});
      databaseRef.child('farmapp/fish').update({'value': value});
      Future.delayed(Duration(seconds: 7), () {
        databaseRef.child('farmapp/fish').update({'value': false});
        // code to be executed after 2 seconds
      });
    });
  }

  void autoButton() {
    setState(() {
      auto_fish = !auto_fish;
      databaseRef.child('farmapp/fish').update({'auto': auto_fish});
      databaseRef.child('farmapp/fish').update({'pump': false});
    });
  }

  void pumpButton() {
    setState(() {
      pump_fish = !pump_fish;
      databaseRef.child('farmapp/fish').update({'pump': pump_fish});
      if (pump_fish == true) {
        statuspump = 'ON';
      } else {
        statuspump = 'OFF';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
    getdata_auto();
    getdata_pump();
    time_s();
  }

  void getdata_auto() async {
    databaseRef.child('farmapp/fish/auto').onValue.listen((event) {
      final Object? getdataPump = event.snapshot.value;
      if (getdataPump == true) {
        setState(() {
          auto_fish = true;
        });
      } else {
        setState(() {
          auto_fish = false;
        });
      }
    });
  }

  void getdata_pump() async {
    databaseRef.child('farmapp/fish/pump').onValue.listen((event) {
      final Object? getdataPump = event.snapshot.value;
      if (getdataPump == true) {
        setState(() {
          pump_fish = true;
          statuspump = 'ON';
        });
      } else {
        setState(() {
          pump_fish = false;
          statuspump = 'OFF';
        });
      }
    });
  }

  void getdata() {
    databaseRef.child('farmapp/fish/times').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        time_fish = '$getdata';
      });
    });
  }

  void time_s() {
    databaseRef.child('farmapp/fish/times').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        secound_in = '$getdata';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var b = double.parse(secound_in, (source) => -1);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ระบบบ่อเลี้ยงปลา'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 50),
                    LiteRollingSwitch(
                      value: widget.auto_fish,
                      textOn: "ON",
                      textOff: "OFF",
                      colorOff: Colors.red,
                      colorOn: Colors.green,
                      iconOn: Icons.done,
                      iconOff: Icons.do_disturb_off_outlined,
                      animationDuration: Duration(milliseconds: 150),
                      textSize: 18,
                      onChanged: (statusPump) async {},
                      onDoubleTap: (bool positon) {},
                      onTap: () {
                        autoButton();
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
                SizedBox(height: 10.0),
                SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                      minimum: 0,
                      maximum: 60,
                      interval: 10,
                      startAngle: 150,
                      endAngle: 30,
                      showTicks: false,
                      showLabels: false,
                      axisLineStyle: AxisLineStyle(thickness: 20),
                      pointers: <GaugePointer>[
                        RangePointer(
                            value: b,
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
                                  padding: EdgeInsets.all(130),
                                  child: Text(
                                    'ระยะเวลาการให้อาหาร $secound_in วินาที',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                            angle: 300,
                            positionFactor: 0.1)
                      ])
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(height: 10.0),
                    Text(
                      '*เวลาให้อาหารอัตโนมัติ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(height: 10.0),
                    Text(
                      '08:00 น. และ 14:00 น.',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'มอเตอร์ปล่อยอาหาร : $statuspump',
                  style: const TextStyle(
                      fontSize: 30.0, color: Color.fromARGB(255, 214, 50, 44)),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: !auto_fish,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: LiteRollingSwitch(
                    value: widget.pump_fish,
                    textOn: "ON",
                    textOff: "OFF",
                    colorOff: Colors.red,
                    colorOn: Colors.green,
                    iconOn: Icons.done,
                    iconOff: Icons.do_disturb_off_outlined,
                    animationDuration: Duration(milliseconds: 150),
                    textSize: 18,
                    onChanged: (statuspump) {},
                    onDoubleTap: (bool positon) {},
                    onTap: () {
                      pumpButton();
                    },
                    onSwipe: (statuspump) {},
                  ),
                ),
                NumberPicker(
                  value: secound_out,
                  minValue: 0,
                  maxValue: 60,
                  onChanged: (value) => setState(() => secound_out = value),
                ),
                AnimatedButton(
                  color: Color.fromARGB(255, 57, 218, 65),
                  onPressed: setdata_timer,
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
