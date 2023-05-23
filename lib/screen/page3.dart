// ignore_for_file: deprecated_member_use
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class Page3 extends StatefulWidget {
  final bool pump_chic, auto_chic;

  Page3({
    Key? key,
    required this.pump_chic,
    required this.auto_chic,
  }) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  bool loading = false;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  String statuspump = '';
  var time_chicken = '', secound_in = '';
  var time = DateTime.now();

  bool toggleValue = false,
      status_pump = false,
      auto_chic = false,
      pump_chic = false,
      value = false;

  int secound_out = 0, _currentValue = 0, a = 0;

  void autoButton() {
    setState(() {
      auto_chic = !auto_chic;
      databaseRef.child('farmapp/chicken').update({'auto': auto_chic});
    });
  }

  void setdata_timer() {
    setState(() {
      a = secound_out;
      value = true;
      databaseRef.child('farmapp/chicken').update({'times': secound_out});
      databaseRef.child('farmapp/chicken').update({'value': value});
      Future.delayed(Duration(seconds: 5), () {
        databaseRef.child('farmapp/chicken').update({'value': false});
        // code to be executed after 2 seconds
      });
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
    databaseRef.child('farmapp/chicken/auto').onValue.listen((event) {
      final Object? getdataPump = event.snapshot.value;
      if (getdataPump == true) {
        setState(() {
          auto_chic = true;
        });
      } else {
        setState(() {
          auto_chic = false;
        });
      }
    });
  }

  void getdata_pump() async {
    databaseRef.child('farmapp/chicken/pump').onValue.listen((event) {
      final Object? getdataPump = event.snapshot.value;
      if (getdataPump == true) {
        setState(() {
          pump_chic = true;
          statuspump = 'ON';
        });
      } else {
        setState(() {
          pump_chic = false;
          statuspump = 'OFF';
        });
      }
    });
  }

  void getdata() {
    databaseRef.child('farmapp/chicken/times').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        time_chicken = '$getdata';
      });
    });
  }

  void time_s() {
    databaseRef.child('farmapp/chicken/times').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        secound_in = '$getdata';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double b = double.parse(secound_in);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ระบบโรงเลี้ยงไก่'),
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
                      value: widget.auto_chic,
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
                            color: Color.fromARGB(255, 201, 52, 41),
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
                  'การทำงานระบบ : $statuspump',
                  style: const TextStyle(
                      fontSize: 30.0, color: Color.fromARGB(255, 214, 50, 44)),
                ),
                SizedBox(
                  height: 30,
                ),
                LiteRollingSwitch(
                  value: widget.pump_chic,
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
                      pump_chic = !pump_chic;
                      databaseRef
                          .child('farmapp/chicken')
                          .update({'pump': pump_chic});
                      if (pump_chic == true) {
                        statuspump = 'ON';
                      } else {
                        statuspump = 'OFF';
                      }
                    });
                  },
                  onSwipe: (bool positon) {},
                ),
                SizedBox(height: 20.0),
                NumberPicker(
                  value: secound_out,
                  minValue: 0,
                  maxValue: 60,
                  onChanged: (value) => setState(() => secound_out = value),
                ),
                SizedBox(height: 20.0),
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
