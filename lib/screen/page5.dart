// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Page5 extends StatefulWidget {
  final bool pump_light, auto_light;

  Page5({
    Key? key,
    required this.pump_light,
    required this.auto_light,
  }) : super(key: key);

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  bool loading = false;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  String statuspump = '';
  var lux_in = '', image_on = '', image_off = '', lux_sensor = '';
  var time = DateTime.now();

  bool toggleValue = false,
      status_led = false,
      value = false,
      auto_light = false,
      pump_light = false,
      a = false;

  int lux = 0, _currentValue = 0;

  void setdata_timer() {
    setState(() {
      value = true;
      databaseRef.child('farmapp/light').update({'setlux': lux});
      databaseRef.child('farmapp/light').update({'value': value});
      Future.delayed(Duration(seconds: 7), () {
        databaseRef.child('farmapp/light').update({'value': false});
        // code to be executed after 2 seconds
      });
    });
  }

  void autoButton() {
    setState(() {
      auto_light = !auto_light;
      databaseRef.child('farmapp/light').update({'auto': auto_light});
      databaseRef.child('farmapp/light').update({'pumpn': false});
    });
  }

  void pumpButton() {
    setState(() {
      pump_light = !pump_light;
      databaseRef.child('farmapp/light').update({'pumpn': pump_light});
    });
  }

  @override
  void initState() {
    super.initState();
    getdata_setlux();
    getdata_lux();
    getdata_auto();
    getdata_pump();
  }

  void getdata_auto() async {
    databaseRef.child('farmapp/light/auto').onValue.listen((event) {
      final Object? getdataPump = event.snapshot.value;
      if (getdataPump == true) {
        setState(() {
          auto_light = true;
        });
      } else {
        setState(() {
          auto_light = false;
        });
      }
    });
  }

  void getdata_pump() async {
    databaseRef.child('farmapp/light/pump').onValue.listen((event) {
      final Object? getdataPump = event.snapshot.value;
      if (getdataPump == true) {
        setState(() {
          pump_light = true;
          statuspump = 'ON';
        });
      } else {
        setState(() {
          pump_light = false;
          statuspump = 'OFF';
        });
      }
    });
  }

  void getdata_setlux() async {
    databaseRef.child('farmapp/light/setlux').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        lux_in = '$getdata';
      });
    });
  }

  void getdata_lux() async {
    databaseRef.child('farmapp/light/lux').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        lux_sensor = '$getdata';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var a = double.parse(lux_sensor, (source) => -1);
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
                    LiteRollingSwitch(
                      value: widget.auto_light,
                      textOn: "Auto",
                      textOff: "Manual",
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
                Text(
                  'ค่าแสงที่ตั้งค่า : $lux_in',
                  style: const TextStyle(
                      fontSize: 30.0, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'ค่าแสงจากเซ็นเซอร์ : ${a.toStringAsFixed(0)}',
                  style: const TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 350,
                  width: 250,
                  child: Visibility(
                      replacement: Visibility(
                          child: Image.asset('image/app_image/led_off.png')),
                      visible: pump_light,
                      maintainSize: false,
                      maintainAnimation: false,
                      maintainState: false,
                      child: Image.asset('image/app_image/led.png')),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'หลอดไฟรอบฟาร์ม : $statuspump',
                  style: const TextStyle(
                      fontSize: 30.0, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text('ระบบแสงสว่างรอบฟาร์ม',
                    style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: !auto_light,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: LiteRollingSwitch(
                    value: widget.pump_light,
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
                  value: lux,
                  minValue: 0,
                  maxValue: 50000,
                  step: 100,
                  onChanged: (value) => setState(() => lux = value),
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
